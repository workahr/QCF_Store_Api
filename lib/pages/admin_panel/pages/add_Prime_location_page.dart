import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/add_primelocation_model.dart';
import '../api_model/delete_primelocation_model.dart';
import '../api_model/edit_primelocation_model.dart';
import '../api_model/prime_location_list_model.dart';
import '../api_model/update_primelocation_model.dart';

class PrimeLocationPage extends StatefulWidget {
  const PrimeLocationPage({super.key});

  @override
  State<PrimeLocationPage> createState() => _PrimeLocationPageState();
}

class _PrimeLocationPageState extends State<PrimeLocationPage> {
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();

  final TextEditingController primelocationController = TextEditingController();
  final TextEditingController primelocationeditController =
      TextEditingController();

  List<PrimeList>? PrimeListData;
  List<PrimeList>? PrimeListDataAll;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getprimelocationList();
  }

  Future<void> getprimelocationList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getprimelocationList();
    var response = primeLocationListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        PrimeListData = response.list;
        PrimeListDataAll = PrimeListData;
        isLoading = false;
      });
    } else {
      setState(() {
        PrimeListData = [];
        PrimeListDataAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
  }

  //add

  Future<void> addPrimelocation() async {
    await apiService.getBearerToken();
    Map<String, dynamic> postData = {
      "name": primelocationController.text,
      "serial": "1"
    };
    var result = await apiService.addprimelocation(postData);
    AddPrimeLocationModel response = addPrimeLocationModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      // Navigator.pop(context);
      primelocationController.clear();

      getprimelocationList();
    } else {
      showInSnackBar(context, response.message.toString());
    }
  }

  EditPrime? Primelocation;

  Future<void> getprimelocationbyid(String id) async {
    await apiService.getBearerToken();

    var result = await apiService.getprimelocationbyid(id);
    EditPrimeLocationByIdModel response =
        editPrimeLocationByIdModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        Primelocation = response.list;
        primelocationeditController.text = Primelocation?.name ?? '';
      });

      // Debugging prints
      print("Prime Location: ${Primelocation?.name}");
      print("Text Controller Value: ${primelocationeditController.text}");

      // Show edit dialog
      // _showEditPrimeLoactionDialog();
    } else {
      // Handle failure
      showInSnackBar(context, "Data not found");
    }
  }

//delete
  Future deleteprimelocation(String id) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "id": id,
    };
    print("delete $postData");

    var result = await apiService.deleteprimelocation(postData);
    DeletePrimeLocationModel response =
        deletePrimeLocationModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        getprimelocationList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

//    update

  Future updateprimelocation(String id) async {
    await apiService.getBearerToken();
    // if (thirdpartyForm.currentState!.validate()) {
    Map<String, dynamic> postData = {
      "id": id,
      "name": primelocationController.text,
      "serial": 1
    };
    print("updateItemprime $postData");
    var result = await apiService.updateprimelocation(postData);

    UpdatePrimeLocationModel response =
        updatePrimeLocationModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        Navigator.pop(context, {'update': true});
        primelocationController.clear();

        getprimelocationList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
    // } else {
    //   // showInSnackBar(context, "Please fill all fields");
    // }
  }

