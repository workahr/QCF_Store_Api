import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/pages/store_menu/add_new_menu.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/heading_widget.dart';

import '../../maincontainer.dart';
import '../api_model/admin_delete_menu_model.dart';
import '../api_model/menu_details_model.dart';
import '../api_model/adminmenu_edit_model.dart';
import '../api_model/menu_list_model.dart';
import '../api_model/mystoredetails_model.dart';
import '../api_model/storestatusupdate_model.dart';
import 'admin_add_menucategory.dart';
import 'admin_add_menuvariant.dart';
import 'admin_add_new_menu.dart';

class MenuDetailsScreenAdmin extends StatefulWidget {
  int? storeId;
  String? storename;
  String? storestatus;
  String? frontimg;
  String? address;
  String? city;
  String? state;
  String? zipcode;

  MenuDetailsScreenAdmin(
      {super.key,
      this.storeId,
      this.storename,
      this.storestatus,
      this.frontimg,
      this.address,
      this.city,
      this.state,
      this.zipcode});
  @override
  _MenuDetailsScreenAdminState createState() => _MenuDetailsScreenAdminState();
}

class _MenuDetailsScreenAdminState extends State<MenuDetailsScreenAdmin> {
  final NamFoodApiService apiService = NamFoodApiService();

  // bool? isOnDuty;
  bool isOnDuty = false;

  bool inStock1 = true;
  String toggleTitle = "Off Duty";
  bool? inStock;
  @override
  void initState() {
    super.initState();
    //  getdashbordlist();
    // getMyStoreDetails();
    getMenuAdminList();
    print(widget.storestatus);
    isOnDuty = widget.storestatus == "1";
    toggleTitle = isOnDuty ? "On Duty" : "Off Duty";
  }

  bool isLoading = false;

  List<MenuDetails> MenuListData = [];
  List<MenuDetails> MenuListAll = [];
  bool isLoading1 = false;

  Future<void> getMenuAdminList() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading1 = true; // Start loading
    });

    try {
      var result = await apiService.getmenuadminList(widget.storeId);
      print("Raw API Response: $result"); // Log raw response for debugging

      // Check if the response is valid JSON
      var jsonResponse;
      try {
        jsonResponse = json.decode(result);
      } catch (e) {
        print("Failed to parse JSON: $e");
        showInSnackBar(context, "Invalid JSON format");
        setState(() => isLoading1 = false);
        return;
      }

      var response = MenuDetailsAdminmodel.fromJson(jsonResponse);
      print("Menu List status: ${response.status}");
      print("Menu List data: ${response.list}");

      if (response.status.toUpperCase() == 'SUCCESS') {
        print("terst");
        setState(() {
          MenuListData = response.list;
          MenuListAll = MenuListData; // Deep copy for further filtering
          isLoading1 = false; // Stop loading after successful fetch
        });
      } else {
        print("API Error Message: ${response.message}");
        //showInSnackBar(context, response.message);
        setState(() {
          MenuListData = [];
          MenuListAll = [];
          isLoading1 = false; // Stop loading on error
        });
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      setState(() {
        MenuListData = [];
        MenuListAll = [];
        isLoading1 = false; // Stop loading on exception
      });
      // showInSnackBar(context, "An error occurred: $e");
    }
  }

// Delete The Menu

  Future deleteMenuById(String itemid, String storeid) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      await apiService.getBearerToken();

      Map<String, dynamic> postData = {"store_id": storeid, "id": itemid};
      print("delete $postData");

      var result = await apiService.admindeleteMenuById(postData);
      AdminDeleteMenumodel response = admindeletemenumodelFromJson(result);

      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          getMenuAdminList();
        });
      } else {
        print(response.message.toString());
        showInSnackBar(context, response.message.toString());
      }
    }
  }

