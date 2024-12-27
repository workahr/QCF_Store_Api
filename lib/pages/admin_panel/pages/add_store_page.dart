import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/pages/maincontainer.dart';
import 'package:namstore/widgets/custom_text_field.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/outline_btn_widget.dart';
import '../api_model/add_store_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

import '../api_model/store_edit_model.dart';

class AddStorePage extends StatefulWidget {
  int? storeId;
  AddStorePage({super.key, this.storeId});
  @override
  _AddStorePageState createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController preparatorNameController =
      TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController anothermobileNumberController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController pannoController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.storeId != null) {
      getStoreById();
    }
  }

  UserList? storeDetails;
  ListStore? storeList;

  Future<void> getStoreById() async {
    try {
      await apiService.getBearerToken();
      var result = await apiService.getStoreById(widget.storeId);
      StoreEditmodel response = getStorebyidmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        setState(() {
          storeList = response.list; // Assign the store details
          storeDetails = response.userList; // Assign the user details

          // Safely assign values to controllers
          userNameController.text = storeDetails?.username ?? '';
          passwordNameController.text = storeDetails?.password ?? '';
          ownerNameController.text = storeDetails?.fullname ?? '';
          mobileNumberController.text = storeDetails?.mobile ?? '';
          anothermobileNumberController.text =
              storeList?.alternative_mobile ?? '';
          mailController.text = storeDetails?.email ?? '';
          storeNameController.text = storeList?.name ?? '';
          addressController.text = storeList?.address ?? '';
          cityController.text = storeList?.city ?? '';
          stateController.text = storeList?.state ?? '';
          gstController.text = storeList?.gstNo ?? '';
          pannoController.text = storeList?.panNo ?? '';
          zipcodeController.text = storeList?.zipcode ?? '';
          liveimgSrc = storeDetails?.imageUrl ?? '';
          liveimgSrc1 = storeList?.frontImg ?? '';
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

  // Future getStoreById() async {
  //   //isLoaded = true;
  //   // try {
  //   await apiService.getBearerToken();
  //   var result = await apiService.getStoreById(widget.storeId);
  //   GetStorebyidmodel response = getStorebyidmodelFromJson(result);
  //   print(response);
  //   if (response.status.toString() == 'SUCCESS') {
  //     setState(() {
  //       //userNameController.text = storeDetails!.username ?? '';
  //       // passwordNameController.text = storeDetails!.password ?? '';
  //       // ownerNameController.text = storeDetails!.fullname ?? '';
  //       // mobileNumberController.text = storeDetails!.mobile ?? '';
  //       // mailController.text = storeDetails!.email ?? '';
  //       storeNameController.text = storeList!.name ?? '';
  //       // addressController.text = storeDetails!.address ?? '';
  //       // cityController.text = storeDetails!.city ?? '';
  //       // stateController.text = storeList!.state ?? '';
  //       // gstController.text = storeList!.gstNo ?? '';
  //       // pannoController.text = storeList!.panNo ?? '';
  //       // zipcodeController.text = storeList!.zipcode ?? '';
  //       // liveimgSrc = storeDetails!.imageUrl ?? '';
  //       // liveimgSrc1 = storeList!.frontImg ?? '';
  //     });
  //   } else {
  //     showInSnackBar(context, "Data not found");
  //     //isLoaded = false;
  //   }
  // }

  String? selectedDishType;

// Add Store
  Future addstoredetails() async {
    await apiService.getBearerToken();
    if (imageFile == null && widget.storeId == null) {
      showInSnackBar(context, 'Image  is required');
      return;
    }
    if (imageFile1 == null && widget.storeId == null) {
      showInSnackBar(context, 'Image  is required');
      return;
    }

    if (storeForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "username": userNameController.text,
        "password": passwordNameController.text,
        "fullname": ownerNameController.text,
        "mobile": mobileNumberController.text,
        "alternative_mobile": anothermobileNumberController.text,
        "email": mailController.text,
        "name": storeNameController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "gst_no": gstController.text,
        "pan_no": pannoController.text,
        "zipcode": zipcodeController.text,
        "online_visibility": "Yes",
        "tags": "store1",
        "store_status": 1,
      };
      print(postData);

      showSnackBar(context: context);
      // update-Car_management
      String url = 'v1/createstore';
      if (widget.storeId != null) {
        postData = {
          "store_id": widget.storeId,
          "user_id": storeDetails?.id ?? '',
          "username": userNameController.text,
          "password": passwordNameController.text,
          "fullname": ownerNameController.text,
          "mobile": mobileNumberController.text,
          "alternative_mobile": anothermobileNumberController.text,
          "email": mailController.text,
          "name": storeNameController.text,
          "address": addressController.text,
          "city": cityController.text,
          "state": stateController.text,
          "gst_no": gstController.text,
          "pan_no": pannoController.text,
          "zipcode": zipcodeController.text,
          "online_visibility": "Yes",
          "tags": "store1",
          "store_status": 1,
        };
        url = 'v1/updatestore';
      }
      var result =
          await apiService.addstore(url, postData, imageFile, imageFile1);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      Addstoremodel response = addstoremodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pushNamedAndRemoveUntil(
        //     context, '/home', ModalRoute.withName('/home'));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AdminMainContainer(
        //       admininitialPage: 2,
        //     ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFE23744),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text("Add Store", style: TextStyle(color: Colors.white)),
        //centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: storeForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'User Name',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: userNameController,
                    labelText: "User Name",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Password',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: passwordNameController,
                    labelText: "Password",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'password',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    control: storeNameController,
                    labelText: "Store Name",
                    width: double.infinity,
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  // Text(
                  //   "E mail",
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: mailController,
                    labelText: "E mail",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Address',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: addressController,
                    //lines: 3,
                    labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'City',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: cityController,
                    // lines: 3,
                    labelText: "City",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'State',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: stateController,
                    // lines: 3,
                    labelText: "State",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Pincode',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: zipcodeController,
                    // lines: 3,
                    labelText: "Pincode",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // Text(
                  //   "Gst No.",
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: gstController,
                    // lines: 3,
                    labelText: "Gst Number (Optional)",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  // Text(
                  //   "Pan No.",
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: pannoController,
                    // lines: 3,
                    labelText: "Pan Number (Optional)",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Owner Name',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: ownerNameController,
                    labelText: "Owner Name",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Mobile Number',
                  //     style: TextStyle(color: Colors.black),
                  //     children: [
                  //       TextSpan(
                  //         text: '  *',
                  //         style: TextStyle(
                  //             color: Colors
                  //                 .red), // You can style the asterisk differently
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CustomeTextField(
                    width: double.infinity,
                    control: mobileNumberController,
                    type: TextInputType.phone,
                    labelText: "Mobile Number",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: anothermobileNumberController,
                    type: TextInputType.phone,
                    labelText: "Contact Number",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Note: Upload image with shop name",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  // Upload Store Image Button
                  OutlineBtnWidget(
                      title: 'Upload Store Image',
                      titleColor: Color(0xFF2C54D6),
                      fillColor: Color(0xFFF3F6FF),
                      iconColor: Color(0xFF2C54D6),
                      imageUrl: Image.asset(
                        AppAssets.image_plus_icon,
                        height: 25,
                        width: 25,
                      ),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      borderColor: Color(0xFF2C54D6),
                      onTap: () {
                        type = 0;
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
                                  width: 360,
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
                                      width: 360,
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
                  // Center(
                  //   child: Stack(
                  //     children: [
                  //       liveimgSrc != "" &&
                  //               liveimgSrc != null &&
                  //               imageSrc == null
                  //           ? ClipRRect(
                  //               borderRadius: BorderRadius.circular(16),
                  //               child: Container(
                  //                 width: 160,
                  //                 height: 160,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: NetworkImage(
                  //                       AppConstants.imgBaseUrl +
                  //                           (liveimgSrc ?? ''),
                  //                     ),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //                 child: liveimgSrc == null
                  //                     ? Image.asset(
                  //                         AppAssets.user,
                  //                         fit: BoxFit.fill,
                  //                       )
                  //                     : null,
                  //               ),
                  //             )
                  //           : imageSrc != null
                  //               ? ClipRRect(
                  //                   borderRadius: BorderRadius.circular(
                  //                       16), // Adjust the radius as needed
                  //                   child: Container(
                  //                     width: 160,
                  //                     height: 160,
                  //                     decoration: BoxDecoration(
                  //                       image: DecorationImage(
                  //                         image: FileImage(imageSrc!),
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               : SizedBox(),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Note: Upload a image of Shop Owner",
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  // Upload Passport Size Photo Button
                  OutlineBtnWidget(
                      title: 'Upload Passport Size Photo',
                      titleColor: Color(0xFF2C54D6),
                      fillColor: Color(0xFFF3F6FF),
                      iconColor: Color(0xFF2C54D6),
                      imageUrl: Image.asset(
                        AppAssets.image_plus_icon,
                        height: 25,
                        width: 25,
                      ),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      borderColor: Color(0xFF2C54D6),
                      onTap: () {
                        type1 = 0;
                        showActionSheet(context);
                      }),
                  SizedBox(height: 10),

                  // Center(
                  //   child: Stack(
                  //     children: [
                  //       liveimgSrc1 != "" &&
                  //               liveimgSrc1 != null &&
                  //               imageSrc1 == null
                  //           ? ClipRRect(
                  //               borderRadius: BorderRadius.circular(16),
                  //               child: Container(
                  //                 width: 160,
                  //                 height: 160,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: NetworkImage(
                  //                       AppConstants.imgBaseUrl +
                  //                           (liveimgSrc1 ?? ''),
                  //                     ),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //                 child: liveimgSrc1 == null
                  //                     ? Image.asset(
                  //                         AppAssets.user,
                  //                         fit: BoxFit.fill,
                  //                       )
                  //                     : null,
                  //               ),
                  //             )
                  //           : imageSrc1 != null
                  //               ? ClipRRect(
                  //                   borderRadius: BorderRadius.circular(
                  //                       16), // Adjust the radius as needed
                  //                   child: Container(
                  //                     width: 160,
                  //                     height: 160,
                  //                     decoration: BoxDecoration(
                  //                       image: DecorationImage(
                  //                         image: FileImage(imageSrc1!),
                  //                         fit: BoxFit.cover,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               : SizedBox(),
                  //     ],
                  //   ),
                  // ),
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
                  SizedBox(height: 20),
                  // Text(
                  //   "Select Dish Type",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  // // Veg Radio Button
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Image.asset(AppAssets.veg_icon),
                  //         SizedBox(width: 5),
                  //         Text("Veg"),
                  //         Radio<String>(
                  //           value: "Veg",
                  //           groupValue: selectedDishType,
                  //           activeColor: AppColors.red,
                  //           onChanged: (val) {
                  //             setState(() {
                  //               selectedDishType = val;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Image.asset(AppAssets.nonveg_icon),
                  //         SizedBox(width: 5),
                  //         Text("Non-Veg"),
                  //         Radio<String>(
                  //           value: "Non-Veg",
                  //           groupValue: selectedDishType,
                  //           activeColor: AppColors.red,
                  //           onChanged: (val) {
                  //             setState(() {
                  //               selectedDishType = val;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Text("Both"),
                  //         Radio<String>(
                  //           value: "Both",
                  //           groupValue: selectedDishType,
                  //           activeColor: AppColors.red,
                  //           onChanged: (val) {
                  //             setState(() {
                  //               selectedDishType = val;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 20),
                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (userNameController.text == '' ||
                            userNameController.text == null) {
                          showInSnackBar(context, "Please Enter Username ");
                        } else if (passwordNameController.text == '' ||
                            passwordNameController.text == null) {
                          showInSnackBar(context, "Please Enter Password");
                          print("Please Enter Password ");
                        } else if (storeNameController.text == '' ||
                            storeNameController.text == null) {
                          showInSnackBar(context, "Please Enter Store Name ");
                        } else if (addressController.text == '' ||
                            addressController.text == null) {
                          showInSnackBar(context, "Please Enter Address ");
                        } else if (cityController.text == '' ||
                            cityController.text == null) {
                          showInSnackBar(context, "Please Enter City ");
                        } else if (stateController.text == '' ||
                            stateController.text == null) {
                          showInSnackBar(context, "Please Enter State ");
                        } else if (zipcodeController.text == '' ||
                            zipcodeController.text == null) {
                          showInSnackBar(context, "Please Enter Pincode");
                        } else if (ownerNameController.text == '' ||
                            ownerNameController.text == null) {
                          showInSnackBar(context, "Please Enter Owner Name");
                        } else if (mobileNumberController.text == '' ||
                            mobileNumberController.text == null) {
                          showInSnackBar(
                              context, "Please Enter Mobile Number ");
                        } else {
                          addstoredetails();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        widget.storeId == null ? 'Save' : 'Update',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:namstore/constants/app_colors.dart';
// import 'package:namstore/pages/maincontainer.dart';
// import 'package:namstore/widgets/custom_text_field.dart';

// import '../../../constants/app_assets.dart';
// import '../../../constants/app_constants.dart';
// import '../../../services/comFuncService.dart';
// import '../../../services/nam_food_api_service.dart';
// import '../../../widgets/outline_btn_widget.dart';
// import '../api_model/add_store_model.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'dart:io';

// import '../api_model/store_edit_model.dart';

// class AddStorePage extends StatefulWidget {
//   int? storeId;
//   AddStorePage({super.key, this.storeId});
//   @override
//   _AddStorePageState createState() => _AddStorePageState();
// }

// class _AddStorePageState extends State<AddStorePage> {
//   final NamFoodApiService apiService = NamFoodApiService();
//   final GlobalKey<FormState> storeForm = GlobalKey<FormState>();

//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController passwordNameController = TextEditingController();
//   final TextEditingController ownerNameController = TextEditingController();
//   final TextEditingController mailController = TextEditingController();
//   final TextEditingController storeNameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController preparatorNameController =
//       TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();
//   final TextEditingController anothermobileNumberController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController gstController = TextEditingController();
//   final TextEditingController pannoController = TextEditingController();
//   final TextEditingController zipcodeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     if (widget.storeId != null) {
//       getStoreById();
//     }
//   }

//   UserList? storeDetails;
//   ListStore? storeList;

//   Future<void> getStoreById() async {
//     try {
//       await apiService.getBearerToken();
//       var result = await apiService.getStoreById(widget.storeId);
//       StoreEditmodel response = getStorebyidmodelFromJson(result);

//       if (response.status == 'SUCCESS') {
//         setState(() {
//           storeList = response.list; // Assign the store details
//           storeDetails = response.userList; // Assign the user details

//           // Safely assign values to controllers
//           userNameController.text = storeDetails?.username ?? '';
//           passwordNameController.text = storeDetails?.password ?? '';
//           ownerNameController.text = storeDetails?.fullname ?? '';
//           mobileNumberController.text = storeDetails?.mobile ?? '';
//           // anothermobileNumberController.text = storeDetails?.mobile ?? '';
//           mailController.text = storeDetails?.email ?? '';
//           storeNameController.text = storeList?.name ?? '';
//           addressController.text = storeList?.address ?? '';
//           cityController.text = storeList?.city ?? '';
//           stateController.text = storeList?.state ?? '';
//           gstController.text = storeList?.gstNo ?? '';
//           pannoController.text = storeList?.panNo ?? '';
//           zipcodeController.text = storeList?.zipcode ?? '';
//           liveimgSrc = storeDetails?.imageUrl ?? '';
//           liveimgSrc1 = storeList?.frontImg ?? '';
//         });
//       } else {
//         showInSnackBar(context, response.message);
//       }
//     } catch (e, stackTrace) {
//       // Log or handle errors gracefully
//       print("Error occurred: $e");
//       print(stackTrace);
//       showInSnackBar(context, "An unexpected error occurred.");
//     }
//   }

//   // Future getStoreById() async {
//   //   //isLoaded = true;
//   //   // try {
//   //   await apiService.getBearerToken();
//   //   var result = await apiService.getStoreById(widget.storeId);
//   //   GetStorebyidmodel response = getStorebyidmodelFromJson(result);
//   //   print(response);
//   //   if (response.status.toString() == 'SUCCESS') {
//   //     setState(() {
//   //       //userNameController.text = storeDetails!.username ?? '';
//   //       // passwordNameController.text = storeDetails!.password ?? '';
//   //       // ownerNameController.text = storeDetails!.fullname ?? '';
//   //       // mobileNumberController.text = storeDetails!.mobile ?? '';
//   //       // mailController.text = storeDetails!.email ?? '';
//   //       storeNameController.text = storeList!.name ?? '';
//   //       // addressController.text = storeDetails!.address ?? '';
//   //       // cityController.text = storeDetails!.city ?? '';
//   //       // stateController.text = storeList!.state ?? '';
//   //       // gstController.text = storeList!.gstNo ?? '';
//   //       // pannoController.text = storeList!.panNo ?? '';
//   //       // zipcodeController.text = storeList!.zipcode ?? '';
//   //       // liveimgSrc = storeDetails!.imageUrl ?? '';
//   //       // liveimgSrc1 = storeList!.frontImg ?? '';
//   //     });
//   //   } else {
//   //     showInSnackBar(context, "Data not found");
//   //     //isLoaded = false;
//   //   }
//   // }

//   String? selectedDishType;

// // Add Store
//   Future addstoredetails() async {
//     await apiService.getBearerToken();
//     if (imageFile == null && widget.storeId == null) {
//       showInSnackBar(context, 'Store image is required');
//       return;
//     }
//     if (imageFile1 == null && widget.storeId == null) {
//       showInSnackBar(context, 'Store image is required');
//       return;
//     }

//     if (storeForm.currentState!.validate()) {
//       Map<String, dynamic> postData = {
//         "username": userNameController.text,
//         "password": passwordNameController.text,
//         "fullname": ownerNameController.text,
//         "mobile": mobileNumberController.text,
//        //  "anothermobile": anothermobileNumberController.text,
//         "email": mailController.text,
//         "name": storeNameController.text,
//         "address": addressController.text,
//         "city": cityController.text,
//         "state": stateController.text,
//         "gst_no": gstController.text,
//         "pan_no": pannoController.text,
//         "zipcode": zipcodeController.text,
//         "online_visibility": "Yes",
//         "tags": "store1",
//         "store_status": 1,
//       };
//       print(postData);

//       showSnackBar(context: context);
//       // update-Car_management
//       String url = 'v1/createstore';
//       if (widget.storeId != null) {
//         // postData['id'] = widget.carId;
//         postData = {
//           "store_id": widget.storeId,
//           "user_id": storeDetails?.id ?? '',
//           "username": userNameController.text,
//           "password": passwordNameController.text,
//           "fullname": ownerNameController.text,
//           "mobile": mobileNumberController.text,
//           // "anothermobile": anothermobileNumberController.text,
//           "email": mailController.text,
//           "name": storeNameController.text,
//           "address": addressController.text,
//           "city": cityController.text,
//           "state": stateController.text,
//           "gst_no": gstController.text,
//           "pan_no": pannoController.text,
//           "zipcode": zipcodeController.text,
//           "online_visibility": "Yes",
//           "tags": "store1",
//           "store_status": 1,
//         };
//         url = 'v1/updatestore';
//       }
//       var result =
//           await apiService.addstore(url, postData, imageFile, imageFile1);
//       closeSnackBar(context: context);
//       setState(() {
//         // isLoading = false;
//       });
//       Addstoremodel response = addstoremodelFromJson(result);

//       if (response.status.toString() == 'SUCCESS') {
//         showInSnackBar(context, response.message.toString());
//         // Navigator.pushNamedAndRemoveUntil(
//         //     context, '/home', ModalRoute.withName('/home'));

//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => AdminMainContainer(
//         //       admininitialPage: 2,
//         //     ),
//         //   ),
//         // );

//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//               builder: (context) => AdminMainContainer(admininitialPage: 2)),
//           (Route<dynamic> route) => false,
//         );
//       } else {
//         print(response.message.toString());
//         showInSnackBar(context, response.message.toString());
//       }
//     }
//   }

//   XFile? imageFile;
//   File? imageSrc;
//   String? liveimgSrc;

//   getImage(ImageSource source) async {
//     try {
//       Navigator.pop(context);
//       final pickedImage = await ImagePicker().pickImage(source: source);
//       if (pickedImage != null) {
//         imageFile = pickedImage;
//         imageSrc = File(pickedImage.path);
//         getRecognizedText(pickedImage);
//         setState(() {});
//       }
//     } catch (e) {
//       setState(() {});
//     }
//   }

//   void getRecognizedText(image) async {
//     try {
//       final inputImage = InputImage.fromFilePath(image.path);

//       final textDetector = TextRecognizer();
//       RecognizedText recognisedText =
//           await textDetector.processImage(inputImage);
//       final resVal = recognisedText.blocks.toList();
//       List allDates = [];
//       for (TextBlock block in resVal) {
//         for (TextLine line in block.lines) {
//           String recognizedLine = line.text;
//           RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
//           Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

//           for (Match match in matches) {
//             allDates.add(match.group(0));
//           }
//         }
//       }

//       await textDetector.close();

//       print(allDates); // For example, print the dates
//     } catch (e) {
//       showInSnackBar(context, e.toString());
//     }
//   }

//   int type = 0;

//   XFile? imageFile1;
//   File? imageSrc1;
//   String? liveimgSrc1;

//   getImage1(ImageSource source1) async {
//     try {
//       Navigator.pop(context);
//       final pickedImage1 = await ImagePicker().pickImage(source: source1);
//       if (pickedImage1 != null) {
//         imageFile1 = pickedImage1;
//         imageSrc1 = File(pickedImage1.path);
//         getRecognizedText1(pickedImage1);
//         setState(() {});
//       }
//     } catch (e) {
//       setState(() {});
//     }
//   }

//   void getRecognizedText1(image1) async {
//     try {
//       final inputImage = InputImage.fromFilePath(image1.path);

//       final textDetector = TextRecognizer();
//       RecognizedText recognisedText =
//           await textDetector.processImage(inputImage);
//       final resVal = recognisedText.blocks.toList();
//       List allDates = [];
//       for (TextBlock block in resVal) {
//         for (TextLine line in block.lines) {
//           String recognizedLine = line.text;
//           RegExp dateRegex = RegExp(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b");
//           Iterable<Match> matches = dateRegex.allMatches(recognizedLine);

//           for (Match match in matches) {
//             allDates.add(match.group(0));
//           }
//         }
//       }

//       await textDetector.close();

//       print(allDates); // For example, print the dates
//     } catch (e) {
//       showInSnackBar(context, e.toString());
//     }
//   }

//   int type1 = 0;

//   showActionSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () async {
//                   await getImage(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () async {
//                   await getImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.close_rounded),
//                 title: const Text('Close'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   showActionSheet1(BuildContext context1) {
//     showModalBottomSheet(
//         context: context1,
//         builder: (BuildContext context1) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Gallery'),
//                 onTap: () async {
//                   await getImage1(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Camera'),
//                 onTap: () async {
//                   await getImage1(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.close_rounded),
//                 title: const Text('Close'),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xFFE23744),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//         title: Text("Add Store", style: TextStyle(color: Colors.white)),
//         //centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               key: storeForm,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'User Name',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: userNameController,
//                     labelText: "User Name",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'Password',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: passwordNameController,
//                     labelText: "Password",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'password',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     control: storeNameController,
//                     labelText: "Store Name",
//                     width: double.infinity,
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   // Text(
//                   //   "E mail",
//                   //   style: TextStyle(color: Colors.black),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: mailController,
//                     labelText: "E mail",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'Address',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: addressController,
//                     //lines: 3,
//                     labelText: "Address",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'City',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: cityController,
//                     // lines: 3,
//                     labelText: "City",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'State',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: stateController,
//                     // lines: 3,
//                     labelText: "State",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'Pincode',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: zipcodeController,
//                     // lines: 3,
//                     labelText: "Pincode",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // Text(
//                   //   "Gst No.",
//                   //   style: TextStyle(color: Colors.black),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: gstController,
//                     // lines: 3,
//                     labelText: "Gst Number (Optional)",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                   // Text(
//                   //   "Pan No.",
//                   //   style: TextStyle(color: Colors.black),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: pannoController,
//                     // lines: 3,
//                     labelText: "Pan Number (Optional)",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'Owner Name',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: ownerNameController,
//                     labelText: "Owner Name",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   // RichText(
//                   //   text: TextSpan(
//                   //     text: 'Mobile Number',
//                   //     style: TextStyle(color: Colors.black),
//                   //     children: [
//                   //       TextSpan(
//                   //         text: '  *',
//                   //         style: TextStyle(
//                   //             color: Colors
//                   //                 .red), // You can style the asterisk differently
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   CustomeTextField(
//                     width: double.infinity,
//                     control: mobileNumberController,
//                     type: TextInputType.phone,
//                     labelText: "Mobile Number",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),
//                    CustomeTextField(
//                     width: double.infinity,
//                     control: anothermobileNumberController,
//                     type: TextInputType.phone,
//                     labelText: "Contact Number",
//                     borderColor: Color(0xFFEEEEEE),
//                   ),

//                   SizedBox(height: 10),
//                   Text(
//                     "Note: Upload image with shop name",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   // Upload Store Image Button
//                   OutlineBtnWidget(
//                       title: 'Upload Store Image',
//                       titleColor: Color(0xFF2C54D6),
//                       fillColor: Color(0xFFF3F6FF),
//                       iconColor: Color(0xFF2C54D6),
//                       imageUrl: Image.asset(
//                         AppAssets.image_plus_icon,
//                         height: 25,
//                         width: 25,
//                       ),
//                       width: MediaQuery.of(context).size.width - 10,
//                       height: 50,
//                       borderColor: Color(0xFF2C54D6),
//                       onTap: () {
//                         type = 0;
//                         showActionSheet1(context);
//                       }),
//                   SizedBox(height: 10),

//                   Center(
//                     child: Stack(
//                       children: [
//                         liveimgSrc1 != "" &&
//                                 liveimgSrc1 != null &&
//                                 imageSrc1 == null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Container(
//                                   width: 360,
//                                   height: 160,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         AppConstants.imgBaseUrl +
//                                             (liveimgSrc1 ?? ''),
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   child: liveimgSrc1 == null
//                                       ? Image.asset(
//                                           AppAssets.user,
//                                           fit: BoxFit.fill,
//                                         )
//                                       : null,
//                                 ),
//                               )
//                             : imageSrc1 != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(
//                                         16), // Adjust the radius as needed
//                                     child: Container(
//                                       width: 360,
//                                       height: 160,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: FileImage(imageSrc1!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                       ],
//                     ),
//                   ),
//                   // Center(
//                   //   child: Stack(
//                   //     children: [
//                   //       liveimgSrc != "" &&
//                   //               liveimgSrc != null &&
//                   //               imageSrc == null
//                   //           ? ClipRRect(
//                   //               borderRadius: BorderRadius.circular(16),
//                   //               child: Container(
//                   //                 width: 160,
//                   //                 height: 160,
//                   //                 decoration: BoxDecoration(
//                   //                   image: DecorationImage(
//                   //                     image: NetworkImage(
//                   //                       AppConstants.imgBaseUrl +
//                   //                           (liveimgSrc ?? ''),
//                   //                     ),
//                   //                     fit: BoxFit.cover,
//                   //                   ),
//                   //                 ),
//                   //                 child: liveimgSrc == null
//                   //                     ? Image.asset(
//                   //                         AppAssets.user,
//                   //                         fit: BoxFit.fill,
//                   //                       )
//                   //                     : null,
//                   //               ),
//                   //             )
//                   //           : imageSrc != null
//                   //               ? ClipRRect(
//                   //                   borderRadius: BorderRadius.circular(
//                   //                       16), // Adjust the radius as needed
//                   //                   child: Container(
//                   //                     width: 160,
//                   //                     height: 160,
//                   //                     decoration: BoxDecoration(
//                   //                       image: DecorationImage(
//                   //                         image: FileImage(imageSrc!),
//                   //                         fit: BoxFit.cover,
//                   //                       ),
//                   //                     ),
//                   //                   ),
//                   //                 )
//                   //               : SizedBox(),
//                   //     ],
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Note: Upload a image of Shop Owner",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   SizedBox(height: 10),
//                   // Upload Passport Size Photo Button
//                   OutlineBtnWidget(
//                       title: 'Upload Passport Size Photo',
//                       titleColor: Color(0xFF2C54D6),
//                       fillColor: Color(0xFFF3F6FF),
//                       iconColor: Color(0xFF2C54D6),
//                       imageUrl: Image.asset(
//                         AppAssets.image_plus_icon,
//                         height: 25,
//                         width: 25,
//                       ),
//                       width: MediaQuery.of(context).size.width - 10,
//                       height: 50,
//                       borderColor: Color(0xFF2C54D6),
//                       onTap: () {
//                         type1 = 0;
//                         showActionSheet(context);
//                       }),
//                   SizedBox(height: 10),

//                   // Center(
//                   //   child: Stack(
//                   //     children: [
//                   //       liveimgSrc1 != "" &&
//                   //               liveimgSrc1 != null &&
//                   //               imageSrc1 == null
//                   //           ? ClipRRect(
//                   //               borderRadius: BorderRadius.circular(16),
//                   //               child: Container(
//                   //                 width: 160,
//                   //                 height: 160,
//                   //                 decoration: BoxDecoration(
//                   //                   image: DecorationImage(
//                   //                     image: NetworkImage(
//                   //                       AppConstants.imgBaseUrl +
//                   //                           (liveimgSrc1 ?? ''),
//                   //                     ),
//                   //                     fit: BoxFit.cover,
//                   //                   ),
//                   //                 ),
//                   //                 child: liveimgSrc1 == null
//                   //                     ? Image.asset(
//                   //                         AppAssets.user,
//                   //                         fit: BoxFit.fill,
//                   //                       )
//                   //                     : null,
//                   //               ),
//                   //             )
//                   //           : imageSrc1 != null
//                   //               ? ClipRRect(
//                   //                   borderRadius: BorderRadius.circular(
//                   //                       16), // Adjust the radius as needed
//                   //                   child: Container(
//                   //                     width: 160,
//                   //                     height: 160,
//                   //                     decoration: BoxDecoration(
//                   //                       image: DecorationImage(
//                   //                         image: FileImage(imageSrc1!),
//                   //                         fit: BoxFit.cover,
//                   //                       ),
//                   //                     ),
//                   //                   ),
//                   //                 )
//                   //               : SizedBox(),
//                   //     ],
//                   //   ),
//                   // ),
//                   Center(
//                     child: Stack(
//                       children: [
//                         liveimgSrc != "" &&
//                                 liveimgSrc != null &&
//                                 imageSrc == null
//                             ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: Container(
//                                   width: 160,
//                                   height: 160,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image: NetworkImage(
//                                         AppConstants.imgBaseUrl +
//                                             (liveimgSrc ?? ''),
//                                       ),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   child: liveimgSrc == null
//                                       ? Image.asset(
//                                           AppAssets.user,
//                                           fit: BoxFit.fill,
//                                         )
//                                       : null,
//                                 ),
//                               )
//                             : imageSrc != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(
//                                         16), // Adjust the radius as needed
//                                     child: Container(
//                                       width: 160,
//                                       height: 160,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: FileImage(imageSrc!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Text(
//                   //   "Select Dish Type",
//                   //   style: TextStyle(fontWeight: FontWeight.bold),
//                   // ),
//                   // // Veg Radio Button
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   //     Row(
//                   //       children: [
//                   //         Image.asset(AppAssets.veg_icon),
//                   //         SizedBox(width: 5),
//                   //         Text("Veg"),
//                   //         Radio<String>(
//                   //           value: "Veg",
//                   //           groupValue: selectedDishType,
//                   //           activeColor: AppColors.red,
//                   //           onChanged: (val) {
//                   //             setState(() {
//                   //               selectedDishType = val;
//                   //             });
//                   //           },
//                   //         ),
//                   //       ],
//                   //     ),
//                   //     Row(
//                   //       children: [
//                   //         Image.asset(AppAssets.nonveg_icon),
//                   //         SizedBox(width: 5),
//                   //         Text("Non-Veg"),
//                   //         Radio<String>(
//                   //           value: "Non-Veg",
//                   //           groupValue: selectedDishType,
//                   //           activeColor: AppColors.red,
//                   //           onChanged: (val) {
//                   //             setState(() {
//                   //               selectedDishType = val;
//                   //             });
//                   //           },
//                   //         ),
//                   //       ],
//                   //     ),
//                   //     Row(
//                   //       children: [
//                   //         Text("Both"),
//                   //         Radio<String>(
//                   //           value: "Both",
//                   //           groupValue: selectedDishType,
//                   //           activeColor: AppColors.red,
//                   //           onChanged: (val) {
//                   //             setState(() {
//                   //               selectedDishType = val;
//                   //             });
//                   //           },
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ],
//                   // ),

//                   SizedBox(height: 20),
//                   // Save Button
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (userNameController.text == '' ||
//                             userNameController.text == null) {
//                           showInSnackBar(context, "Please Enter Username ");
//                         } else if (passwordNameController.text == '' ||
//                             passwordNameController.text == null) {
//                           showInSnackBar(context, "Please Enter Password");
//                           print("Please Enter Password ");
//                         } else if (storeNameController.text == '' ||
//                             storeNameController.text == null) {
//                           showInSnackBar(context, "Please Enter Store Name ");
//                         } else if (addressController.text == '' ||
//                             addressController.text == null) {
//                           showInSnackBar(context, "Please Enter Address ");
//                         } else if (cityController.text == '' ||
//                             cityController.text == null) {
//                           showInSnackBar(context, "Please Enter City ");
//                         } else if (stateController.text == '' ||
//                             stateController.text == null) {
//                           showInSnackBar(context, "Please Enter State ");
//                         } else if (zipcodeController.text == '' ||
//                             zipcodeController.text == null) {
//                           showInSnackBar(context, "Please Enter Pincode");
//                         } else if (ownerNameController.text == '' ||
//                             ownerNameController.text == null) {
//                           showInSnackBar(context, "Please Enter Owner Name");
//                         } else if (mobileNumberController.text == '' ||
//                             mobileNumberController.text == null) {
//                           showInSnackBar(
//                               context, "Please Enter Mobile Number ");
//                         } else {
//                           addstoredetails();
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.red,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 14, horizontal: 80),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         widget.storeId == null ? 'Save' : 'Update',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }