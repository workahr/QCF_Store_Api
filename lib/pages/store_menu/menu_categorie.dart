import 'package:flutter/material.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/svgiconButtonWidget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';

import '../models/delete_menu_category_api_model.dart';

import '../models/edit_menu_category_api_model.dart';
import '../models/update_menu_category_api_model.dart';
import 'add_category_model.dart';
import 'category_list_model.dart';

class MenuCategorie extends StatefulWidget {
  final int? category;
  MenuCategorie({super.key, this.category});

  @override
  State<MenuCategorie> createState() => _MenuCategorieState();
}

class _MenuCategorieState extends State<MenuCategorie> {
  final NamFoodApiService apiService = NamFoodApiService();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController formattedCategoryNameController =
      TextEditingController();
  TextEditingController ordernoController = TextEditingController();
  TextEditingController categoryDescriptionController = TextEditingController();
  TextEditingController editcategoryNameController = TextEditingController();
  TextEditingController editformattedCategoryNameController =
      TextEditingController();
  TextEditingController editordernoController = TextEditingController();
  TextEditingController editcategoryDescriptionController =
      TextEditingController();

  List<CategoryList>? CategoryListdata;
  List<CategoryList>? categoryListDataAll;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
    // if (widget.category != null) {
    //   // getCategoryById();
    // }
  }

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getcategoryList();
    var response = categoryListmodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        CategoryListdata = response.list;
        categoryListDataAll = CategoryListdata;
        isLoading = false;
      });
    } else {
      setState(() {
        CategoryListdata = [];
        categoryListDataAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
  }

  Future<void> addCategory() async {
    Map<String, dynamic> postData = {
      "category_name": categoryNameController.text,
      "description": categoryDescriptionController.text,
      "slug": formattedCategoryNameController.text,
      "serial": ordernoController.text,
    };
    var result = await apiService.addcategory(postData);
    AddCategorymodel response = addCategorymodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context);
      categoryNameController.clear();
      categoryDescriptionController.clear();
      formattedCategoryNameController.clear();
      ordernoController.clear();
      getCategoryList();
    } else {
      showInSnackBar(context, response.message.toString());
    }
  }

  // EditCategory? categoriesDetails;

  // Future getCategoryById(categoryid) async {
  //   await apiService.getBearerToken();
  //   var result = await apiService.getcategorybyid(categoryid);
  //   EditCategoryByIdModel response = editCategoryByIdModelFromJson(result);
  //   if (response.status.toString() == 'SUCCESS') {
  //     setState(() {
  //       categoriesDetails = response.list;
  //       editcategoryNameController.text = categoryDetails?.categoryName ?? '';
  //       editordernoController.text = categoryDetails?.serial.toString() ?? '';
  //       editcategoryDescriptionController.text =
  //           categoryDetails?.description ?? '';
  //       print(categoriesDetails?.categoryName);
  //       print("categoryname ${editcategoryNameController.text}");
  //     });
  //     _showEditCategoryDialog();
  //   } else {
  //     showInSnackBar(context, "Data not found");
  //   }
  // }

  EditCategory? categoriesDetails;

  Future<void> getCategoryById(String categoryId) async {
    // Fetch bearer token
    await apiService.getBearerToken();

    // Fetch category details by ID
    var result = await apiService.getcategorybyid(categoryId);
    EditCategoryByIdModel response = editCategoryByIdModelFromJson(result);

    // Check response status
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        categoriesDetails = response.list;
        editcategoryNameController.text = categoriesDetails?.categoryName ?? '';
        editordernoController.text = categoriesDetails?.serial.toString() ?? '';
        editcategoryDescriptionController.text =
            categoriesDetails?.description ?? '';
      });

      // Debugging prints
      print("Category Name: ${categoriesDetails?.categoryName}");
      print("Text Controller Value: ${editcategoryNameController.text}");

      // Show edit dialog
      _showEditCategoryDialog();
    } else {
      // Handle failure
      showInSnackBar(context, "Data not found");
    }
  }