// My Store List

  // StoreDetails? MyStoreDetails;

  // Future getMyStoreDetails() async {
  //   await apiService.getBearerToken();
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     var result = await apiService.getMyStoreDetails();
  //     var response = myStoreDetailsmodelFromJson(result);
  //     if (response.status.toString() == 'SUCCESS') {
  //       setState(() {
  //         MyStoreDetails = response.list;
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         MyStoreDetails = null;
  //         isLoading = false;
  //       });
  //       showInSnackBar(context, response.message.toString());
  //     }
  //   } catch (e) {
  //     setState(() {
  //       MyStoreDetails = null;
  //       isLoading = false;
  //     });
  //     showInSnackBar(context, 'Error occurred: $e');
  //   }

  //   setState(() {});
  // }

  Future updatemenustock(id, value) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "id": id,
      "item_stock": value,
    };
    print("item_stock $postData");
    var result = await apiService.updatemenustock(postData);

    AdminMenuEditAdminmodel response = adminmenuEditmodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      // Navigator.pop(context);
      setState(() {
        getMenuAdminList();
      });
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
  }

// Store Status Update

  Future updateStoreStatus(status) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "store_status": status,
      "store_id": widget.storeId
    };
    print("store_status $postData");
    var result = await apiService.adminupdateStoreStatus(postData);

    StoreStatusUpdateAdminmodel response =
        storeStatusUpdatemodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      // showInSnackBar(context, response.message.toString());
      showInSnackBar(context, "Store Status updated");
      //    Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => AdminMainContainer(admininitialPage: 3)),
        (Route<dynamic> route) => false,
      );
      setState(() {
        //  getMyStoreDetails(); // Update the state variable
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
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
                height: 383,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 283,
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
        toolbarHeight: 95.0,
        leading: Icon(
          size: 30,
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HeadingWidget(
                  title: toggleTitle.toString(),
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                // Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 0.0),
                //     child: Transform.scale(
                //         scale: 0.9,
                //         child: Switch(
                //           value: widget.storestatus == 1, // isOnDuty,
                //           onChanged: (value1) {
                //             setState(() {
                //               print("status ${widget.storestatus}");
                //               isOnDuty = value1;
                //               if (widget.storestatus == 1) {
                //                 toggleTitle = "On Duty";
                //               } else {
                //                 toggleTitle = "Off Duty";
                //               }
                //               updateStoreStatus(value1 ? 1 : 0);
                //               print(value1 ? 1 : 0);
                //             });
                //           },
                //           activeColor: Colors.white,
                //           activeTrackColor: Colors.green,
                //           inactiveThumbColor: Colors.grey,
                //           inactiveTrackColor: Colors.grey.shade300,
                //         ))),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Transform.scale(
                    scale: 0.9,
                    child: Switch(
                      value: isOnDuty, // Use the local boolean value
                      onChanged: (value) {
                        setState(() {
                          isOnDuty = value;

                          // Send updated status as "1" or "0"
                          updateStoreStatus(value ? "1" : "0");

                          // Optional: Debugging print statement
                          print(
                              "Switch toggled. New status: ${value ? "1" : "0"}");
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Color(0xFFE23744),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0, bottom: 0),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color.fromARGB(255, 217, 216, 216),
                            width: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                    //  Image.asset(
                                    //   AppAssets.restaurant_briyani,
                                    //   height: 100,
                                    //   width: 100,
                                    // )
                                    Image.network(
                                        AppConstants.imgBaseUrl +
                                            widget.frontimg.toString(),
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.fill, errorBuilder:
                                            (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                  return Image.asset(
                                    AppAssets.restaurant_briyani,
                                    width: 90,
                                    height: 90,
                                    // fit: BoxFit.cover,
                                  );
                                }),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.storename.toString(),
                                      //'Grill Chicken Arabian\nRestaurant',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "${widget.address.toString()}, ${widget.city.toString()},",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                      "${widget.state.toString()}-${widget.zipcode.toString()},",
                                      //'South Indian Foods',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 0.0, left: 16.0, right: 16.0, bottom: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Image.asset(AppAssets.search_icon),
                          hintText: 'Find your dishes',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        onChanged: (value) {
                          if (value != '') {
                            print('value $value');
                            value = value.toString().toLowerCase();
                            MenuListData = MenuListAll!
                                .where((MenuDetails e) => e.itemName
                                    .toString()
                                    .toLowerCase()
                                    .contains(value))
                                .toList();
                          } else {
                            MenuListData = MenuListAll;
                          }
                          setState(() {});
                        },
                      )),
                  SizedBox(height: 16),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, left: 16.0, right: 16.0, bottom: 5),
                      child: Text('Menus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))),
                  SizedBox(height: 8),
                  isLoading
                      ? ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return _buildShimmerPlaceholder();
                          },
                        )
                      : ListView.builder(
                          itemCount: MenuListData.length,
                          shrinkWrap:
                              true, // Let the list take only as much space as needed
                          physics:
                              NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                          itemBuilder: (context, index) {
                            final e = MenuListData[index];
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 5.0,
                                        left: 16.0,
                                        right: 16.0,
                                        bottom: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                              AppConstants.imgBaseUrl +
                                                  e.itemImageUrl.toString(),
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.fill, errorBuilder:
                                                  (BuildContext context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                            return Image.asset(
                                              AppAssets.store_menu_briyani,
                                              width: 90,
                                              height: 90,
                                              // fit: BoxFit.cover,
                                            );
                                          }),

                                          //     Image.asset(
                                          //   e.itemImageUrl
                                          //       .toString(), // AppAssets.store_menu_briyani,
                                          //   width: 90,
                                          //   height: 90,
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  e.itemType == 1
                                                      ? Image.asset(
                                                          AppAssets.nonveg_icon)
                                                      : Image.asset(
                                                          AppAssets.veg_icon),
                                                  SizedBox(width: 4),
                                                  Text(
                                                      e.itemType == 1
                                                          ? "Non-Veg"
                                                          : "Veg", //'Non-Veg',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                ],
                                              ),
                                              Text(
                                                  e.itemName
                                                      .toString(), //'Chicken Biryani',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Store Org Price  : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        // fontWeight:
                                                        //     FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                      "₹${e.storePrice}", //'₹250.00',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14)),
                                                ],
                                              ),
                                              Row(children: [
                                                Text(
                                                  "Strick Out Price : ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                    "₹${e.itemPrice}", //'₹250.00',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14))
                                              ]),
                                              Row(children: [
                                                Text(
                                                  "Selling Price      : ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      // fontWeight:
                                                      //     FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                    "₹${e.itemOfferPrice}", //'₹250.00',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14))
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: Color.fromARGB(
                                                255, 217, 216, 216),
                                            width: 0.8,
                                          ),
                                          bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 217, 216, 216),
                                            width: 0.8,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 246, 245, 245),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 5,
                                              right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 0.0),
                                                        child: Transform.scale(
                                                            scale: 0.8,
                                                            child: Switch(
                                                              value:
                                                                  e.itemStock ==
                                                                      1,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  e.itemStock =
                                                                      value
                                                                          ? 1
                                                                          : 0;

                                                                  updatemenustock(
                                                                      e.itemId,
                                                                      value
                                                                          ? 1
                                                                          : 0);
                                                                  //  print(e.itemStock);
                                                                });
                                                              },
                                                              activeColor:
                                                                  Colors.white,
                                                              activeTrackColor:
                                                                  Colors.green,
                                                              inactiveThumbColor:
                                                                  Colors.white,
                                                              inactiveTrackColor:
                                                                  Colors.grey[
                                                                      300],
                                                            ))),
                                                    Text(
                                                        e.itemStock == 1
                                                            ? 'In Stock'
                                                            : 'Out of Stock',
                                                        style: TextStyle(
                                                            color:
                                                                e.itemStock == 1
                                                                    ? Colors
                                                                        .green
                                                                    : AppColors
                                                                        .red,
                                                            fontSize: 18.0))
                                                  ]),
                                              GestureDetector(
                                                  onTap: () {
                                                    deleteMenuById(
                                                        e.itemId.toString(),
                                                        widget.storeId
                                                            .toString());
                                                  },
                                                  child: Row(children: [
                                                    Image.asset(AppAssets
                                                        .delete_round_icon),
                                                  ])),
                                              // GestureDetector(
                                              //     onTap: () {
                                              //       Navigator.push(
                                              //           context,
                                              //           MaterialPageRoute(
                                              //               builder: (context) =>
                                              //                   AdminAddMenuvariant(
                                              //                     menuId: e
                                              //                         .itemCategoryId,
                                              //                     storeId:
                                              //                         e.storeId,
                                              //                   ))).then(
                                              //           (value) {});
                                              //     },
                                              //     child: Row(children: [
                                              //       Image.asset(AppAssets
                                              //           .edit_rounded_icon),
                                              //     ])),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminAddNewMenu(
                                                                menuId:
                                                                    e.itemId,
                                                                storeId:
                                                                    e.storeId,
                                                              ))).then(
                                                      (value) {});
                                                },
                                                child: Image.asset(
                                                  AppAssets.edit_rounded_icon,
                                                  height: 60,
                                                  width: 60,
                                                ),
                                              ),
                                            ],
                                          ))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ]);
                          }),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        title: HeadingWidget(title: "Add New Menu"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AdminAddNewMenu(
                                storeId: widget.storeId,
                              );
                            },
                          ));
                        },
                      ),
                      Divider(color: AppColors.grey),
                      ListTile(
                        title: HeadingWidget(title: "Menu Categories"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AdminAddMenuCategory(
                                storeId: widget.storeId,
                              );
                            },
                          ));
                        },
                      ),
                      Divider(color: AppColors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        elevation: 6.0,
      ),
    );
  }
}







