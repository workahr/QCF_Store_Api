import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';

import '../../store_menu/menu_details_screen.dart';
import '../api_model/delete_store_model.dart';
import '../api_model/store_list_model.dart';

import 'add_store_page.dart';
import 'menu_details_screen_admin.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final NamFoodApiService apiService = NamFoodApiService();
  @override
  void initState() {
    super.initState();
    getStoreList();
  }

  //Store Menu Details

  List<StoreListData> storedetaillistpage = [];
  List<StoreListData> storedetaillistpageAll = [];
  bool isLoading = false;

  Future getStoreList() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getStoreList();
      var response = storeListmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          print("hi");
          storedetaillistpage = response.list;
          storedetaillistpageAll = storedetaillistpage;
          isLoading = false;
        });
      } else {
        setState(() {
          storedetaillistpage = [];
          storedetaillistpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        storedetaillistpage = [];
        storedetaillistpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  Future deleteStoreById(String storeid, String userid) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {"user_id": userid, "store_id": storeid};
    print("delete $postData");

    var result = await apiService.deleteStoreById(postData);
    DeleteStoremodel response = deleteStoremodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        getStoreList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100.0,
        backgroundColor: Color(0xFFE23744),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("Store List", style: TextStyle(color: Colors.white))],
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: storedetaillistpage.length,
              shrinkWrap:
                  true, // Let the list take only as much space as needed
              physics: ScrollPhysics(), // Disable scrolling for ListView
              itemBuilder: (context, index) {
                final e = storedetaillistpage[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                                AppConstants.imgBaseUrl + e.frontImg.toString(),
                                width: double.infinity,
                                height: 90,
                                fit: BoxFit.fill, errorBuilder:
                                    (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                              return Image.asset(
                                AppAssets.admin_store_list_image,
                                // width: 90,
                                // height: 90,
                                // fit: BoxFit.cover,
                              );
                            }),

                            // Image.asset(
                            //   AppAssets.admin_store_list_image,
                            // ),
                            Positioned(
                              top: 12.0,
                              left: 12.0,
                              child: GestureDetector(
                                onTap: () {}, //_toggleStatus(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: e.storeStatus == 1
                                        ? Colors.green
                                        : AppColors.red,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                    e.storeStatus == 1
                                        ? 'Active'
                                        : "Not Active", // store["status"]!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.name.toString(),
                                    //store["name"]!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        deleteStoreById(e.storeId.toString(),
                                            e.userId.toString());
                                      },
                                      child: Image.asset(
                                        AppAssets.delete_round_icon,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddStorePage(
                                              storeId: e.storeId,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        AppAssets.edit_rounded_icon,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(height: 8),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  AppAssets.map_location_icon,
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    e.address.toString(),
                                    // store["address"]!,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 8),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                          child: Divider(color: Colors.grey[300]),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 221, 220, 220),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    AppAssets.UserRounded,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      8.0), // Add space between the avatar and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the left
                                  children: [
                                    Text(
                                      e.owner_name.toString(),
                                      // store["contactName"]!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    Text(
                                      e.mobile.toString(),
                                      // store["contactNumber"]!,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: 35.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                    // border: Border.all(
                                    //   color: const Color.fromARGB(255, 221, 220, 220),
                                    // ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      AppAssets.call_icon,
                                      height: 25,
                                      width: 25,
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                            child: Divider(color: Colors.grey[300])),
                        const SizedBox(height: 8),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 0.0, 16.0, 16.0),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuDetailsScreenAdmin(
                                                  storeId: e.storeId)));
                                },
                                child: const Text(
                                  "View Menu",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStorePage(),
            ),
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