//delete
  Future<void> deletecategorybyid(String categoryId) async {
    await apiService.getBearerToken();
    Map<String, dynamic> postData = {
      "id": categoryId,
    };
    var result = await apiService.deletecategorybyid(postData);
    DeleteStoreByIdModel response = deleteStoreByIdModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      getCategoryList();
    } else {
      showInSnackBar(context, response.message.toString());
    }
  }

  // update

  Future updateItemCategory() async {
    await apiService.getBearerToken();
    // if (thirdpartyForm.currentState!.validate()) {
    Map<String, dynamic> postData = {
      "category_id": categoriesDetails?.categoryId,
      "category_name": editcategoryNameController.text,
      "description": editcategoryDescriptionController.text,
      "slug": editformattedCategoryNameController.text,
      "serial": editordernoController.text,
    };
    print("updateItemCategory $postData");
    var result = await apiService.updateItemCategory(postData);

    UpdateItemCategoryModel response = updateItemCategoryModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context, {'update': true});
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Third_party_List(),
      //   ),
      // );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
    // } else {
    //   // showInSnackBar(context, "Please fill all fields");
    // }
  }

//add
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
          title: const Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("Category Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: categoryNameController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 5),
                const Text("Serial Order No.",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: ordernoController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 5),
                const Text("Description",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: categoryDescriptionController,
                  lines: 3,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ElevatedButton(
                      onPressed: () {
                        categoryNameController.removeListener(() {});
                        addCategory();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Save",
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
    ).then((_) {
      categoryNameController.removeListener(() {});
    });
  }

//edit
  void _showEditCategoryDialog() {
    editcategoryDescriptionController.addListener(() {
      final formattedText =
          editcategoryNameController.text.toLowerCase().replaceAll(' ', '-');
      editformattedCategoryNameController.value =
          editformattedCategoryNameController.value.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("Category Name",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: editcategoryNameController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 5),
                const Text("Serial Order No.",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: editordernoController,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 5),
                const Text("Description",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                CustomeTextField(
                  control: editcategoryDescriptionController,
                  lines: 3,
                  borderRadius: BorderRadius.circular(8),
                  width: MediaQuery.of(context).size.width,
                  borderColor: const Color.fromARGB(255, 225, 225, 225),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: ElevatedButton(
                      onPressed: () {
                        editcategoryNameController.removeListener(() {});
                        // addCategory();
                        updateItemCategory();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Update",
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
    ).then((_) {
      editcategoryNameController.removeListener(() {});
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
              itemCount: CategoryListdata!.length,
              itemBuilder: (context, index) {
                final e = CategoryListdata![index];
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
                                    title: e.categoryName.toString(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.00,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      getCategoryById(
                                        e.categoryId.toString(),
                                      );
                                    },
                                    child: Container(
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
                                  ),
                                  const SizedBox(width: 10), // Spacing between
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        deletecategorybyid(
                                          e.categoryId.toString(),
                                        );
                                      });
                                    },
                                    child: Container(
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
                            title: e.description.toString() == "null"
                                ? ' '
                                : e.description.toString(),
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







// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:namstore/widgets/button_widget.dart';
// import 'package:namstore/widgets/heading_widget.dart';
// import 'package:namstore/widgets/svgiconButtonWidget.dart';

// import '../../constants/app_assets.dart';
// import '../../constants/app_colors.dart';
// import '../../services/comFuncService.dart';
// import '../../services/nam_food_api_service.dart';
// import '../../widgets/button1_widget.dart';
// import '../../widgets/custom_text_field.dart';
// import '../admin_panel/models/delete_menu_category_api_model.dart';
// import 'add_category_model.dart';
// import 'category_list_model.dart';

// class MenuCategorie extends StatefulWidget {
//   int? category;
//   MenuCategorie({super.key, this.category});

//   @override
//   State<MenuCategorie> createState() => _MenuCategorieState();
// }

// class _MenuCategorieState extends State<MenuCategorie> {
//   final NamFoodApiService apiService = NamFoodApiService();
//   TextEditingController categoryNameController = TextEditingController();
//   TextEditingController formattedCategoryNameController =
//       TextEditingController();
//   TextEditingController ordernoController = TextEditingController();

//   TextEditingController categoryDescriptionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     getcategoryList();
//     if (widget.category != null) {
//       getcategorybyid();
//     }
//   }

//   List<CategoryList>? CategoryListdata;
//   List<CategoryList>? CategoryListdataAll;

//   bool isLoading = false;
//   Future getcategoryList() async {
//     setState(() {
//       isLoading = true;
//     });
//     await apiService.getBearerToken();
//     var result = await apiService.getcategoryList();
//     var response = categoryListmodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         CategoryListdata = response.list;
//         CategoryListdataAll = CategoryListdata;
//         isLoading = false;
//         // if (widget.menuId != null) {
//         //   selectedcategoryArray();
//         // }
//       });
//     } else {
//       setState(() {
//         CategoryListdata = [];
//         CategoryListdataAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//     setState(() {});
//   }

//   // Add Category

//   Future addcategory() async {
//     Map<String, dynamic> postData = {
//       "category_name": categoryNameController.text,
//       "description": categoryDescriptionController.text,
//       "slug": formattedCategoryNameController.text,
//       "serial": ordernoController.text
//     };
//     print('postData $postData');

//     var result = await apiService.addcategory(postData);
//     print('result $result');
//     AddCategorymodel response = addCategorymodelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       Navigator.pop(context);
//       categoryNameController.text = '';
//       categoryDescriptionController.text = '';
//       formattedCategoryNameController.text = '';
//       ordernoController.text = '';
//       getcategoryList();
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   CategoryList? categoryDetails;

//   Future getcategorybyid() async {
//     //isLoaded = true;
//     // try {
//     await apiService.getBearerToken();
//     var result = await apiService.getcategorybyid(widget.category);
//     AddCategorymodel response = addCategorymodelFromJson(result);
//     print(response);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         CategoryListdata = response.list;
//         categoryNameController.text = categoryDetails!.categoryName ?? '';
//         ordernoController.text = categoryDetails!.serial.toString() ?? '';
//         categoryDescriptionController.text = categoryDetails!.description ?? '';

//         // selectedyes = carDetails!.rental ?? '';
//         // selectedcategoryId = categoryDetails!.itemCategoryId;

//         // if (referList.isNotEmpty) {
//         //   selectedrentalyesornoArray();
//         // } else {
//         //   selectedrentalyesornoArray1();
//         // }
//       });
//       getcategoryList();
//     } else
//       showInSnackBar(context, "Data not found");
//       //isLoaded = false;
//     }
//   }

// //Delete

//   Future deletecategorybyid(String  categoryId) async {
//     await apiService.getBearerToken();

//     Map<String, dynamic> postData = {

//       "id": categoryId
//     };
//     print("delete $postData");

//     var result = await apiService.deleteStoreById(postData);
//     DeleteStoreByIdModel response = deleteStoreByIdModelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       setState(() {
//         getcategoryList();
//       });
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   void _showAddCategoryDialog(id) {
//     categoryNameController.addListener(() {
//       final formattedText =
//           categoryNameController.text.toLowerCase().replaceAll(' ', '-');
//       formattedCategoryNameController.value =
//           formattedCategoryNameController.value.copyWith(
//         text: formattedText,
//         selection: TextSelection.collapsed(offset: formattedText.length),
//       );
//     });

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add New Category'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   "Category Name",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 2),
//                 CustomeTextField(
//                   control: categoryNameController,
//                   borderRadius: BorderRadius.circular(8),
//                   width: MediaQuery.of(context).size.width,
//                   borderColor: Color.fromARGB(255, 225, 225, 225),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Serial Order No.",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 2),
//                 CustomeTextField(
//                   control: ordernoController,
//                   borderRadius: BorderRadius.circular(8),
//                   width: MediaQuery.of(context).size.width,
//                   borderColor: Color.fromARGB(255, 225, 225, 225),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "Description",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(height: 2),
//                 CustomeTextField(
//                   control: categoryDescriptionController,
//                   lines: 3,
//                   borderRadius: BorderRadius.circular(8),
//                   width: MediaQuery.of(context).size.width,
//                   borderColor: Color.fromARGB(255, 225, 225, 225),
//                 ),
//                 SizedBox(height: 20),
//                 Center(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         categoryNameController.removeListener(() {});
//                         addcategory();
//                         print(
//                             'Formatted Category Name: ${formattedCategoryNameController.text}');
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         "Save",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     ).then((_) {
//       // Clean up the listener after dialog closes
//       categoryNameController.removeListener(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         title: const Text(
//           'Categories list',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.red,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//       ),