// before  price change  



// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:namstore/constants/app_assets.dart';
// import 'package:namstore/constants/app_colors.dart';
// import 'package:namstore/pages/store_menu/add_new_menu.dart';
// import 'package:namstore/pages/store_menu/edit_menu.dart';

// import '../../constants/app_constants.dart';
// import '../../services/comFuncService.dart';
// import '../../services/nam_food_api_service.dart';
// import '../../widgets/heading_widget.dart';
// import '../models/menu_details_model.dart';
// import 'menu_categorie.dart';
// import 'menu_edit_model.dart';
// import 'menu_list_model.dart';
// import 'mystoredetails_model.dart';
// import 'storestatusupdate_model.dart';

// class MenuDetailsScreen extends StatefulWidget {
//   @override
//   _MenuDetailsScreenState createState() => _MenuDetailsScreenState();
// }

// class _MenuDetailsScreenState extends State<MenuDetailsScreen> {
//   final NamFoodApiService apiService = NamFoodApiService();

//   bool? isOnDuty;
//   bool inStock1 = true;
//   String toggleTitle = "On Duty";
//   bool? inStock;
//   @override
//   void initState() {
//     super.initState();
//     getdashbordlist();
//     getMyStoreDetails();
//     getmenuList();
//   }

//   //Store Menu Details

