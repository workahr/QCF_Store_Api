import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../models/adminstore_model.dart';
import 'add_store_page.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final NamFoodApiService apiService = NamFoodApiService();
  @override
  void initState() {
    super.initState();
    getstoredetailslist();
  }

  //Store Menu Details

  List<AdminStoreList> storedetaillistpage = [];
  List<AdminStoreList> storedetaillistpageAll = [];
  bool isLoading = false;

  Future getstoredetailslist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getstoredetailslist();
      var response = adminstorelistmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
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

  // Sample store data
  List<Map<String, String>> storeData = [
    {
      "name": "Grill Chicken Arabian Restaurant",
      "status": "Active",
      "address":
          "No 37 Paranjothi Nagar Thalakoidi, velour Nagar Trichy-620005",
      "contactName": "Sulaiman",
      "contactNumber": "+91-9787921226"
    },
    {
      "name": "Pizza Palace",
      "status": "Active",
      "address": "No 10 Main Street, Chennai-600012",
      "contactName": "Rahul",
      "contactNumber": "+91-9876543210"
    },
  ];

  void _deleteStore(int index) {
    setState(() {
      storeData.removeAt(index);
    });
  }

  void _toggleStatus(int index) {
    setState(() {
      storeData[index]["status"] =
          storeData[index]["status"] == "Active" ? "Inactive" : "Active";
    });
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
      body: ListView.builder(
        itemCount: storedetaillistpage.length,
        shrinkWrap: true, // Let the list take only as much space as needed
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
                      Image.asset(
                        e.image.toString(),
                      ),

                      // Image.asset(
                      //   AppAssets.admin_store_list_image,
                      // ),
                      Positioned(
                        top: 12.0,
                        left: 12.0,
                        child: GestureDetector(
                          onTap: () => _toggleStatus(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: e.storestatus == "Active"
                                  ? Colors.green
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              e.storestatus.toString(), // store["status"]!,
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
                      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              e.storename.toString(),
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
                                onTap: () {},
                                child: Image.asset(
                                  AppAssets.delete_round_icon,
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {},
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
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
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
                              e.storeAddress.toString(),
                              // store["address"]!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                    child: Divider(color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
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
                              color: const Color.fromARGB(255, 221, 220, 220),
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
                                e.storeOwnername.toString(),
                                // store["contactName"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                e.storeOwnernumber.toString(),
                                // store["contactNumber"]!,
                                style: const TextStyle(color: Colors.black),
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
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                      child: Divider(color: Colors.grey[300])),
                  const SizedBox(height: 8),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Add "View details" functionality here
                          },
                          child: const Text(
                            "View details",
                            style: TextStyle(color: Colors.red, fontSize: 14),
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
