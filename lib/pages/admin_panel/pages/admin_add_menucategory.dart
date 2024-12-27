import 'package:flutter/material.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/svgiconButtonWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/custom_text_field.dart';
import '../api_model/admin_menu_add_category_model.dart';
import '../api_model/admin_menu_category_list_model.dart';
import '../api_model/admin_menu_delete_category_model.dart';
import '../api_model/admin_menu_edit_category_model.dart';
import '../api_model/admin_menu_update_category_model.dart';

class AdminAddMenuCategory extends StatefulWidget {
  int? category;
  int? storeId;
  AdminAddMenuCategory({super.key, this.category, this.storeId});

  @override
  State<AdminAddMenuCategory> createState() => _AdminAddMenuCategoryState();
}

class _AdminAddMenuCategoryState extends State<AdminAddMenuCategory> {
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

  List<AdminCategoryList>? CategoryListdata;
  List<AdminCategoryList>? categoryListDataAll;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
    // if (widget.category != null) {
    //   // getCategoryById();
    // }
  }

  Future getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.AdmingetcategoryList(widget.storeId);
    var response = adminmenucategoryListmodelFromJson(result);
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
      //showInSnackBar(context, response.message.toString());
    }
  }

  Future<void> AdminaddCategory() async {
    Map<String, dynamic> postData = {
      "category_name": categoryNameController.text,
      "description": categoryDescriptionController.text,
      "slug": formattedCategoryNameController.text,
      "serial": ordernoController.text,
      "store_id": widget.storeId
    };
    var result = await apiService.Adminaddcategory(postData);
    AdminMenuAddCategorymodel response =
        adminmenuaddCategorymodelFromJson(result);
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

  AdminEditCategory? categoriesDetails;

  Future<void> AdmingetCategoryById(String categoryId) async {
    // Fetch bearer token
    await apiService.getBearerToken();

    // Fetch category details by ID
    var result =
        await apiService.Admingetcategorybyid(categoryId, widget.storeId);
    AdminMenuEditCategoryByIdModel response =
        adminmenueditCategoryByIdModelFromJson(result);

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
  Future<void> Admindeletecategorybyid(String categoryId) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();
      Map<String, dynamic> postData = {
        "id": categoryId,
      };
      var result =
          await apiService.Admindeletecategorybyid(postData, widget.storeId);
      AdminMenuDeleteCategoryByIdModel response =
          adminmenudeleteategoryByIdModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        getCategoryList();
      } else {
        showInSnackBar(context, response.message.toString());
      }
    }
  }

  // update

  Future AdminupdateItemCategory() async {
    await apiService.getBearerToken();
    // if (thirdpartyForm.currentState!.validate()) {
    Map<String, dynamic> postData = {
      "category_id": categoriesDetails?.categoryId,
      "category_name": editcategoryNameController.text,
      "description": editcategoryDescriptionController.text,
      "slug": editformattedCategoryNameController.text,
      "serial": editordernoController.text,
      "store_id": widget.storeId
    };
    print("updateItemCategory $postData");
    var result = await apiService.AdminupdateItemCategory(postData);

    AdminMenuUpdateItemCategoryModel response =
        adminmenuupdateItemCategoryModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context, {'update': true});
      getCategoryList();
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
                        AdminaddCategory();
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
                        AdminupdateItemCategory();
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

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 63,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 63,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Center(
          child: Text(
            'Category list',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: AppColors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : Column(
              children: [
                SizedBox(height: 12),
                Padding(
                    padding: EdgeInsets.only(
                        top: 0.0, left: 16.0, right: 16.0, bottom: 5),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HeadingWidget(
                                          title: "Category :",
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
                                            AdmingetCategoryById(
                                              e.categoryId.toString(),
                                            );
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.red)),
                                            child: Icon(
                                              Icons.edit_outlined,
                                              size: 24,
                                              color: AppColors.red,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width: 10), // Spacing between
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Admindeletecategorybyid(
                                                e.categoryId.toString(),
                                              );
                                            });
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.red)),
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
                                  title: 'Description :',
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
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showAddCategoryDialog();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add New Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
