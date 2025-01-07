import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/custom_autocomplete_widget.dart';
import '../api_model/add_sub_location_model.dart';
import '../api_model/delete_sublocation_model.dart';
import '../api_model/edit_sub_location_model.dart';
import '../api_model/mainlocation_list_model.dart';
import '../api_model/sub_location_list_model.dart';
import '../api_model/update_sub_location_model.dart';

class AddDeliveryChargePage extends StatefulWidget {
  const AddDeliveryChargePage({super.key});

  @override
  State<AddDeliveryChargePage> createState() => _AddDeliveryChargePageState();
}

class _AddDeliveryChargePageState extends State<AddDeliveryChargePage> {
  // List<String> industrynamelist = [];
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();
  final TextEditingController subController = TextEditingController();
  final TextEditingController deliverychargeController =
      TextEditingController();
  final TextEditingController subeditController = TextEditingController();
  final TextEditingController deliverychargeeditController =
      TextEditingController();

  List<SubList>? SubListData;
  List<SubList>? SubListDataAll;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getallmainlocationList();
    getsublocationList();
  }

  Future<void> getsublocationList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getsublocationList();
    var response = subLocationListModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        SubListData = response.list;
        SubListDataAll = SubListData;
        isLoading = false;
      });
    } else {
      setState(() {
        SubListData = [];
        SubListDataAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
  }

  //add

  Future<void> addsublocation() async {
    await apiService.getBearerToken();
    Map<String, dynamic> postData = {
      "name": subController.text,
      "main_location_id": selectedmainlocationId,
      "price": deliverychargeController.text,
      "serial": "1"
    };
    print(postData);
    var result = await apiService.addsublocation(postData);
    AddSubLocationModel response = addSubLocationModelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      // Navigator.pop(context);
      subController.clear();
      deliverychargeController.clear();
      setState(() {
        selectedmainlocationId = null; // Reset the selected ID
        selectedmainlocation = null; // Reset the selected name (if needed)
        selectedmainlocationedit =
            null; // Reset the selected item for the autocomplete widget
      });
      getsublocationList();
    } else {
      showInSnackBar(context, response.message.toString());
    }
  }

  EditSub? Sublocation;

  Future<void> getprimelocationbyid(String id) async {
    // Fetch bearer token
    await apiService.getBearerToken();

    var result = await apiService.getsublocationbyid(id);
    EditSubLocationByIdModel response =
        editSubLocationByIdModelFromJson(result);

    // Check response status
    if (response.status.toString() == 'SUCCESS') {
      print("mainLocationId${Sublocation?.mainLocationId}");
      setState(() {
        Sublocation = response.list;
        selectedmainlocationId = Sublocation?.mainLocationId;
        subController.text = Sublocation?.name ?? '';
        deliverychargeController.text = Sublocation?.price ?? '';
        print("mainLocationId${Sublocation?.mainLocationId}");
      });

      // Debugging prints
      print("Prime Location: ${Sublocation?.name}");
      print("Text Controller Value: ${subeditController.text}");
      print("Text Controller Value: ${deliverychargeController.text}");

      // Show edit dialog
      // _showEditPrimeLoactionDialog();
    } else {
      // Handle failure
      showInSnackBar(context, "Data not found");
    }
  }

// //delete
  Future deletesublocation(String id) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "id": id,
    };
    print("delete $postData");

    var result = await apiService.deletesublocation(postData);
    DeleteSubLocationModel response = deleteSubLocationModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        getsublocationList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

