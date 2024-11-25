import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/outline_btn_widget.dart';

class EditMenu extends StatefulWidget {
  @override
  _EditMenuState createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  String? selectedCategory;
  TextEditingController dishNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isVeg = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dishNameController.text = " Chicken Briyani";
    priceController.text = "120.00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE23744),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 80,
        title: Text(
          'Menu Edit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Categories",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                hint: Text('Select Category'),
                items: ['Category 1', 'Category 2', 'Category 3']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 225, 225, 225),
                        width: 1.5), // Set enabled border color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.5), // Set focused border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: 13),
              Text("Dish Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              CustomeTextField(
                control: dishNameController,
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
                borderColor: Color.fromARGB(255, 225, 225, 225),
              ),
              SizedBox(height: 13),
              Text("Enter a price",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              CustomeTextField(
                control: priceController,
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
                borderColor: Color.fromARGB(255, 225, 225, 225),
                // boxRadius: BorderRadius.all(Radius.circular(1)),
              ),
              SizedBox(height: 13),
              Text("Select Dish Type",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: isVeg,
                        onChanged: (value) {
                          setState(() {
                            isVeg = value as bool;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                      Image.asset(AppAssets.nonveg_icon),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Non-Veg", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: isVeg,
                        onChanged: (value) {
                          setState(() {
                            isVeg = value as bool;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Image.asset(AppAssets.veg_icon),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Veg", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text("Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              CustomeTextField(
                control: descriptionController,
                lines: 4,
                borderColor: Color.fromARGB(255, 225, 225, 225),
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 16),
              DottedBorder(
                  color: Colors.grey.shade300,
                  strokeWidth: 1.5,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [6, 3],
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image Preview
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          AppAssets.store_menu_briyani,
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      // File Name
                      Expanded(
                        child: Text(
                          "20241103_16.jpg",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Close Icon
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey),
                        onPressed: () {},
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Save button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Save",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