//   List<MenuDetailList> menudeatilslistpage = [];
//   List<MenuDetailList> menudeatilslistpageAll = [];
//   bool isLoading = false;

//   Future getdashbordlist() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var result = await apiService.getmenudetailslist();
//       var response = storemenulistmodelFromJson(result);
//       if (response.status.toString() == 'SUCCESS') {
//         setState(() {
//           menudeatilslistpage = response.list;
//           menudeatilslistpageAll = menudeatilslistpage;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           menudeatilslistpage = [];
//           menudeatilslistpageAll = [];
//           isLoading = false;
//         });
//         showInSnackBar(context, response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         menudeatilslistpage = [];
//         menudeatilslistpageAll = [];
//         isLoading = false;
//       });
//       showInSnackBar(context, 'Error occurred: $e');
//     }

//     setState(() {});
//   }

//   List<MenuList> MenuListData = [];
//   List<MenuList> MenuListAll = [];
//   bool isLoading1 = false;

//   Future<void> getmenuList() async {
//     await apiService.getBearerToken();
//     setState(() {
//       isLoading1 = true; // Start loading
//     });

//     try {
//       var result = await apiService.getmenuList();
//       print("Raw API Response: $result"); // Log raw response for debugging

//       // Check if the response is valid JSON
//       var jsonResponse;
//       try {
//         jsonResponse = json.decode(result);
//       } catch (e) {
//         print("Failed to parse JSON: $e");
//         showInSnackBar(context, "Invalid JSON format");
//         setState(() => isLoading1 = false);
//         return;
//       }

