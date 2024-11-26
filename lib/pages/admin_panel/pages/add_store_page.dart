import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/custom_text_field.dart';

import '../../../constants/app_assets.dart';
import '../../../widgets/outline_btn_widget.dart';

class AddStorePage extends StatefulWidget {
  @override
  _AddStorePageState createState() => _AddStorePageState();
}

class _AddStorePageState extends State<AddStorePage> {
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController preparatorNameController =
      TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  String? selectedDishType;

  void saveData() {
    // Save the data or perform desired actions
    print("Store Name: ${storeNameController.text}");
    print("Location: ${locationController.text}");
    print("Address: ${addressController.text}");
    print("Preparator Name: ${preparatorNameController.text}");
    print("Mobile Number: ${mobileNumberController.text}");
    print("Dish Type: $selectedDishType");
  }

  @override
  void dispose() {
    // Dispose controllers to free up memory
    storeNameController.dispose();
    locationController.dispose();
    addressController.dispose();
    preparatorNameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                "Location",
                style: TextStyle(color: Colors.black),
              ),
              CustomeTextField(
                width: double.infinity,
                control: locationController,
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
                lines: 3,
                // labelText: "Address",
                borderColor: Color(0xFFEEEEEE),
              ),

              Text(
                "Preparator Name",
                style: TextStyle(color: Colors.black),
              ),
              CustomeTextField(
                width: double.infinity,
                control: preparatorNameController,
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
                  onTap: () {}),
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
                  onTap: () {}),
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
                  onPressed: saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 80),
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
          ),
        ),
      ),
    );
  }
}
