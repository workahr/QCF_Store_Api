// import 'package:flutter/material.dart';
// import 'package:namstore/widgets/button_widget.dart';
// import 'package:namstore/widgets/heading_widget.dart';
// import 'package:namstore/widgets/svgiconButtonWidget.dart';

// import '../../../constants/app_assets.dart';
// import '../../../constants/app_colors.dart';
// import '../../../services/comFuncService.dart';
// import '../../../services/nam_food_api_service.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../api_model/admin_menu_add_category_model.dart';
// import '../api_model/admin_menu_category_list_model.dart';
// import '../api_model/admin_menu_delete_category_model.dart';
// import '../api_model/admin_menu_edit_category_model.dart';
// import '../api_model/admin_menu_update_category_model.dart';

// class AdminAddMenuvariant extends StatefulWidget {
//   int? menuId;
//   int? storeId;
//   AdminAddMenuvariant({super.key, this.menuId, this.storeId});

//   @override
//   State<AdminAddMenuvariant> createState() => _AdminAddMenuvariantState();
// }

// class _AdminAddMenuvariantState extends State<AdminAddMenuvariant> {
//   final NamFoodApiService apiService = NamFoodApiService();

//   TextEditingController variantNameController = TextEditingController();
//   TextEditingController storepriceController = TextEditingController();
//   TextEditingController sellingpriceController = TextEditingController();

//   List<AdminCategoryList>? CategoryListdata;
//   List<AdminCategoryList>? categoryListDataAll;

//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getCategoryList();
//     // if (widget.category != null) {
//     //   // getCategoryById();
//     // }
//   }

//   Future<void> getCategoryList() async {
//     setState(() {
//       isLoading = true;
//     });
//     await apiService.getBearerToken();
//     var result = await apiService.AdmingetcategoryList(widget.storeId);
//     var response = adminmenucategoryListmodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         CategoryListdata = response.list;
//         categoryListDataAll = CategoryListdata;
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         CategoryListdata = [];
//         categoryListDataAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   Future<void> Adminaddvariant() async {
//     Map<String, dynamic> postData = {
//       "variant_name": variantNameController.text,
//       "store_price": storepriceController.text,
//       "selling_price": sellingpriceController.text,
//     };
//     var result = await apiService.Adminaddcategory(postData, widget.storeId);
//     AdminMenuAddCategorymodel response =
//         adminmenuaddCategorymodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       Navigator.pop(context);
//       variantNameController.clear();
//       storepriceController.clear();
//       sellingpriceController.clear();

//       getCategoryList();
//     } else {
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   AdminEditCategory? categoriesDetails;

//   Future<void> AdmingetCategoryById(String categoryId) async {
//     await apiService.getBearerToken();

//     var result =
//         await apiService.Admingetcategorybyid(categoryId, widget.storeId);
//     AdminMenuEditCategoryByIdModel response =
//         adminmenueditCategoryByIdModelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         // categoriesDetails = response.list;
//         // variantNameController.text = categoriesDetails?.variantName ?? '';
//         // storepriceController.text =
//         //     categoriesDetails?.storeprice.toString() ?? '';
//         // sellingpriceController.text = categoriesDetails?.sellingprice ?? '';
//       });
//     } else {
//       // Handle failure
//       showInSnackBar(context, "Data not found");
//     }
//   }

// //delete
//   Future<void> AdmindeleteVariantbyid(String categoryId) async {
//     final dialogBoxResult = await showAlertDialogInfo(
//         context: context,
//         title: 'Are you sure?',
//         msg: 'You want to delete this data',
//         status: 'danger',
//         okBtn: false);
//     if (dialogBoxResult == 'OK') {
//       await apiService.getBearerToken();
//       Map<String, dynamic> postData = {
//         "id": categoryId,
//       };
//       var result =
//           await apiService.Admindeletecategorybyid(postData, widget.storeId);
//       AdminMenuDeleteCategoryByIdModel response =
//           adminmenudeleteategoryByIdModelFromJson(result);
//       if (response.status.toString() == 'SUCCESS') {
//         showInSnackBar(context, response.message.toString());
//         getCategoryList();
//       } else {
//         showInSnackBar(context, response.message.toString());
//       }
//     }
//   }

