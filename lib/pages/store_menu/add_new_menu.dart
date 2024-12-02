import 'dart:io';

import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../constants/app_constants.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_autocomplete_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/outline_btn_widget.dart';
import 'add_category_model.dart';
import 'add_menu_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'category_list_model.dart';
import 'menu_details_screen.dart';
import 'menu_edit_model.dart';

class AddNewMenu extends StatefulWidget {
  int? menuId;
  AddNewMenu({super.key, this.menuId});
  @override
  _AddNewMenuState createState() => _AddNewMenuState();
}

class _AddNewMenuState extends State<AddNewMenu> {
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> menuForm = GlobalKey<FormState>();

  String? selectedCategory;
  TextEditingController dishNameController = TextEditingController();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController ordernoController = TextEditingController();
  TextEditingController categoryDescriptionController = TextEditingController();
  TextEditingController actualpriceController = TextEditingController();
  TextEditingController strickoutpriceController = TextEditingController();
  TextEditingController offerpriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController formattedCategoryNameController =
      TextEditingController();
  bool isVeg = true;
  int? selectedId;
  int type = 0;

  @override
  void initState() {
    super.initState();
    if (widget.menuId == null) {
      getcategoryList();
    }

    if (widget.menuId != null) {
      getMenuById();
    }
  }