//       var response = MenuListmodel.fromJson(jsonResponse);
//       print("Menu List status: ${response.status}");
//       print("Menu List data: ${response.list}");

//       if (response.status.toUpperCase() == 'SUCCESS') {
//         setState(() {
//           MenuListData = response.list;
//           MenuListAll =
//               List.from(response.list); // Deep copy for further filtering
//           isLoading1 = false; // Stop loading after successful fetch
//         });
//       } else {
//         print("API Error Message: ${response.message}");
//         showInSnackBar(context, response.message);
//         setState(() {
//           MenuListData = [];
//           MenuListAll = [];
//           isLoading1 = false; // Stop loading on error
//         });
//       }
//     } catch (e, stackTrace) {
//       print("Exception: $e");
//       print("StackTrace: $stackTrace");
//       setState(() {
//         MenuListData = [];
//         MenuListAll = [];
//         isLoading1 = false; // Stop loading on exception
//       });
//       showInSnackBar(context, "An error occurred: $e");
//     }
//   }

// // My Store List

//   StoreDetails? MyStoreDetails;

//   Future getMyStoreDetails() async {
//     await apiService.getBearerToken();
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var result = await apiService.getMyStoreDetails();
//       var response = myStoreDetailsmodelFromJson(result);
//       if (response.status.toString() == 'SUCCESS') {
//         setState(() {
//           MyStoreDetails = response.list;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           MyStoreDetails = null;
//           isLoading = false;
//         });
//         showInSnackBar(context, response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         MyStoreDetails = null;
//         isLoading = false;
//       });
//       showInSnackBar(context, 'Error occurred: $e');
//     }

//     setState(() {});
//   }

//   Future updatemenustock(id, value) async {
//     await apiService.getBearerToken();

//     Map<String, dynamic> postData = {
//       "id": id,
//       "item_stock": value,
//     };
//     print("item_stock $postData");
//     var result = await apiService.updatemenustock(postData);

//     MenuEditmodel response = menuEditmodelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       // Navigator.pop(context);
//       setState(() {
//         getmenuList();
//       });
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => Third_party_List(),
//       //   ),
//       // );
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }

// // Store Status Update

//   Future updateStoreStatus(status) async {
//     await apiService.getBearerToken();

//     Map<String, dynamic> postData = {"store_status": status};
//     print("store_status $postData");
//     var result = await apiService.updateStoreStatus(postData);

//     StoreStatusUpdatemodel response = storeStatusUpdatemodelFromJson(result);