//   // update

//   Future AdminupdateItemvariant(String variantId) async {
//     await apiService.getBearerToken();
//     // if (thirdpartyForm.currentState!.validate()) {
//     Map<String, dynamic> postData = {
//       //"menu_id": widget.menuId,
//       "variant_id": variantId,
//       "variant_name": variantNameController.text,
//       "store_price": storepriceController.text,
//       "selling_price": sellingpriceController.text,
//     };
//     print("updateItemvariant $postData");
//     var result =
//         await apiService.AdminupdateItemCategory(postData, widget.storeId);

//     AdminMenuUpdateItemCategoryModel response =
//         adminmenuupdateItemCategoryModelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       Navigator.pop(context, {'update': true});
//       getCategoryList();
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//     // } else {
//     //   // showInSnackBar(context, "Please fill all fields");
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 80,
//           title: Center(
//             child: Text(
//               'Add Variant',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           backgroundColor: AppColors.red,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20.0),
//               bottomRight: Radius.circular(20.0),
//             ),
//           ),
//           automaticallyImplyLeading: false,
//         ),
//         body: SingleChildScrollView(
//             child: Column(children: <Widget>[
//           Padding(
//             padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
//             child: CustomeTextField(
//               control: variantNameController,
//               labelText: "Variant Name",
//               borderRadius: BorderRadius.circular(8),
//               width: MediaQuery.of(context).size.width,
//               borderColor: const Color.fromARGB(255, 225, 225, 225),
//             ),
           
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
//             child: CustomeTextField(
//               control: storepriceController,
//               labelText: "Store Price",
//               borderRadius: BorderRadius.circular(8),
//               width: MediaQuery.of(context).size.width,
//               borderColor: const Color.fromARGB(255, 225, 225, 225),
//             ),
            
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
//             child: CustomeTextField(
//               control: sellingpriceController,
//               labelText: "Selling Price",
//               borderRadius: BorderRadius.circular(8),
//               width: MediaQuery.of(context).size.width,
//               borderColor: const Color.fromARGB(255, 225, 225, 225),
//             ),
           
//           ),
//           SizedBox(
//               width: 140,
//               child: ElevatedButton(
//                 child: Text(
//                   ' Add ',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   if (variantNameController.text.toString() == '' &&
//                       storepriceController.text.toString() == '' &&
//                       storepriceController.text.toString() == '') {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('Empty values cannot save.'),
//                         backgroundColor: AppColors.red));
//                   } else {
//                     Adminaddvariant();
//                   }
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(AppColors.red),
//                     padding: MaterialStateProperty.all(EdgeInsets.all(15)),
//                     textStyle: MaterialStateProperty.all(
//                         TextStyle(fontSize: 16, color: Colors.white))),
//               )),
//           Padding(
//             padding: EdgeInsets.all(15),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.5,
//               child: CategoryListdata != null && CategoryListdata!.isNotEmpty
//                   ? SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         border: TableBorder.all(
//                           color: Colors.black,
//                           width: 2,
//                         ),
//                         columnSpacing: 10,
//                         horizontalMargin: 6,
//                         columns: [
//                           DataColumn(label: Text('S.No')),
//                           DataColumn(label: Text('Variant Name')),
//                           DataColumn(label: Text('Store Price')),
//                           DataColumn(label: Text('Selling Price')),
//                           DataColumn(label: Text('Edit')),
//                           DataColumn(label: Text('Delete')),
//                         ],
//                         rows: List<DataRow>.generate(
//                           CategoryListdata!.length,
//                           (index) {
//                             final element = CategoryListdata![index];
//                             final categoryId =
//                                 element.categoryId?.toString() ?? '';
//                             final categoryName =
//                                 element.categoryName ?? 'Unknown Name';
//                             final description =
//                                 element.description ?? 'No Description';

