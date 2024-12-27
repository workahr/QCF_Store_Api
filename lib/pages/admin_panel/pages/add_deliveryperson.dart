import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/pages/admin_panel/models/delivery_person_model.dart';
import 'package:namstore/pages/maincontainer.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/custom_text_field.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/edit_deliveryperson_model.dart';
import '../api_model/add_deliveryperson_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class AddDeliveryperson extends StatefulWidget {
  int? deliverypersonId;
  AddDeliveryperson({super.key, this.deliverypersonId});

  @override
  State<AddDeliveryperson> createState() => _AddDeliverypersonState();
}

class _AddDeliverypersonState extends State<AddDeliveryperson> {
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> DeliveryForm = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController anothermobileNumberController =
      TextEditingController();
  final TextEditingController licenseNoController = TextEditingController();
  final TextEditingController vehicleNoController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController rcNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.deliverypersonId != null) {
      getDeliverypersonById();
    }
  }

// Edit Delivery Person

  DeliveryPersonList? DeliveryPersonListpage;

  Future<void> getDeliverypersonById() async {
    try {
      await apiService.getBearerToken();
      var result =
          await apiService.getDeliverypersonById(widget.deliverypersonId);
      EditDeliveryPersonmodel response =
          editDeliveryPersonmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        setState(() {
          DeliveryPersonListpage = response.list; // Assign the store details

          userNameController.text = DeliveryPersonListpage?.username ?? '';
          passwordNameController.text = DeliveryPersonListpage?.password ?? '';
          fullNameController.text = DeliveryPersonListpage?.fullname ?? '';
          mobileNumberController.text = DeliveryPersonListpage?.mobile ?? '';
          anothermobileNumberController.text =
              DeliveryPersonListpage?.alternative_mobile ?? '';
          mailController.text = DeliveryPersonListpage?.email ?? '';
          licenseNoController.text = DeliveryPersonListpage?.licenseNo ?? '';
          vehicleNoController.text = DeliveryPersonListpage?.vehicleNo ?? '';
          vehicleNameController.text =
              DeliveryPersonListpage?.vehicleName ?? '';
          addressController.text = DeliveryPersonListpage?.address ?? '';
          cityController.text = DeliveryPersonListpage?.city ?? '';
          areaController.text = DeliveryPersonListpage?.area ?? '';
          zipcodeController.text = DeliveryPersonListpage?.pincode ?? '';
          liveimgSrc = DeliveryPersonListpage?.licenseFrontImg ?? '';
          liveimgSrc1 = DeliveryPersonListpage?.licenseBackImg ?? '';
          liveimgSrcRc = DeliveryPersonListpage?.vehicleImg ?? '';
          liveimgSrcPerson = DeliveryPersonListpage?.imageUrl ?? '';
        });
      } else {
        showInSnackBar(context, response.message);
      }
    } catch (e, stackTrace) {
      // Log or handle errors gracefully
      print("Error occurred: $e");
      print(stackTrace);
      showInSnackBar(context, "An unexpected error occurred.");
    }
  }

