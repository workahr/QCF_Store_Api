import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/outline_btn_widget.dart';

class AddNewMenu extends StatefulWidget {
  @override
  _AddNewMenuState createState() => _AddNewMenuState();
}

class _AddNewMenuState extends State<AddNewMenu> {
  String? selectedCategory;
  TextEditingController dishNameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryDescriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isVeg = true;

  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Category Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                CustomeTextField(
                  control: categoryNameController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: Color.fromARGB(255, 225, 225, 225),
                ),
                SizedBox(height: 16),
                Text("Description",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                CustomeTextField(
                  control: categoryDescriptionController,
                  lines: 3,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: Color.fromARGB(255, 225, 225, 225),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    // height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Save",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
          'Add New Menu',
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
              SizedBox(height: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                          width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                TextButton(
                  onPressed: _showAddCategoryDialog,
                  child: Text(
                    'Add New Categories',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                    width: 150,
                    child: Divider(
                      color: AppColors.red,
                    ))
              ]),
              SizedBox(height: 6),
              Text("Dish Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              CustomeTextField(
                control: dishNameController,
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
                borderColor: Color.fromARGB(255, 225, 225, 225),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              OutlineBtnWidget(
                  title: 'Upload Image of Dish',
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
              SizedBox(height: 8),
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                //height: 45,
                child: ElevatedButton(
                  onPressed: () {},
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
