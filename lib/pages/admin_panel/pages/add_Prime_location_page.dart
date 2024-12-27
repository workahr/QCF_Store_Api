import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
class PrimeLocationPage extends StatefulWidget {
  const PrimeLocationPage({super.key});

  @override
  State<PrimeLocationPage> createState() => _PrimeLocationPageState();
}

class _PrimeLocationPageState extends State<PrimeLocationPage> {
  List industrynamelist = [];

  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();

  final TextEditingController primelocationController = TextEditingController();

// List<AdminCategoryList>? CategoryListdata;
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

//   Future<void> AdminaddCategory() async {
//     Map<String, dynamic> postData = {
//       "prime_location": primelocationController.text,
//
//     };
//     var result = await apiService.Adminaddcategory(postData, widget.storeId);
//     AdminMenuAddCategorymodel response =
//         adminmenuaddCategorymodelFromJson(result);
//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       Navigator.pop(context);
//       primelocationController.clear();
//
//       getCategoryList();
//     } else {
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   AdminEditCategory? categoriesDetails;

//   Future<void> AdmingetCategoryById(String categoryId) async {
//     // Fetch bearer token
//     await apiService.getBearerToken();

//     // Fetch category details by ID
//     var result =
//         await apiService.Admingetcategorybyid(categoryId, widget.storeId);
//     AdminMenuEditCategoryByIdModel response =
//         adminmenueditCategoryByIdModelFromJson(result);

//     // Check response status
//     if (response.status.toString() == 'SUCCESS') {
//       setState(() {
//         categoriesDetails = response.list;
//         primelocationController.text = categoriesDetails?.categoryName ?? '';
//
//       });

//       // Debugging prints
//       print("Prime Location: ${categoriesDetails?.categoryName}");
//       print("Text Controller Value: ${editcategoryNameController.text}");

//       // Show edit dialog
//       _showEditCategoryDialog();
//     } else {
//       // Handle failure
//       showInSnackBar(context, "Data not found");
//     }
//   }

// //delete
//   Future<void> Admindeletecategorybyid(String categoryId) async {
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

//   Future AdminupdateItemCategory() async {
//     await apiService.getBearerToken();
//     // if (thirdpartyForm.currentState!.validate()) {
//     Map<String, dynamic> postData = {
//       "category_id": categoriesDetails?.categoryId,
//       "prime_location": primelocationController.text,
//
//     };
//     print("updateItemCategory $postData");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          title: const Text(
            'Prime Location',
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
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Center(
              child: SizedBox(
                  child: Column(children: <Widget>[
            // SizedBox(
            //   height: 16,
            // ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                cursorColor: AppColors.red,
                onTap: () {},
                controller: primelocationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: AppColors.lightGrey5), // Default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            AppColors.lightGrey5), // Border color when enabled
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.red), // Border color when focused
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  floatingLabelStyle: TextStyle(color: AppColors.red),
                  labelText: 'Prime Location',
                  labelStyle: TextStyle(color: AppColors.lightGrey5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // if(_industrynamecontroller.text.toString() == '' && _ordernumbercontroller.text.toString() == ''){
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text('Empty values cannot save.'), backgroundColor: Colors.red));
                // }else{
                //   Insertdata(context);}
              },
              style: ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                  backgroundColor: MaterialStateProperty.all(AppColors.red),
                  minimumSize: WidgetStatePropertyAll(Size(50, 50)),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontSize: 16, color: Colors.white))),
            )
          ]))),
          Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: industrynamelist.length,
              itemBuilder: (context, index) {
                final e = industrynamelist[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: ListTile(
                    leading: Text((index + 1).toString()),
                    title: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        e.industryname.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        e.ordernumber.toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            primelocationController.text =
                                e.industryname.toString();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  content: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        height: 300,
                                        child: Form(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: CircleAvatar(
                                                    radius: 17.0,
                                                    backgroundColor:
                                                        Colors.black12,
                                                    child: Icon(Icons.close,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Update',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[800],
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              TextFormField(
                                                controller:
                                                    primelocationController,
                                                decoration: InputDecoration(
                                                  hintText: 'Area',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                margin: EdgeInsets.all(25),
                                                child: ElevatedButton(
                                                  child: Text(
                                                    "Update",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0),
                                                  ),
                                                  onPressed: () {
                                                    // Handle update logic here
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green[800],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_forever_rounded,
                              color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Confirm Message',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        Text('Do you really want to Delete?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle delete logic here
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

//  Padding(
          //   padding: EdgeInsets.all(15),
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height * 0.5,
          //     child: CategoryListdata != null && CategoryListdata!.isNotEmpty
          //         ? SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: DataTable(
          //               border: TableBorder.all(
          //                 color: Colors.black,
          //                 width: 2,
          //               ),
          //               columnSpacing: 10,
          //               horizontalMargin: 6,
          //               columns: [
          //                 DataColumn(label: Text('S.No')),
          //                 DataColumn(label: Text('Variant Name')),
          //                 DataColumn(label: Text('Store Price')),
          //                 DataColumn(label: Text('Selling Price')),
          //                 DataColumn(label: Text('Edit')),
          //                 DataColumn(label: Text('Delete')),
          //               ],
          //               rows: List<DataRow>.generate(
          //                 CategoryListdata!.length,
          //                 (index) {
          //                   final element = CategoryListdata![index];
          //                   final categoryId =
          //                       element.categoryId?.toString() ?? '';
          //                   final categoryName =
          //                       element.categoryName ?? 'Unknown Name';
          //                   final description =
          //                       element.description ?? 'No Description';

          //                   return DataRow(
          //                     cells: [
          //                       DataCell(Text((index + 1).toString())),
          //                       DataCell(Text(categoryName)),
          //                       DataCell(Text(description)),
          //                       DataCell(Text(description)),
          //                       DataCell(
          //                         TextButton.icon(
          //                           onPressed: () {
          //                             if (categoryId.isNotEmpty) {
          //                               subController.text =
          //                                   categoryName;
          //                               showDialog(
          //                                 context: context,
          //                                 builder: (context) {
          //                                   return AlertDialog(
          //                                     shape: RoundedRectangleBorder(
          //                                       borderRadius: BorderRadius.all(
          //                                         Radius.circular(30.0),
          //                                       ),
          //                                     ),
          //                                     content: StatefulBuilder(
          //                                       builder: (BuildContext context,
          //                                           StateSetter setState) {
          //                                         return SingleChildScrollView(
          //                                           child: ConstrainedBox(
          //                                             constraints:
          //                                                 BoxConstraints(
          //                                               maxHeight: MediaQuery
          //                                                           .of(context)
          //                                                       .size
          //                                                       .height *
          //                                                   0.8, // Limit height to 80% of the screen
          //                                             ),
          //                                             child: Form(
          //                                               child: Column(
          //                                                 mainAxisSize:
          //                                                     MainAxisSize.min,
          //                                                 children: [
          //                                                   GestureDetector(
          //                                                     onTap: () =>
          //                                                         Navigator.of(
          //                                                                 context)
          //                                                             .pop(),
          //                                                     child: Align(
          //                                                       alignment:
          //                                                           Alignment
          //                                                               .topRight,
          //                                                       child:
          //                                                           CircleAvatar(
          //                                                         radius: 17.0,
          //                                                         backgroundColor:
          //                                                             Colors
          //                                                                 .black12,
          //                                                         child: Icon(
          //                                                           Icons.close,
          //                                                           color: Colors
          //                                                               .red,
          //                                                         ),
          //                                                       ),
          //                                                     ),
          //                                                   ),
          //                                                   SizedBox(
          //                                                       height: 20),
          //                                                   TextFormField(
          //                                                     controller:
          //                                                         subController,
          //                                                     decoration:
          //                                                         InputDecoration(
          //                                                       hintText:
          //                                                           'Category Name',
          //                                                       border:
          //                                                           OutlineInputBorder(),
          //                                                     ),
          //                                                   ),
          //                                                   SizedBox(
          //                                                       height: 10),
          //                                                   TextFormField(
          //                                                     controller:
          //                                                         deliverychargeController,
          //                                                     decoration:
          //                                                         InputDecoration(
          //                                                       hintText:
          //                                                           'Store Price',
          //                                                       border:
          //                                                           OutlineInputBorder(),
          //                                                     ),
          //                                                   ),
          //                                                   SizedBox(
          //                                                       height: 10),
          //                                                   TextFormField(
          //                                                     controller:
          //                                                         deliverychargeController,
          //                                                     decoration:
          //                                                         InputDecoration(
          //                                                       hintText:
          //                                                           'Selling Price',
          //                                                       border:
          //                                                           OutlineInputBorder(),
          //                                                     ),
          //                                                   ),
          //                                                   Container(
          //                                                     margin: EdgeInsets
          //                                                         .all(25),
          //                                                     child:
          //                                                         ElevatedButton(
          //                                                       onPressed: () {
          //                                                         // AdminupdateItemvariant(
          //                                                         //     categoryId);
          //                                                       },
          //                                                       child: Text(
          //                                                           'Update'),
          //                                                       style:
          //                                                           ButtonStyle(
          //                                                         backgroundColor:
          //                                                             MaterialStateProperty
          //                                                                 .all(
          //                                                           AppColors
          //                                                               .red,
          //                                                         ),
          //                                                         padding:
          //                                                             MaterialStateProperty
          //                                                                 .all(
          //                                                           EdgeInsets
          //                                                               .all(
          //                                                                   15),
          //                                                         ),
          //                                                         textStyle:
          //                                                             MaterialStateProperty
          //                                                                 .all(
          //                                                           TextStyle(
          //                                                             fontSize:
          //                                                                 16,
          //                                                             color: Colors
          //                                                                 .white,
          //                                                           ),
          //                                                         ),
          //                                                       ),
          //                                                     ),
          //                                                   ),
          //                                                 ],
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         );
          //                                       },
          //                                     ),
          //                                   );
          //                                 },
          //                               );
          //                             }
          //                           },
          //                           icon: Icon(Icons.edit, color: Colors.blue),
          //                           label: Text('Edit'),
          //                         ),
          //                       ),
          //                       DataCell(
          //                         TextButton.icon(
          //                           onPressed: () {
          //                             if (categoryId.isNotEmpty) {
          //                               showDialog(
          //                                 context: context,
          //                                 builder: (context) => AlertDialog(
          //                                   title: Text(
          //                                     'Confirm Deletion',
          //                                     style:
          //                                         TextStyle(color: Colors.red),
          //                                   ),
          //                                   content: Text(
          //                                       'Do you really want to delete this category?'),
          //                                   actions: [
          //                                     TextButton(
          //                                       onPressed: () {
          //                                         // AdmindeleteVariantbyid(
          //                                         //     categoryId);
          //                                         // Navigator.of(context).pop();
          //                                       },
          //                                       child: Text('Confirm',
          //                                           style: TextStyle(
          //                                               color: Colors.red)),
          //                                     ),
          //                                     TextButton(
          //                                       onPressed: () {
          //                                         Navigator.of(context).pop();
          //                                       },
          //                                       child: Text('Cancel',
          //                                           style: TextStyle(
          //                                               color: Colors.grey)),
          //                                     ),
          //                                   ],
          //                                 ),
          //                               );
          //                             }
          //                           },
          //                           icon: Icon(Icons.delete, color: Colors.red),
          //                           label: Text('Delete'),
          //                         ),
          //                       ),
          //                     ],
          //                   );
          //                 },
          //               ),
          //             ),
          //           )
          //         : Center(
          //             child: Text(
          //               'No categories found.',
          //               style: TextStyle(fontSize: 16, color: Colors.grey),
          //             ),
          //           ),
          //   ),
          // ),
        ])));
  }
}