//    update

  Future updatesublocation(String id) async {
    await apiService.getBearerToken();
    // if (thirdpartyForm.currentState!.validate()) {
    Map<String, dynamic> postData = {
      "id": id,
      "name": subController.text,
      "main_location_id": selectedmainlocationId,
      "price": deliverychargeController.text,
      "serial": 1
    };
    print("updateItemsub location $postData");
    var result = await apiService.updatesublocation(postData);

    UpdateSubLocationModel response = updateSubLocationModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        Navigator.pop(context, {'update': true});
        subController.clear();
        deliverychargeController.clear();

        getsublocationList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
    // } else {
    //   // showInSnackBar(context, "Please fill all fields");
    // }
  }

  // Dropdown items

  String? selectedmainlocation;
  int? selectedmainlocationId;

  selectedmainlocationArray() {
    List result;

    if (MainLocationListdata!.isNotEmpty) {
      result = MainLocationListdata!
          .where((element) => element.id == selectedmainlocationId)
          .toList();

      if (result.isNotEmpty) {
        setState(() {
          print("result a 2 drop:$result");
          selectedmainlocationedit = result[0];
        });
      } else {
        setState(() {
          selectedmainlocationedit = null;
        });
      }
    } else {
      setState(() {
        print('selectedVisitPurposeArr empty');

        selectedmainlocationedit = null;
      });
    }
  }

  var selectedmainlocationedit;

  List<MainLocation>? MainLocationListdata;
  List<MainLocation>? MainLocationListdataAll;
  bool isLoadingmain = false;

  Future getallmainlocationList() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getallmainlocationList();
    var response = mainLocationListmodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        MainLocationListdata = response.list;
        MainLocationListdataAll = MainLocationListdata;
        isLoading = false;
        // if (widget. != null) {
        //   selectedmainlocationArray();
        // }
      });
    } else {
      setState(() {
        MainLocationListdata = [];
        MainLocationListdataAll = [];
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
        toolbarHeight: 100.0,
        title: const Text(
          'Add Delivery Charge',
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
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    if (MainLocationListdata != null)
                      CustomAutoCompleteWidget(
                        width: MediaQuery.of(context).size.width / 1.1,
                        selectedItem: selectedmainlocationedit,
                        labelText: 'Select Main Location',
                        labelField: (item) => item.name,
                        onChanged: (value) {
                          selectedmainlocation = value.name;
                          selectedmainlocationId = value.id;
                          print("mainlocation id$selectedmainlocationId");
                          // getallsublocationList(selectedmainlocationId);
                        },
                        valArr: MainLocationListdata,
                      ),

                    // const SizedBox(height: 16),
                    // TextField
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        cursorColor: AppColors.red,
                        controller: subController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: AppColors
                                    .lightGrey5), // Default border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color:
                                    AppColors.red), // Border color when focused
                          ),
                          floatingLabelStyle: TextStyle(color: AppColors.red),
                          labelText: 'Sub Location',
                          labelStyle: TextStyle(color: AppColors.lightGrey5),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        cursorColor: AppColors.red,
                        controller: deliverychargeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color:
                                  AppColors.lightGrey5, // Default border color
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.red, // Border color when focused
                            ),
                          ),
                          floatingLabelStyle: TextStyle(color: AppColors.red),
                          labelText: 'Delivery Charge',
                          labelStyle: TextStyle(color: AppColors.lightGrey5),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    ElevatedButton(
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (subController.text.toString() == '' ||
                            deliverychargeController.text.toString() == "") {
                          showInSnackBar(context, "Enter the All Fields");
                        } else if (selectedmainlocationId == '' ||
                            selectedmainlocationId == null ||
                            selectedmainlocationId == "null" ||
                            selectedmainlocationId == 0) {
                          showInSnackBar(context, "Enter the All Fields");
                        } else {
                          addsublocation();
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.red),
                        minimumSize:
                            MaterialStateProperty.all(const Size(50, 50)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: SubListData != null && SubListData!.isNotEmpty
                  // ? SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: DataTable(
                  //       border: TableBorder.all(
                  //         color: Colors.black,
                  //         width: 2,
                  //       ),
                  //       columnSpacing: 10,
                  //       horizontalMargin: 6,
                  //       columns: [
                  //         DataColumn(label: Text('S.No')),
                  //         DataColumn(label: Text('Main Location')),
                  //         DataColumn(label: Text('Sub Location')),
                  //         DataColumn(label: Text('Delivery Charge')),
                  //         DataColumn(label: Text('Edit')),
                  //         DataColumn(label: Text('Delete')),
                  //       ],
                  //       rows: List<DataRow>.generate(
                  //         SubListData!.length,
                  //         (index) {
                  //           final element = SubListData![index];
                  //           final subId = element.id?.toString() ?? '';
                  //           final mainid = element.mainLocationId;
                  //           final deliveryCharge =
                  //               element.price.toString() == null
                  //                   ? ""
                  //                   : element.price.toString();
                  //           final sublocation = element.name ?? ' ';
                  //           final mainLocationMap = {
                  //             for (var location in MainLocationListdata ?? [])
                  //               location.id: location.name
                  //           };

                  //           final mainLocationName =
                  //               mainLocationMap[mainid] ?? ' ';
                  //           print(
                  //               'Index: $index, SubId: $subId, MainLocation: $mainLocationName');

                  //           return DataRow(
                  //             cells: [
                  //               DataCell(Text((index + 1).toString())),
                  //               DataCell(Text(mainLocationName)),
                  //               DataCell(Text(sublocation)),
                  //               DataCell(Text(deliveryCharge)),
                  //               DataCell(
                  //                 TextButton.icon(
                  //                   onPressed: () {
                  //                     if (subId.isNotEmpty) {
                  //                       subController.text = sublocation;
                  //                       deliverychargeController.text =
                  //                           deliveryCharge;

                  //                       selectedmainlocationId = mainid;
                  //                       print(
                  //                           "mainlocation${selectedmainlocationId}");
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
                  //                                     constraints:
                  //                                         BoxConstraints(
                  //                                       maxHeight:
                  //                                           MediaQuery.of(
                  //                                                       context)
                  //                                                   .size
                  //                                                   .height *
                  //                                               0.8,
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
                  //                                               subController
                  //                                                   .clear();
                  //                                               deliverychargeController
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
                  //                                           SizedBox(
                  //                                               height: 20),
                  //                                           if (MainLocationListdata !=
                  //                                               null)
                  //                                             CustomAutoCompleteWidget(
                  //                                               width: MediaQuery.of(
                  //                                                           context)
                  //                                                       .size
                  //                                                       .width *
                  //                                                   2,
                  //                                               selectedItem:
                  //                                                   MainLocationListdata!
                  //                                                       .firstWhere(
                  //                                                 (item) =>
                  //                                                     item.id ==
                  //                                                     selectedmainlocationId,
                  //                                                 // Default value
                  //                                               ),
                  //                                               labelText:
                  //                                                   'Select Main Location',
                  //                                               labelField:
                  //                                                   (item) =>
                  //                                                       item.name,
                  //                                               onChanged:
                  //                                                   (value) {
                  //                                                 selectedmainlocation =
                  //                                                     value
                  //                                                         .name;
                  //                                                 selectedmainlocationId =
                  //                                                     value.id;
                  //                                                 print(
                  //                                                     "mainlocation id: $selectedmainlocationId");
                  //                                               },
                  //                                               valArr:
                  //                                                   MainLocationListdata,
                  //                                             ),
                  //                                           SizedBox(
                  //                                               height: 20),
                  //                                           TextFormField(
                  //                                             controller:
                  //                                                 subController,
                  //                                             decoration:
                  //                                                 InputDecoration(
                  //                                               hintText:
                  //                                                   'Sub Location',
                  //                                               border:
                  //                                                   OutlineInputBorder(),
                  //                                             ),
                  //                                           ),
                  //                                           SizedBox(
                  //                                               height: 10),
                  //                                           TextFormField(
                  //                                             controller:
                  //                                                 deliverychargeController,
                  //                                             keyboardType:
                  //                                                 TextInputType
                  //                                                     .number,
                  //                                             inputFormatters: [
                  //                                               FilteringTextInputFormatter
                  //                                                   .digitsOnly,
                  //                                             ],
                  //                                             decoration:
                  //                                                 InputDecoration(
                  //                                               hintText:
                  //                                                   'Delivery Charge',
                  //                                               border:
                  //                                                   OutlineInputBorder(),
                  //                                             ),
                  //                                           ),
                  //                                           SizedBox(
                  //                                               height: 10),
                  //                                           Container(
                  //                                             margin: EdgeInsets
                  //                                                 .all(25),
                  //                                             child:
                  //                                                 ElevatedButton(
                  //                                               onPressed: () {
                  //                                                 if (subController
                  //                                                         .text
                  //                                                         .trim()
                  //                                                         .isEmpty ||
                  //                                                     deliverychargeController
                  //                                                         .text
                  //                                                         .trim()
                  //                                                         .isEmpty) {
                  //                                                   showInSnackBar(
                  //                                                       context,
                  //                                                       "Enter the All Fields");
                  //                                                 } else if (selectedmainlocationId ==
                  //                                                         '' ||
                  //                                                     selectedmainlocationId ==
                  //                                                         null ||
                  //                                                     selectedmainlocationId ==
                  //                                                         "null" ||
                  //                                                     selectedmainlocationId ==
                  //                                                         0) {
                  //                                                   showInSnackBar(
                  //                                                       context,
                  //                                                       "Enter the All Fields");
                  //                                                 } else {
                  //                                                   updatesublocation(
                  //                                                       subId);
                  //                                                 }
                  //                                               },
                  //                                               child: Text(
                  //                                                   'Update'),
                  //                                               style:
                  //                                                   ButtonStyle(
                  //                                                 backgroundColor:
                  //                                                     MaterialStateProperty
                  //                                                         .all(
                  //                                                   AppColors
                  //                                                       .red,
                  //                                                 ),
                  //                                                 padding:
                  //                                                     MaterialStateProperty
                  //                                                         .all(
                  //                                                   EdgeInsets
                  //                                                       .all(
                  //                                                           15),
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
                  //                     if (subId.isNotEmpty) {
                  //                       showDialog(
                  //                         context: context,
                  //                         builder: (context) => AlertDialog(
                  //                           title: Text(
                  //                             'Confirm Deletion',
                  //                             style:
                  //                                 TextStyle(color: Colors.red),
                  //                           ),
                  //                           content: Text(
                  //                               'Do you really want to delete this Sub Location'),
                  //                           actions: [
                  //                             TextButton(
                  //                               onPressed: () {
                  //                                 Navigator.of(context).pop();
                  //                                 deletesublocation(subId);
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Main Location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Sub Location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Delivery Charge',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '     Edit',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '   Delete',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            SubListData!.length,
                            (index) {
                              final element = SubListData![index];
                              final subId = element.id?.toString() ?? '';
                              final mainid = element.mainLocationId;
                              final deliveryCharge =
                                  element.price?.toString() ?? '';
                              final subLocation = element.name ?? ' ';
                              final mainLocationMap = {
                                for (var location in MainLocationListdata ?? [])
                                  location.id: location.name
                              };
                              final mainLocationName =
                                  mainLocationMap[mainid] ?? ' ';
                              final isEven = index % 2 == 0;

                              return DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) =>
                                      isEven ? Colors.grey.shade100 : null,
                                ),
                                cells: [
                                  DataCell(Text((index + 1).toString())),
                                  DataCell(Text(mainLocationName)),
                                  DataCell(Text(subLocation)),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(deliveryCharge),
                                    ),
                                  ),
                                  DataCell(
                                    TextButton.icon(
                                      onPressed: () {
                                        if (subId.isNotEmpty) {
                                          subController.text = subLocation;
                                          deliverychargeController.text =
                                              deliveryCharge;

                                          selectedmainlocationId = mainid;
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                ),
                                                content: StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return SingleChildScrollView(
                                                      child: Form(
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                subController
                                                                    .clear();
                                                                deliverychargeController
                                                                    .clear();
                                                              },
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 15.0,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black12,
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            CustomAutoCompleteWidget(
                                                              selectedItem:
                                                                  MainLocationListdata!
                                                                      .firstWhere(
                                                                (item) =>
                                                                    item.id ==
                                                                    selectedmainlocationId,
                                                              ),
                                                              labelText:
                                                                  'Select Main Location',
                                                              labelField:
                                                                  (item) =>
                                                                      item.name,
                                                              onChanged:
                                                                  (value) {
                                                                selectedmainlocation =
                                                                    value.name;
                                                                selectedmainlocationId =
                                                                    value.id;
                                                              },
                                                              valArr:
                                                                  MainLocationListdata,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            TextFormField(
                                                              controller:
                                                                  subController,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Sub Location',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            TextFormField(
                                                              controller:
                                                                  deliverychargeController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly,
                                                              ],
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Delivery Charge',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                if (subController.text.trim().isEmpty ||
                                                                    deliverychargeController
                                                                        .text
                                                                        .trim()
                                                                        .isEmpty ||
                                                                    selectedmainlocationId ==
                                                                        '') {
                                                                  showInSnackBar(
                                                                      context,
                                                                      "Enter all fields");
                                                                } else {
                                                                  updatesublocation(
                                                                      subId);
                                                                }
                                                              },
                                                              child: Text(
                                                                  'Update'),
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        AppColors
                                                                            .red),
                                                                padding: MaterialStateProperty
                                                                    .all(EdgeInsets
                                                                        .all(
                                                                            15)),
                                                                textStyle: MaterialStateProperty
                                                                    .all(TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .white)),
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
                                        }
                                      },
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      label: Text('Edit'),
                                    ),
                                  ),
                                  DataCell(
                                    TextButton.icon(
                                      onPressed: () {
                                        if (subId.isNotEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Confirm Deletion',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              content: Text(
                                                  'Do you really want to delete this Sub Location?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    deletesublocation(subId);
                                                  },
                                                  child: Text('Confirm',
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel',
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
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
                        'No Sub Location found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
