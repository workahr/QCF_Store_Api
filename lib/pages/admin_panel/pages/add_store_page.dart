import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/custom_text_field.dart';

import '../../../constants/app_assets.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/outline_btn_widget.dart';
import '../api_model/add_store_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

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
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController pannoController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();

  String? selectedDishType;

// Add Store
  Future addstoredetails() async {
    await apiService.getBearerToken();
    if (imageFile == null && widget.storeId == null) {
      showInSnackBar(context, 'Store image is required');
      return;
    }

    if (storeForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "username": userNameController.text,
        "password": userNameController.text,
        "fullname": ownerNameController.text,
        "mobile": mobileNumberController.text,
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
        // postData['id'] = widget.carId;
        postData = {
          "item_id": widget.storeId,
          "username": userNameController.text,
          "password": userNameController.text,
          "fullname": ownerNameController.text,
          "mobile": mobileNumberController.text,
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
      var result = await apiService.addstore(url, postData, imageFile);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      Addstoremodel response = addstoremodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MenuDetailsScreen(),
        //   ),
        // );
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
                  Text(
                    "User Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: userNameController,
                    // labelText: "Location",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "Password",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: passwordNameController,
                    // labelText: "Location",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "Store Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    control: storeNameController,
                    // labelText: "Store Name",
                    width: double.infinity,
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  Text(
                    "E mail",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: mailController,
                    // labelText: "Location",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  Text(
                    "Address",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: addressController,
                    //lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "City",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: cityController,
                    // lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "State",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: stateController,
                    // lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  Text(
                    "Pincode",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: zipcodeController,
                    // lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "Gst No.",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: gstController,
                    // lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),
                  Text(
                    "Pan No.",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: pannoController,
                    // lines: 3,
                    // labelText: "Address",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  Text(
                    "Owner Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: ownerNameController,
                    // labelText: "Preparator Name",
                    borderColor: Color(0xFFEEEEEE),
                  ),

                  Text(
                    "Mobile Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  CustomeTextField(
                    width: double.infinity,
                    control: mobileNumberController,
                    type: TextInputType.phone,
                    //labelText: "Mobile Number",
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
                        showActionSheet(context);
                      }),
                  SizedBox(height: 10),
                  Text(
                    "Note: Upload image with shop name",
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
                        type = 0;
                        showActionSheet(context);
                      }),
                  SizedBox(height: 20),
                  Text(
                    "Select Dish Type",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Veg Radio Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppAssets.veg_icon),
                          SizedBox(width: 5),
                          Text("Veg"),
                          Radio<String>(
                            value: "Veg",
                            groupValue: selectedDishType,
                            activeColor: AppColors.red,
                            onChanged: (val) {
                              setState(() {
                                selectedDishType = val;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(AppAssets.nonveg_icon),
                          SizedBox(width: 5),
                          Text("Non-Veg"),
                          Radio<String>(
                            value: "Non-Veg",
                            groupValue: selectedDishType,
                            activeColor: AppColors.red,
                            onChanged: (val) {
                              setState(() {
                                selectedDishType = val;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Both"),
                          Radio<String>(
                            value: "Both",
                            groupValue: selectedDishType,
                            activeColor: AppColors.red,
                            onChanged: (val) {
                              setState(() {
                                selectedDishType = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  // Save Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        addstoredetails();
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
                        "Save",
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
