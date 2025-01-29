import 'dart:io';

import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:namstore/pages/maincontainer.dart';

import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/custom_autocomplete_widget.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/outline_btn_widget.dart';
import '../api_model/admin_add_menu_model.dart';
import '../api_model/adminadd_category_model.dart';
import '../api_model/admincategory_list_model.dart';
import '../api_model/adminmenu_edit_model.dart';
import 'admin_add_menucategory.dart';
import 'menu_details_screen_admin.dart';

class AdminAddNewMenu extends StatefulWidget {
  int? menuId;
  int? storeId;
  String? storename;
  String? storestatus;
  String? frontimg;
  String? address;
  int? base_price_percent;
  int? stick_price_percent;
  String? city;
  String? state;
  String? zipcode;
  AdminAddNewMenu(
      {super.key,
      this.menuId,
      this.storeId,
      this.storename,
      this.base_price_percent,
      this.stick_price_percent,
      this.storestatus,
      this.frontimg,
      this.address,
      this.city,
      this.state,
      this.zipcode});
  @override
  _AdminAddNewMenuState createState() => _AdminAddNewMenuState();
}

class _AdminAddNewMenuState extends State<AdminAddNewMenu> {
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

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  bool isVeg = true;
  int? selectedId;
  int type = 0;

  @override
  void initState() {
    super.initState();
    if (widget.menuId == null) {
      admingetcategoryList();
    }

    if (widget.menuId != null) {
      admingetMenuById();
    }
  }