// Add Delivery Person

  Future adddeliveryperson() async {
    await apiService.getBearerToken();
    if (imageFile == null && widget.deliverypersonId == null) {
      showInSnackBar(context, 'License Front image is required');
      return;
    }
    if (imageFile1 == null && widget.deliverypersonId == null) {
      showInSnackBar(context, 'License Back image is required');
      return;
    }
    if (imageFileRc == null && widget.deliverypersonId == null) {
      showInSnackBar(context, 'Rc Book image is required');
      return;
    }
    if (imageFilePerson == null && widget.deliverypersonId == null) {
      showInSnackBar(context, 'Person image is required');
      return;
    }

    if (DeliveryForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "username": userNameController.text,
        "password": passwordNameController.text,
        "fullname": fullNameController.text,
        "mobile": mobileNumberController.text,
        "alternative_mobile": anothermobileNumberController.text,
        "email": mailController.text,
        "license_no": licenseNoController.text,
        "vehicle_no": vehicleNoController.text,
        "vehicle_name": vehicleNameController.text,
        "address": addressController.text,
        "city": cityController.text,
        "area": areaController.text,
        "pincode": zipcodeController.text,
      };
      print(postData);

      showSnackBar(context: context);
      // update-Car_management
      String url = 'v1/createdeliveryperson';
      if (widget.deliverypersonId != null) {
        // postData['id'] = widget.carId;
        postData = {
          "user_id": widget.deliverypersonId,
          "username": userNameController.text,
          "password": passwordNameController.text,
          "fullname": fullNameController.text,
          "mobile": mobileNumberController.text,
          "alternative_mobile": anothermobileNumberController.text,
          "email": mailController.text,
          "license_no": licenseNoController.text,
          "vehicle_no": vehicleNoController.text,
          "vehicle_name": vehicleNameController.text,
          "address": addressController.text,
          "city": cityController.text,
          "area": areaController.text,
          "pincode": zipcodeController.text,
        };
        url = 'v1/updatedeliveryperson';
      }
      var result = await apiService.adddeliveryperson(
          url, postData, imageFile, imageFile1, imageFileRc, imageFilePerson);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      AddDeliveryPersonmodel response = addDeliveryPersonmodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AdminMainContainer(admininitialPage: 2),
        //   ),
        // );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => AdminMainContainer(admininitialPage: 3)),
          (Route<dynamic> route) => false,
        );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  // license front image

  XFile? imageFile;
  File? imageSrc;
  String? liveimgSrc;

  getImage(ImageSource source) async {
    try {
      Navigator.pop(context);
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        imageSrc = File(pickedImage.path);
        getRecognizedText(pickedImage);
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedText(image) async {
    try {
      final inputImage = InputImage.fromFilePath(image.path);

      final textDetector = TextRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      final resVal = recognisedText.blocks.toList();
      List allDates = [];
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          for (Match match in matches) {
            allDates.add(match.group(0));
          }
        }
      }

      await textDetector.close();

      print(allDates); // For example, print the dates
    } catch (e) {
      showInSnackBar(context, e.toString());
    }
  }

  int type = 0;

  // license back image

  XFile? imageFile1;
  File? imageSrc1;
  String? liveimgSrc1;

  getImage1(ImageSource source1) async {
    try {
      Navigator.pop(context);
      final pickedImage1 = await ImagePicker().pickImage(source: source1);
      if (pickedImage1 != null) {
        imageFile1 = pickedImage1;
        imageSrc1 = File(pickedImage1.path);
        getRecognizedText1(pickedImage1);
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedText1(image1) async {
    try {
      final inputImage = InputImage.fromFilePath(image1.path);

      final textDetector = TextRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      final resVal = recognisedText.blocks.toList();
      List allDates = [];
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          for (Match match in matches) {
            allDates.add(match.group(0));
          }
        }
      }

      await textDetector.close();

      print(allDates); // For example, print the dates
    } catch (e) {
      showInSnackBar(context, e.toString());
    }
  }

  int type1 = 0;
  // license front image
  showActionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  await getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_rounded),
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
  // license back image

  showActionSheet1(BuildContext context1) {
    showModalBottomSheet(
        context: context1,
        builder: (BuildContext context1) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await getImage1(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  await getImage1(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_rounded),
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

// Rc Image

  XFile? imageFileRc;
  File? imageSrcRc;
  String? liveimgSrcRc;

  getImageRc(ImageSource sourceRc) async {
    try {
      Navigator.pop(context);
      final pickedImageRc = await ImagePicker().pickImage(source: sourceRc);
      if (pickedImageRc != null) {
        imageFileRc = pickedImageRc;
        imageSrcRc = File(pickedImageRc.path);
        getRecognizedTextRc(pickedImageRc);
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedTextRc(imageRc) async {
    try {
      final inputImage = InputImage.fromFilePath(imageRc.path);

      final textDetector = TextRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      final resVal = recognisedText.blocks.toList();
      List allDates = [];
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          for (Match match in matches) {
            allDates.add(match.group(0));
          }
        }
      }

      await textDetector.close();

      print(allDates); // For example, print the dates
    } catch (e) {
      showInSnackBar(context, e.toString());
    }
  }

  int typeRc = 0;

  showActionSheetRc(BuildContext contextRc) {
    showModalBottomSheet(
        context: contextRc,
        builder: (BuildContext contextRc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await getImageRc(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  await getImageRc(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_rounded),
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

// Person Image

  XFile? imageFilePerson;
  File? imageSrcPerson;
  String? liveimgSrcPerson;

  getImagePerson(ImageSource sourcePerson) async {
    try {
      Navigator.pop(context);
      final pickedImagePerson =
          await ImagePicker().pickImage(source: sourcePerson);
      if (pickedImagePerson != null) {
        imageFilePerson = pickedImagePerson;
        imageSrcPerson = File(pickedImagePerson.path);
        getRecognizedTextPerson(pickedImagePerson);
        setState(() {});
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognizedTextPerson(imagePerson) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePerson.path);

      final textDetector = TextRecognizer();
      RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      final resVal = recognisedText.blocks.toList();
      List allDates = [];
      for (TextBlock block in resVal) {
        for (TextLine line in block.lines) {
          String recognizedLine = line.text;
          RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
          Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

          for (Match match in matches) {
            allDates.add(match.group(0));
          }
        }
      }

      await textDetector.close();

      print(allDates); // For example, print the dates
    } catch (e) {
      showInSnackBar(context, e.toString());
    }
  }

  int typePerson = 0;

  showActionSheetPerson(BuildContext contextPerson) {
    showModalBottomSheet(
        context: contextPerson,
        builder: (BuildContext contextPerson) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await getImagePerson(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  await getImagePerson(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close_rounded),
                title: const Text('Close'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Color(0xFFE23744),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text("Add Delivery Person",
              style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: DeliveryForm,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomeTextField(
                    control: userNameController,
                    borderColor: AppColors.grey1,
                    labelText: 'Name',
                    width: double.infinity,
                    hint: 'Name',
                  ),
                  CustomeTextField(
                    control: passwordNameController,
                    borderColor: AppColors.grey1,
                    labelText: 'Password',
                    width: double.infinity,
                    hint: 'Password',
                  ),
                  CustomeTextField(
                    control: fullNameController,
                    borderColor: AppColors.grey1,
                    labelText: 'Full Name',
                    width: double.infinity,
                    hint: 'Full Name',
                  ),
                  CustomeTextField(
                    control: mobileNumberController,
                    borderColor: AppColors.grey1,
                    labelText: 'Mobile number',
                    width: double.infinity,
                    hint: 'Mobile number',
                    type: const TextInputType.numberWithOptions(),
                    inputFormaters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                    ],
                  ),
                  CustomeTextField(
                    control: anothermobileNumberController,
                    borderColor: AppColors.grey1,
                    labelText: 'Another Mobile number',
                    width: double.infinity,
                    hint: 'Another Mobile number',
                    type: const TextInputType.numberWithOptions(),
                    inputFormaters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                    ],
                  ),
                  CustomeTextField(
                    control: mailController,
                    borderColor: AppColors.grey1,
                    labelText: 'Email id',
                    width: double.infinity,
                    hint: 'Email id',
                  ),
                  CustomeTextField(
                    control: addressController,
                    // lines: 4,
                    borderColor: AppColors.grey1,
                    labelText: 'Address',
                    contentPadding: EdgeInsets.all(18),
                    width: double.infinity,
                    hint: 'Address',
                  ),
                  CustomeTextField(
                    control: areaController,
                    // lines: 4,
                    borderColor: AppColors.grey1,
                    labelText: 'Area',
                    contentPadding: EdgeInsets.all(18),
                    width: double.infinity,
                    hint: 'Area',
                  ),
                  CustomeTextField(
                    control: cityController,
                    // lines: 4,
                    borderColor: AppColors.grey1,
                    labelText: 'City',
                    contentPadding: EdgeInsets.all(18),
                    width: double.infinity,
                    hint: 'City',
                  ),
                  CustomeTextField(
                    control: zipcodeController,
                    // lines: 4,
                    borderColor: AppColors.grey1,
                    labelText: 'PinCode',
                    contentPadding: EdgeInsets.all(18),
                    width: double.infinity,
                    hint: 'PinCode',
                    type: const TextInputType.numberWithOptions(),
                    inputFormaters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^-?(\d+)?\.?\d{0,11}'))
                    ],
                  ),

                  CustomeTextField(
                    control: vehicleNoController,
                    borderColor: AppColors.grey1,
                    labelText: 'Vehicle Number',
                    width: double.infinity,
                    hint: 'Vehicle Number',
                  ),
                  CustomeTextField(
                    control: vehicleNameController,
                    borderColor: AppColors.grey1,
                    labelText: 'Vehicle Name',
                    width: double.infinity,
                    hint: 'Vehicle Name',
                  ),
                  CustomeTextField(
                    control: licenseNoController,
                    borderColor: AppColors.grey1,
                    labelText: 'Driving license number',
                    width: double.infinity,
                    hint: 'Driving license number',
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SubHeadingWidget(
                    title: 'Note: Upload front and back side of License image',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OutlineBtnWidget(
                      width: double.infinity,
                      fillColor: AppColors.n_blue.withOpacity(0.1),
                      borderColor: AppColors.n_blue,
                      title: 'Upload Driving  License Front side Photo',
                      titleColor: AppColors.n_blue,
                      icon: Icons.add_a_photo_rounded,
                      iconColor: AppColors.n_blue,
                      onTap: () {
                        type = 0;
                        showActionSheet(context);
                      }),
                  SizedBox(height: 10),
                  Center(
                    child: Stack(
                      children: [
                        liveimgSrc != "" &&
                                liveimgSrc != null &&
                                imageSrc == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imgBaseUrl +
                                            (liveimgSrc ?? ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: liveimgSrc == null
                                      ? Image.asset(
                                          AppAssets.user,
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                                ),
                              )
                            : imageSrc != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust the radius as needed
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(imageSrc!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlineBtnWidget(
                      width: double.infinity,
                      fillColor: AppColors.n_blue.withOpacity(0.1),
                      borderColor: const Color.fromRGBO(44, 84, 214, 1),
                      title: 'Upload Driving  License Back Side Photo',
                      titleColor: AppColors.n_blue,
                      icon: Icons.add_a_photo_rounded,
                      iconColor: AppColors.n_blue,
                      onTap: () {
                        type1 = 0;
                        showActionSheet1(context);
                      }),
                  SizedBox(height: 10),

                  Center(
                    child: Stack(
                      children: [
                        liveimgSrc1 != "" &&
                                liveimgSrc1 != null &&
                                imageSrc1 == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imgBaseUrl +
                                            (liveimgSrc1 ?? ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: liveimgSrc1 == null
                                      ? Image.asset(
                                          AppAssets.user,
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                                ),
                              )
                            : imageSrc1 != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust the radius as needed
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(imageSrc1!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // CustomeTextField(
                  //   borderColor: AppColors.grey1,
                  //   labelText: 'Rc book number',
                  //   width: double.infinity,
                  //   hint: 'Rc book number',
                  // ),
                  SubHeadingWidget(
                    title: 'Note: Upload front and back side of License image',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlineBtnWidget(
                      width: double.infinity,
                      fillColor: AppColors.n_blue.withOpacity(0.1),
                      borderColor: AppColors.n_blue,
                      title: 'Upload Rc Book Image',
                      titleColor: AppColors.n_blue,
                      icon: Icons.add_a_photo_rounded,
                      iconColor: AppColors.n_blue,
                      onTap: () {
                        typeRc = 0;
                        showActionSheetRc(context);
                      }),
                  // Rc Book Image
                  SizedBox(height: 10),
                  Center(
                    child: Stack(
                      children: [
                        liveimgSrcRc != "" &&
                                liveimgSrcRc != null &&
                                imageSrcRc == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imgBaseUrl +
                                            (liveimgSrcRc ?? ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: liveimgSrcRc == null
                                      ? Image.asset(
                                          AppAssets.user,
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                                ),
                              )
                            : imageSrcRc != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust the radius as needed
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(imageSrcRc!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  OutlineBtnWidget(
                      width: double.infinity,
                      fillColor: AppColors.n_blue.withOpacity(0.1),
                      borderColor: AppColors.n_blue,
                      title: 'Upload Passport Size Photo',
                      titleColor: AppColors.n_blue,
                      icon: Icons.add_a_photo_rounded,
                      iconColor: AppColors.n_blue,
                      onTap: () {
                        typePerson = 0;
                        showActionSheetPerson(context);
                      }),
                  SizedBox(height: 10),

                  // Person Image
                  Center(
                    child: Stack(
                      children: [
                        liveimgSrcPerson != "" &&
                                liveimgSrcPerson != null &&
                                imageSrcPerson == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        AppConstants.imgBaseUrl +
                                            (liveimgSrcPerson ?? ''),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: liveimgSrcPerson == null
                                      ? Image.asset(
                                          AppAssets.user,
                                          fit: BoxFit.fill,
                                        )
                                      : null,
                                ),
                              )
                            : imageSrcPerson != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust the radius as needed
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(imageSrcPerson!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: ButtonWidget(
                      borderRadius: 10,
                      title:
                          widget.deliverypersonId == null ? 'Save' : 'Update',
                      color: AppColors.red,
                      width: 150,
                      onTap: () {
                        if (userNameController.text == '' ||
                            userNameController.text == null) {
                          showInSnackBar(context, "Please Enter Username ");
                        } else if (passwordNameController.text == '' ||
                            passwordNameController.text == null) {
                          showInSnackBar(context, "Please Enter Password");
                          print("Please Enter Password ");
                        } else if (fullNameController.text == '' ||
                            fullNameController.text == null) {
                          showInSnackBar(context, "Please Enter Full Name ");
                        } else if (mobileNumberController.text == '' ||
                            mobileNumberController.text == null) {
                          showInSnackBar(
                              context, "Please Enter Mobile Number ");
                        } else if (addressController.text == '' ||
                            addressController.text == null) {
                          showInSnackBar(context, "Please Enter Address ");
                        } else if (cityController.text == '' ||
                            cityController.text == null) {
                          showInSnackBar(context, "Please Enter City ");
                        } else if (zipcodeController.text == '' ||
                            zipcodeController.text == null) {
                          showInSnackBar(context, "Please Enter Pincode");
                        } else if (vehicleNoController.text == '' ||
                            vehicleNoController.text == null) {
                          showInSnackBar(
                              context, "Please Enter Vehicle Number ");
                        } else if (vehicleNameController.text == '' ||
                            vehicleNameController.text == null) {
                          showInSnackBar(context, "Please Enter Vehicle Name");
                        } else if (licenseNoController.text == '' ||
                            licenseNoController.text == null) {
                          showInSnackBar(context, "Please Enter License No.");
                        } else {
                          adddeliveryperson();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