//     if (response.status.toString() == 'SUCCESS') {
//       showInSnackBar(context, response.message.toString());
//       //    Navigator.pop(context);
//       setState(() {
//         getMyStoreDetails(); // Update the state variable
//       });
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => Third_party_List(),
//       //   ),
//       // );
//     } else {
//       print(response.message.toString());
//       showInSnackBar(context, response.message.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 95.0,
//         leading: Icon(
//           size: 30,
//           Icons.menu,
//           color: Colors.white,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 HeadingWidget(
//                   title: toggleTitle.toString(),
//                   color: Colors.white,
//                   fontSize: 18.0,
//                 ),
//                 SizedBox(
//                   width: 8.0,
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 0.0),
//                     child: Transform.scale(
//                         scale: 0.9,
//                         child: Switch(
//                           value: MyStoreDetails!.storeStatus == 1, // isOnDuty,
//                           onChanged: (value1) {
//                             setState(() {
//                               isOnDuty = value1;
//                               if (MyStoreDetails!.storeStatus == 1) {
//                                 toggleTitle = "Off Duty";
//                               } else {
//                                 toggleTitle = "On Duty";
//                               }
//                               updateStoreStatus(value1 ? 1 : 0);
//                               print(value1 ? 1 : 0);
//                             });
//                           },
//                           activeColor: Colors.white,
//                           activeTrackColor: Colors.green,
//                           inactiveThumbColor: Colors.grey,
//                           inactiveTrackColor: Colors.grey.shade300,
//                         ))),
//               ],
//             ),
//           )
//         ],
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//         ),
//         backgroundColor: Color(0xFFE23744),
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//                 padding: EdgeInsets.only(
//                     top: 16.0, left: 16.0, right: 16.0, bottom: 0),
//                 child: Container(
//                   margin: EdgeInsets.only(bottom: 16),
//                   //color: Colors.white,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: const Color.fromARGB(255, 217, 216, 216),
//                       width: 0.8,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white,
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child:
//                               //  Image.asset(
//                               //   AppAssets.restaurant_briyani,
//                               //   height: 100,
//                               //   width: 100,
//                               // )
//                               Image.network(
//                                   AppConstants.imgBaseUrl +
//                                       MyStoreDetails!.frontImg.toString(),
//                                   width: 90,
//                                   height: 90,
//                                   fit: BoxFit.fill, errorBuilder:
//                                       (BuildContext context, Object exception,
//                                           StackTrace? stackTrace) {
//                             return Image.asset(
//                               AppAssets.restaurant_briyani,
//                               width: 90,
//                               height: 90,
//                               // fit: BoxFit.cover,
//                             );
//                           }),
//                         ),
//                         SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(MyStoreDetails!.name.toString(),
//                                 //'Grill Chicken Arabian\nRestaurant',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20)),
//                             SizedBox(height: 8),
//                             Text('South Indian Foods',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 14)),
//                             SizedBox(height: 4),
//                             // Text('Open Time: 8.30am - 11.00pm',
//                             //     style: TextStyle(
//                             //         color: Colors.black, fontSize: 14)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//             Padding(
//                 padding: EdgeInsets.only(
//                     top: 0.0, left: 16.0, right: 16.0, bottom: 5),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     prefixIcon: Image.asset(AppAssets.search_icon),
//                     hintText: 'Find your dishes',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                   ),
//                 )),
//             SizedBox(height: 16),
//             Padding(
//                 padding: EdgeInsets.only(
//                     top: 5.0, left: 16.0, right: 16.0, bottom: 5),
//                 child: Text('Menus',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
//             SizedBox(height: 8),
//             isLoading1
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: MenuListData.length,
//                     shrinkWrap:
//                         true, // Let the list take only as much space as needed
//                     physics:
//                         NeverScrollableScrollPhysics(), // Disable scrolling for ListView
//                     itemBuilder: (context, index) {
//                       final e = MenuListData[index];
//                       return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   top: 5.0, left: 16.0, right: 16.0, bottom: 8),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.network(
//                                         AppConstants.imgBaseUrl +
//                                             e.itemImageUrl.toString(),
//                                         width: 90,
//                                         height: 90,
//                                         fit: BoxFit.fill, errorBuilder:
//                                             (BuildContext context,
//                                                 Object exception,
//                                                 StackTrace? stackTrace) {
//                                       return Image.asset(
//                                         AppAssets.store_menu_briyani,
//                                         width: 90,
//                                         height: 90,
//                                         // fit: BoxFit.cover,
//                                       );
//                                     }),

