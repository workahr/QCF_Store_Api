import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/svgiconButtonWidget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../widgets/button1_widget.dart';
import '../../widgets/custom_text_field.dart';

class MenuCategorie extends StatefulWidget {
  const MenuCategorie({super.key});

  @override
  State<MenuCategorie> createState() => _MenuCategorieState();
}

class _MenuCategorieState extends State<MenuCategorie> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController formattedCategoryNameController =
      TextEditingController();
  TextEditingController ordernoController = TextEditingController();

  TextEditingController categoryDescriptionController = TextEditingController();

  void _showAddCategoryDialog() {
    categoryNameController.addListener(() {
      final formattedText =
          categoryNameController.text.toLowerCase().replaceAll(' ', '-');
      formattedCategoryNameController.value =
          formattedCategoryNameController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Category Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                CustomeTextField(
                  control: categoryNameController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: Color.fromARGB(255, 225, 225, 225),
                ),
                SizedBox(height: 5),
                Text(
                  "Serial Order No.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
                CustomeTextField(
                  control: ordernoController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: Color.fromARGB(255, 225, 225, 225),
                ),
                SizedBox(height: 5),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2),
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
                    child: ElevatedButton(
                      onPressed: () {
                        categoryNameController.removeListener(() {});
                        // addcategory();
                        print(
                            'Formatted Category Name: ${formattedCategoryNameController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      // Clean up the listener after dialog closes
      categoryNameController.removeListener(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Categories list',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
              padding:
                  EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset(AppAssets.search_icon),
                  hintText: 'Search..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              )),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingWidget(
                                    title: 'Categories Name:',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  HeadingWidget(
                                    title: 'Indian Masala Food',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.00,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: AppColors.red)),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      size: 24,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Spacing between
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: AppColors.red)),
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 24,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          HeadingWidget(
                            title: 'Description:',
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          HeadingWidget(
                            title:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.:',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.00,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: SvgIconButtonWidget(
        title: 'Add New Categories',
        fontSize: 20.00,
        leadingIcon: Icon(
          Icons.add,
          size: 24,
        ),
        borderColor: (Colors.transparent),
        color: AppColors.red,
        onTap: () {
          _showAddCategoryDialog();
        },
      )),
    );
  }
}