//Shimmer
  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                height: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13), // Add border radius
                child: Container(
                  width: 80,
                  height: 60,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 500,
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
        body: isLoading
            ? ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _buildShimmerPlaceholder();
                },
              )
            : SingleChildScrollView(
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
                      controller: primelocationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                                  AppColors.lightGrey5), // Default border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors
                                  .lightGrey5), // Border color when enabled
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  AppColors.red), // Border color when focused
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
                      if (primelocationController.text.toString() == '') {
                        showInSnackBar(context, "Enter the Prime Location");
                      } else {
                        addPrimelocation();
                      }
                    },
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.red),
                        minimumSize: WidgetStatePropertyAll(Size(50, 50)),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 16, color: Colors.white))),
                  )
                ]))),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: PrimeListData != null && PrimeListData!.isNotEmpty

                      // ? SingleChildScrollView(
                      //     scrollDirection: Axis.horizontal,
                      //     child: DataTable(
                      //       border: TableBorder.all(
                      //         color: Colors.black,
                      //         width: 2,
                      //       ),
                      //       columnSpacing: 14,
                      //       horizontalMargin: 6,
                      //       columns: [
                      //         DataColumn(label: Text('S.No')),
                      //         DataColumn(label: Text('Prime Location')),
                      //         DataColumn(label: Text('Edit')),
                      //         DataColumn(label: Text('Delete')),
                      //       ],
                      //       rows: List<DataRow>.generate(
                      //         PrimeListData!.length,
                      //         (index) {
                      //           final element = PrimeListData![index];
                      //           final PrimeId = element.id?.toString() ?? '';
                      //           final primelocation = element.name ?? ' ';

                      //           return DataRow(
                      //             cells: [
                      //               DataCell(Text((index + 1).toString())),
                      //               DataCell(Text(primelocation)),
                      //               DataCell(
                      //                 TextButton.icon(
                      //                   onPressed: () {
                      //                     if (PrimeId.isNotEmpty) {
                      //                       primelocationController.text =
                      //                           primelocation;

                      //                       showDialog(
                      //                         context: context,
                      //                         builder: (context) {
                      //                           return AlertDialog(
                      //                             shape: RoundedRectangleBorder(
                      //                               borderRadius: BorderRadius.all(
                      //                                 Radius.circular(30.0),
                      //                               ),
                      //                             ),
                      //                             content: StatefulBuilder(
                      //                               builder: (BuildContext context,
                      //                                   StateSetter setState) {
                      //                                 return SingleChildScrollView(
                      //                                   child: ConstrainedBox(
                      //                                     constraints: BoxConstraints(
                      //                                       maxHeight: MediaQuery.of(
                      //                                                   context)
                      //                                               .size
                      //                                               .height *
                      //                                           0.8, // Limit height to 80% of the screen
                      //                                     ),
                      //                                     child: Form(
                      //                                       child: Column(
                      //                                         mainAxisSize:
                      //                                             MainAxisSize.min,
                      //                                         children: [
                      //                                           GestureDetector(
                      //                                             onTap: () {
                      //                                               Navigator.of(
                      //                                                       context)
                      //                                                   .pop();
                      //                                               primelocationController
                      //                                                   .clear();
                      //                                             },
                      //                                             child: Align(
                      //                                               alignment:
                      //                                                   Alignment
                      //                                                       .topRight,
                      //                                               child:
                      //                                                   CircleAvatar(
                      //                                                 radius: 17.0,
                      //                                                 backgroundColor:
                      //                                                     Colors
                      //                                                         .black12,
                      //                                                 child: Icon(
                      //                                                   Icons.close,
                      //                                                   color: Colors
                      //                                                       .red,
                      //                                                 ),
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                           SizedBox(height: 20),
                      //                                           TextFormField(
                      //                                             controller:
                      //                                                 primelocationController,
                      //                                             decoration:
                      //                                                 InputDecoration(
                      //                                               hintText:
                      //                                                   'Prime Location',
                      //                                               border:
                      //                                                   OutlineInputBorder(),
                      //                                             ),
                      //                                           ),
                      //                                           SizedBox(height: 10),
                      //                                           // TextFormField(
                      //                                           //   controller:
                      //                                           //       deliverychargeController,
                      //                                           //   decoration:
                      //                                           //       InputDecoration(
                      //                                           //     hintText:
                      //                                           //         'Store Price',
                      //                                           //     border:
                      //                                           //         OutlineInputBorder(),
                      //                                           //   ),
                      //                                           // ),
                      //                                           SizedBox(height: 10),
                      //                                           // TextFormField(
                      //                                           //   controller:
                      //                                           //       deliverychargeController,
                      //                                           //   decoration:
                      //                                           //       InputDecoration(
                      //                                           //     hintText:
                      //                                           //         'Selling Price',
                      //                                           //     border:
                      //                                           //         OutlineInputBorder(),
                      //                                           //   ),
                      //                                           // ),
                      //                                           Container(
                      //                                             margin:
                      //                                                 EdgeInsets.all(
                      //                                                     25),
                      //                                             child:
                      //                                                 ElevatedButton(
                      //                                               onPressed: () {
                      //                                                 if (primelocationController
                      //                                                         .text
                      //                                                         .toString() ==
                      //                                                     '') {
                      //                                                   showInSnackBar(
                      //                                                       context,
                      //                                                       "Enter the Prime Location");
                      //                                                 } else {
                      //                                                   updateprimelocation(
                      //                                                       PrimeId);
                      //                                                 }
                      //                                               },
                      //                                               child: Text(
                      //                                                   'Update'),
                      //                                               style:
                      //                                                   ButtonStyle(
                      //                                                 backgroundColor:
                      //                                                     MaterialStateProperty
                      //                                                         .all(
                      //                                                   AppColors.red,
                      //                                                 ),
                      //                                                 padding:
                      //                                                     MaterialStateProperty
                      //                                                         .all(
                      //                                                   EdgeInsets
                      //                                                       .all(15),
                      //                                                 ),
                      //                                                 textStyle:
                      //                                                     MaterialStateProperty
                      //                                                         .all(
                      //                                                   TextStyle(
                      //                                                     fontSize:
                      //                                                         16,
                      //                                                     color: Colors
                      //                                                         .white,
                      //                                                   ),
                      //                                                 ),
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                             ),
                      //                           );
                      //                         },
                      //                       );
                      //                     }
                      //                   },
                      //                   icon: Icon(Icons.edit, color: Colors.blue),
                      //                   label: Text('Edit'),
                      //                 ),
                      //               ),
                      //               DataCell(
                      //                 TextButton.icon(
                      //                   onPressed: () {
                      //                     if (PrimeId.isNotEmpty) {
                      //                       showDialog(
                      //                         context: context,
                      //                         builder: (context) => AlertDialog(
                      //                           title: Text(
                      //                             'Confirm Deletion',
                      //                             style: TextStyle(color: Colors.red),
                      //                           ),
                      //                           content: Text(
                      //                               'Do you really want to delete this Prime Location?'),
                      //                           actions: [
                      //                             TextButton(
                      //                               onPressed: () {
                      //                                 Navigator.of(context).pop();
                      //                                 deleteprimelocation(PrimeId);
                      //                               },
                      //                               child: Text('Confirm',
                      //                                   style: TextStyle(
                      //                                       color: Colors.red)),
                      //                             ),
                      //                             TextButton(
                      //                               onPressed: () {
                      //                                 Navigator.of(context).pop();
                      //                               },
                      //                               child: Text('Cancel',
                      //                                   style: TextStyle(
                      //                                       color: Colors.grey)),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       );
                      //                     }
                      //                   },
                      //                   icon: Icon(Icons.delete, color: Colors.red),
                      //                   label: Text('Delete'),
                      //                 ),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   )

                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                            child: DataTable(
                              border: TableBorder(
                                horizontalInside: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                                verticalInside: BorderSide.none,
                              ),
                              columnSpacing: 18,
                              horizontalMargin: 8,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    'S.No',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Prime Location',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '    Edit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    '     Delete',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                PrimeListData!.length,
                                (index) {
                                  final element = PrimeListData![index];
                                  final PrimeId = element.id?.toString() ?? '';
                                  final primelocation = element.name ?? ' ';
                                  final isEven = index % 2 == 0;

                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>(
                                      (Set<MaterialState> states) =>
                                          isEven ? Colors.grey.shade100 : null,
                                    ),
                                    cells: [
                                      DataCell(
                                        Text(
                                          (index + 1).toString(),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          primelocation,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      DataCell(
                                        TextButton.icon(
                                          onPressed: () {
                                            if (PrimeId.isNotEmpty) {
                                              primelocationController.text =
                                                  primelocation;

                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20.0),
                                                      ),
                                                    ),
                                                    content: StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                        return SingleChildScrollView(
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.8, // Limit height to 80% of the screen
                                                            ),
                                                            child: Form(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      primelocationController
                                                                          .clear();
                                                                    },
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            17.0,
                                                                        backgroundColor:
                                                                            Colors.black12,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  TextFormField(
                                                                    controller:
                                                                        primelocationController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Prime Location',
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (primelocationController
                                                                              .text
                                                                              .toString() ==
                                                                          '') {
                                                                        showInSnackBar(
                                                                            context,
                                                                            "Enter the Prime Location");
                                                                      } else {
                                                                        updateprimelocation(
                                                                            PrimeId);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        'Update'),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .red,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          label: Text('Edit'),
                                        ),
                                      ),
                                      DataCell(
                                        TextButton.icon(
                                          onPressed: () {
                                            if (PrimeId.isNotEmpty) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                    'Confirm Deletion',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  content: Text(
                                                      'Do you really want to delete this Prime Location?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        deleteprimelocation(
                                                            PrimeId);
                                                      },
                                                      child: Text('Confirm',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          label: Text('Delete'),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            'No Prime Location found.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                ),
              ])));
  }
}