  Future addmenu() async {
    await apiService.getBearerToken();
    if (imageFile == null && widget.menuId == null) {
      showInSnackBar(context, 'Menu image is required');
      return;
    }

    if (menuForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "item_name": dishNameController.text,
        "item_type": selectedId,
        "item_desc": descriptionController.text,
        "item_price": actualpriceController.text,
        "item_offer_price": strickoutpriceController.text,
        "item_category_id": selectedcategoryId,
        "tax_id": 0,
        "item_stock": 1,
        "item_tags": "",
        "store_price": offerpriceController.text,
        "item_price_type": 1,
      };
      print(postData);

      showSnackBar(context: context);
      // update-Car_management
      String url = 'v1/createitem';
      if (widget.menuId != null) {
        // postData['id'] = widget.carId;
        postData = {
          "item_id": widget.menuId,
          "item_name": dishNameController.text,
          "item_type": selectedId,
          "item_desc": descriptionController.text,
          "item_price": actualpriceController.text,
          "item_offer_price": strickoutpriceController.text,
          "item_category_id": selectedcategoryId,
          "tax_id": 0,
          "item_stock": menuDetails!.itemStock,
          "item_tags": "",
          "store_price": offerpriceController.text,
          "item_price_type": 1,
        };
        url = 'v1/updateitem';
      }
      var result = await apiService.saveCar(url, postData, imageFile);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      AddMenumodel response = addMenumodelFromJson(result);

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

  MenuEdit? menuDetails;

  Future getMenuById() async {
    //isLoaded = true;
    // try {
    await apiService.getBearerToken();
    var result = await apiService.getMenuById(widget.menuId);
    MenuEditmodel response = menuEditmodelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        menuDetails = response.list;
        dishNameController.text = menuDetails!.itemName ?? '';
        descriptionController.text = menuDetails!.itemDesc ?? '';
        actualpriceController.text = menuDetails!.itemPrice ?? '';
        strickoutpriceController.text =
            (menuDetails!.itemOfferPrice ?? '').toString();
        offerpriceController.text = menuDetails!.storePrice ?? '';
        liveimgSrc = menuDetails!.itemImageUrl ?? '';
        selectedId = menuDetails!.itemType;

        // selectedyes = carDetails!.rental ?? '';
        selectedcategoryId = menuDetails!.itemCategoryId;

        // if (referList.isNotEmpty) {
        //   selectedrentalyesornoArray();
        // } else {
        //   selectedrentalyesornoArray1();
        // }
      });
      getcategoryList();
    } else {
      showInSnackBar(context, "Data not found");
      //isLoaded = false;
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

// Add Category

  Future addcategory() async {
    Map<String, dynamic> postData = {
      "category_name": categoryNameController.text,
      "description": categoryDescriptionController.text,
      "slug": formattedCategoryNameController.text,
      "serial": ordernoController.text
    };
    print('postData $postData');

    var result = await apiService.addcategory(postData);
    print('result $result');
    AddCategorymodel response = addCategorymodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context);
      categoryNameController.text = '';
      categoryDescriptionController.text = '';
      formattedCategoryNameController.text = '';
      ordernoController.text = '';
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

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
                        addcategory();
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

  String? selectedcategory;
  int? selectedcategoryId;

  selectedcategoryArray() {
    List result;

    if (CategoryListdata!.isNotEmpty) {
      result = CategoryListdata!
          .where((element) => element.categoryId == selectedcategoryId)
          .toList();

      if (result.isNotEmpty) {
        setState(() {
          print("result a 2 drop:$result");
          selectedcategoryedit = result[0];
        });
      } else {
        setState(() {
          selectedcategoryedit = null;
        });
      }
    } else {
      setState(() {
        print('selectedVisitPurposeArr empty');

        selectedcategoryedit = null;
      });
    }
  }

  var selectedcategoryedit;

  List<CategoryList>? CategoryListdata;
  List<CategoryList>? CategoryListdataAll;
  bool isLoading = false;

  Future getcategoryList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getcategoryList();
    var response = categoryListmodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        CategoryListdata = response.list;
        CategoryListdataAll = CategoryListdata;
        isLoading = false;
        if (widget.menuId != null) {
          selectedcategoryArray();
        }
      });
    } else {
      setState(() {
        CategoryListdata = [];
        CategoryListdataAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
    setState(() {});
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
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: menuForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Categories",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    // DropdownButtonFormField<String>(
                    //   value: selectedCategory,
                    //   hint: Text('Select Category'),
                    //   items: ['Category 1', 'Category 2', 'Category 3']
                    //       .map((category) => DropdownMenuItem(
                    //             value: category,
                    //             child: Text(category),
                    //           ))
                    //       .toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedCategory = value;
                    //     });
                    //   },
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //           color: Color.fromARGB(255, 225, 225, 225),
                    //           width: 1.5),
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.red, width: 1.5),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    //   ),
                    // ),
                    if (CategoryListdata != null)
                      CustomAutoCompleteWidget(
                        width: MediaQuery.of(context).size.width / 1.1,
                        selectedItem: selectedcategoryedit,
                        labelText: 'Select Category',
                        labelField: (item) => item.categoryName,
                        onChanged: (value) {
                          selectedcategory = value.categoryName;
                          selectedcategoryId = value.categoryId;
                          print("category id$selectedcategoryId");
                        },
                        valArr: CategoryListdata,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  CustomeTextField(
                    control: dishNameController,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    borderColor: Color.fromARGB(255, 225, 225, 225),
                  ),
                  SizedBox(height: 16),
                  Text("Actual price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  CustomeTextField(
                    control: actualpriceController,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    type: const TextInputType.numberWithOptions(),
                    borderColor: Color.fromARGB(255, 225, 225, 225),
                    // boxRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  SizedBox(height: 16),
                  Text("Strick Out price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  CustomeTextField(
                    control: strickoutpriceController,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    type: const TextInputType.numberWithOptions(),
                    borderColor: Color.fromARGB(255, 225, 225, 225),
                    // boxRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  SizedBox(height: 16),
                  Text("Offer price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  CustomeTextField(
                    control: offerpriceController,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    type: const TextInputType.numberWithOptions(),
                    borderColor: Color.fromARGB(255, 225, 225, 225),
                    // boxRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                  SizedBox(height: 16),
                  Text("Select Dish Type",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1, // ID for Non-Veg
                            groupValue: selectedId, // Current selected ID
                            onChanged: (value) {
                              setState(() {
                                selectedId = value as int; // Update selected ID
                                isVeg = false; // Update Veg/Non-Veg state
                                print("non veg $selectedId");
                              });
                            },
                            activeColor: Colors.red,
                          ),
                          Image.asset(AppAssets.nonveg_icon),
                          SizedBox(width: 5),
                          Text("Non-Veg", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: selectedId,
                            onChanged: (value) {
                              setState(() {
                                selectedId = value as int;
                                isVeg = true;
                              });
                              print("veg $selectedId");
                            },
                            activeColor: Colors.green,
                          ),
                          Image.asset(AppAssets.veg_icon),
                          SizedBox(width: 5),
                          Text("Veg", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Description",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                      onTap: () {
                        type = 0;
                        showActionSheet(context);
                      }),
                  SizedBox(
                    height: 10,
                  ),
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
                      onPressed: () {
                        addmenu();
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
                  )),
                ],
              ),
            ),
          ),
        ));
  }
}