  Future addmenu(Id) async {
    await apiService.getBearerToken();
    // if (imageFile == null) {
    //   showInSnackBar(context, 'Menu image is required');
    //   return;
    // }

    if (menuForm.currentState!.validate()) {
      Map<String, dynamic> postData = {
        "item_name": dishNameController.text,
        "item_type": selectedId,
        "item_desc": descriptionController.text,
        "item_price": strickoutpriceController.text,
        "item_offer_price": offerpriceController.text,
        "item_category_id": selectedcategoryId,
        "tax_id": 0,
        "item_stock": 1,
        "item_tags": "",
        "store_price": actualpriceController.text,
        "item_price_type": 1,
        "from_time": startTimeController.text,
        "to_time": endTimeController.text,
        "store_id": Id,
      };
      print(postData);
      print(imageFile);

      showSnackBar(context: context);
      // update-Car_management
      String url = 'v1/createitem_admin';
      if (widget.menuId != null) {
        // postData['id'] = widget.carId;
        postData = {
          "item_id": widget.menuId,
          "item_name": dishNameController.text,
          "item_type": selectedId,
          "item_desc": descriptionController.text,
          "item_price": strickoutpriceController.text,
          "item_offer_price": offerpriceController.text,
          "item_category_id": selectedcategoryId,
          "tax_id": 0,
          "item_stock": menuDetails!.itemStock,
          "item_tags": "",
          "store_price": actualpriceController.text,
          "item_price_type": 1,
          "from_time": startTimeController.text,
          "to_time": endTimeController.text,
          "store_id": Id
        };
        url = 'v1/updateitem_admin';
      }

      print("image :$imageFile");
      var result = await apiService.AdminsaveMenu(url, postData, imageFile);
      closeSnackBar(context: context);
      setState(() {
        // isLoading = false;
      });
      AdminAddMenumodel response = adminaddMenumodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        // Navigator.pushNamedAndRemoveUntil(
        //     context, '/home', ModalRoute.withName('/home'));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailsScreenAdmin(
              storeId: widget.storeId,
              storename: widget.storename,
              storestatus: widget.storestatus,
              frontimg: widget.frontimg,
              address: widget.address,
              city: widget.city,
              state: widget.state,
              zipcode: widget.zipcode,
            ),
          ),
          (route) => route.isFirst,
        );

        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //       builder: (context) => AdminMainContainer(admininitialPage: 3)),
        //   (Route<dynamic> route) => false,
        // );
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

   void calculatePrices() {
    double? actualPrice = double.tryParse(actualpriceController.text);

    if (actualPrice != null && actualPrice > 0) {
      setState(() {
        // Use base_price_percent and stick_price_percent to calculate
        print("base_price_percent: ${widget.base_price_percent}");
        double basePrice = actualPrice *
                (widget.base_price_percent != null
                    ? widget.base_price_percent! / 100
                    : 0) +
            actualPrice;
        double strikePrice = actualPrice *
                (widget.stick_price_percent != null
                    ? widget.stick_price_percent! / 100
                    : 0) +
            actualPrice;
        print("basePrice :$basePrice");

        // Update controllers for UI
        offerpriceController.text = basePrice.toString();
        strickoutpriceController.text = strikePrice.toString();
        print("offerpriceController :${offerpriceController.text}");
      });
    } else {
      // Handle invalid inputs
      setState(() {
        offerpriceController.text = actualpriceController.text;
        strickoutpriceController.text = actualpriceController.text;
      });
    }
  }

  MenuEditAdmin? menuDetails;

  Future admingetMenuById() async {
    //isLoaded = true;
    // try {
    await apiService.getBearerToken();
    var result =
        await apiService.admingetMenuById(widget.menuId, widget.storeId);
    AdminMenuEditAdminmodel response = adminmenuEditmodelFromJson(result);
    print(response);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        menuDetails = response.list;
        dishNameController.text = menuDetails!.itemName ?? '';
        descriptionController.text = menuDetails!.itemDesc ?? '';
        actualpriceController.text = menuDetails!.storePrice ?? '';
        strickoutpriceController.text =
            (menuDetails!.itemPrice ?? '').toString();
        offerpriceController.text = menuDetails!.itemOfferPrice ?? '';
        startTimeController.text = menuDetails!.from_time ?? '';
        endTimeController.text = menuDetails!.to_time ?? '';
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
      admingetcategoryList();
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

// // Add Category

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
//     AdminAddCategorymodel response = adminaddCategorymodelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       Navigator.pop(context);
//       categoryNameController.text = '';
//       categoryDescriptionController.text = '';
//       formattedCategoryNameController.text = '';
//       ordernoController.text = '';
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }

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
                        //  addcategory();
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

  List<AdmminCategoryList>? CategoryListdata;
  List<AdmminCategoryList>? CategoryListdataAll;
  bool isLoading = false;

  Future admingetcategoryList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.admingetcategoryList(widget.storeId);
    var response = admincategoryListmodelFromJson(result);
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

  String formatTimeWithSeconds(TimeOfDay time) {
    // Converts TimeOfDay to 24-hour format with default seconds as 00
    final int hours = time.hour;
    final int minutes = time.minute;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00';
  }

  Future pickSeconds(BuildContext context, int initialSeconds) async {
    int? selectedSeconds = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Seconds'),
          children: List.generate(60, (index) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, index),
              child: Text(index.toString().padLeft(2, '0')),
            );
          }),
        );
      },
    );

    return selectedSeconds ?? initialSeconds;
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminAddMenuCategory(
                              storeId: widget.storeId,
                            ),
                          ),
                        );
                      }, // _showAddCategoryDialog,
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
                  Text("Store Org price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 2),
                  CustomeTextField(
                    control: actualpriceController,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    type: const TextInputType.numberWithOptions(),
                    borderColor: Color.fromARGB(255, 225, 225, 225),
                     onChanged: (value) {
                      // Trigger calculation whenever the actual price changes
                      calculatePrices();
                      print("cal");
                    },
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
                  Text("Selling price",
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

                  Text("Available Start Time",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: startTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select start time",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedStartTime = picked;
                          startTimeController.text =
                              formatTimeWithSeconds(picked);
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  // End Time Picker
                  Text("Available End Time",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: endTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select end time",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (picked != null) {
                        setState(() {
                          selectedEndTime = picked;
                          endTimeController.text =
                              formatTimeWithSeconds(picked);
                        });
                      }
                    },
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
                  // Text(
                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                  //     style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    //height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (imageFile == null && widget.menuId == null) {
                          showInSnackBar(context, 'Menu image is required');
                        } else if (selectedcategoryId == null) {
                          showInSnackBar(context, 'Category is required');
                        } else {
                          addmenu(widget.storeId);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(widget.menuId == null ? 'Save' : 'Update',
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