//                             return DataRow(
//                               cells: [
//                                 DataCell(Text((index + 1).toString())),
//                                 DataCell(Text(categoryName)),
//                                 DataCell(Text(description)),
//                                 DataCell(Text(description)),
//                                 DataCell(
//                                   TextButton.icon(
//                                     onPressed: () {
//                                       if (categoryId.isNotEmpty) {
//                                         variantNameController.text =
//                                             categoryName;
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return AlertDialog(
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.all(
//                                                   Radius.circular(30.0),
//                                                 ),
//                                               ),
//                                               content: StatefulBuilder(
//                                                 builder: (BuildContext context,
//                                                     StateSetter setState) {
//                                                   return SingleChildScrollView(
//                                                     child: ConstrainedBox(
//                                                       constraints:
//                                                           BoxConstraints(
//                                                         maxHeight: MediaQuery
//                                                                     .of(context)
//                                                                 .size
//                                                                 .height *
//                                                             0.8, // Limit height to 80% of the screen
//                                                       ),
//                                                       child: Form(
//                                                         child: Column(
//                                                           mainAxisSize:
//                                                               MainAxisSize.min,
//                                                           children: [
//                                                             GestureDetector(
//                                                               onTap: () =>
//                                                                   Navigator.of(
//                                                                           context)
//                                                                       .pop(),
//                                                               child: Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topRight,
//                                                                 child:
//                                                                     CircleAvatar(
//                                                                   radius: 17.0,
//                                                                   backgroundColor:
//                                                                       Colors
//                                                                           .black12,
//                                                                   child: Icon(
//                                                                     Icons.close,
//                                                                     color: Colors
//                                                                         .red,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                                 height: 20),
//                                                             TextFormField(
//                                                               controller:
//                                                                   variantNameController,
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 hintText:
//                                                                     'Category Name',
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                                 height: 10),
//                                                             TextFormField(
//                                                               controller:
//                                                                   storepriceController,
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 hintText:
//                                                                     'Store Price',
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                                 height: 10),
//                                                             TextFormField(
//                                                               controller:
//                                                                   sellingpriceController,
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 hintText:
//                                                                     'Selling Price',
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                               ),
//                                                             ),
//                                                             Container(
//                                                               margin: EdgeInsets
//                                                                   .all(25),
//                                                               child:
//                                                                   ElevatedButton(
//                                                                 onPressed: () {
//                                                                   AdminupdateItemvariant(
//                                                                       categoryId);
//                                                                 },
//                                                                 child: Text(
//                                                                     'Update'),
//                                                                 style:
//                                                                     ButtonStyle(
//                                                                   backgroundColor:
//                                                                       MaterialStateProperty
//                                                                           .all(
//                                                                     AppColors
//                                                                         .red,
//                                                                   ),
//                                                                   padding:
//                                                                       MaterialStateProperty
//                                                                           .all(
//                                                                     EdgeInsets
//                                                                         .all(
//                                                                             15),
//                                                                   ),
//                                                                   textStyle:
//                                                                       MaterialStateProperty
//                                                                           .all(
//                                                                     TextStyle(
//                                                                       fontSize:
//                                                                           16,
//                                                                       color: Colors
//                                                                           .white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       }
//                                     },
//                                     icon: Icon(Icons.edit, color: Colors.blue),
//                                     label: Text('Edit'),
//                                   ),
//                                 ),
//                                 DataCell(
//                                   TextButton.icon(
//                                     onPressed: () {
//                                       if (categoryId.isNotEmpty) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) => AlertDialog(
//                                             title: Text(
//                                               'Confirm Deletion',
//                                               style:
//                                                   TextStyle(color: Colors.red),
//                                             ),
//                                             content: Text(
//                                                 'Do you really want to delete this category?'),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   AdmindeleteVariantbyid(
//                                                       categoryId);
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: Text('Confirm',
//                                                     style: TextStyle(
//                                                         color: Colors.red)),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 },
//                                                 child: Text('Cancel',
//                                                     style: TextStyle(
//                                                         color: Colors.grey)),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     icon: Icon(Icons.delete, color: Colors.red),
//                                     label: Text('Delete'),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     )
//                   : Center(
//                       child: Text(
//                         'No categories found.',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                     ),
//             ),
//           ),
//         ])
//             // )
//             ));
//   }
// }