//                                     //     Image.asset(
//                                     //   e.itemImageUrl
//                                     //       .toString(), // AppAssets.store_menu_briyani,
//                                     //   width: 90,
//                                     //   height: 90,
//                                     //   fit: BoxFit.cover,
//                                     // ),
//                                   ),
//                                   SizedBox(width: 12),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             e.itemType == 1
//                                                 ? Image.asset(
//                                                     AppAssets.nonveg_icon)
//                                                 : Image.asset(
//                                                     AppAssets.veg_icon),
//                                             SizedBox(width: 4),
//                                             Text(
//                                                 e.itemType == 1
//                                                     ? "Non-Veg"
//                                                     : "Veg", //'Non-Veg',
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 14)),
//                                           ],
//                                         ),
//                                         Text(
//                                             e.itemName
//                                                 .toString(), //'Chicken Biryani',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18)),
//                                         SizedBox(height: 4),
//                                         Text("₹${e.storePrice}", //'₹250.00',
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 14)),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border(
//                                     top: BorderSide(
//                                       color: Color.fromARGB(255, 217, 216, 216),
//                                       width: 0.8,
//                                     ),
//                                     bottom: BorderSide(
//                                       color: Color.fromARGB(255, 217, 216, 216),
//                                       width: 0.8,
//                                     ),
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color.fromARGB(255, 246, 245, 245),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 10,
//                                         bottom: 10,
//                                         left: 10,
//                                         right: 40),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                             // mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(vertical: 0.0),
//                                                   child: Transform.scale(
//                                                       scale: 0.8,
//                                                       child: Switch(
//                                                         value: e.itemStock == 1,
//                                                         onChanged: (value) {
//                                                           setState(() {
//                                                             e.itemStock =
//                                                                 value ? 1 : 0;

//                                                             updatemenustock(
//                                                                 e.itemId,
//                                                                 value ? 1 : 0);
//                                                             //  print(e.itemStock);
//                                                           });
//                                                         },
//                                                         activeColor:
//                                                             Colors.white,
//                                                         activeTrackColor:
//                                                             Colors.green,
//                                                         inactiveThumbColor:
//                                                             Colors.white,
//                                                         inactiveTrackColor:
//                                                             Colors.grey[300],
//                                                       ))),
//                                               Text(
//                                                   e.itemStock == 1
//                                                       ? 'In Stock'
//                                                       : 'Out of Stock',
//                                                   style: TextStyle(
//                                                       color: e.itemStock == 1
//                                                           ? Colors.green
//                                                           : AppColors.red,
//                                                       fontSize: 18.0))
//                                             ]),
//                                         GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           AddNewMenu(
//                                                             menuId: e.itemId,
//                                                           ))).then((value) {});
//                                             },
//                                             child: Row(
//                                                 // mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Image.asset(
//                                                       AppAssets.edit_icon),
//                                                   Text(' Edit',
//                                                       style: TextStyle(
//                                                           color: AppColors.red,
//                                                           fontSize: 18.0))
//                                                 ])),
//                                       ],
//                                     ))),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ]);
//                     }),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             isScrollControlled: true,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             builder: (BuildContext context) {
//               return Container(
//                 height: 200,
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         title: HeadingWidget(title: "Add New Menu"),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return AddNewMenu();
//                             },
//                           ));
//                         },
//                       ),
//                       Divider(color: AppColors.grey),
//                       ListTile(
//                         title: HeadingWidget(title: "Menu Categories"),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return MenuCategorie();
//                             },
//                           ));
//                         },
//                       ),
//                       Divider(color: AppColors.grey),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         shape: CircleBorder(),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         backgroundColor: AppColors.red,
//         elevation: 6.0,
//       ),
//     );
//   }
// }
