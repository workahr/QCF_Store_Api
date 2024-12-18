import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/dashboard_orderlist_model.dart';
import 'deliveryperson.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final NamFoodApiService apiService = NamFoodApiService();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    getallDashboardOrderdetailslist();
  }

  List<OrderList> orderdetailslistpage = [];
  List<OrderList> orderdetailslistpageAll = [];
  List<OrderList> unassigneddeliveryboy = [];
  List<OrderList> inprogress = [];
  List<OrderList> orderdelivered = [];
  bool isLoading = false;

  int? totalOrdersCount;
  double? totalOrderPrice;

  // Update the filter function to handle both parameters properly
  List<OrderList> filterOrdersByStatus(String status,
      {String? deliveryPartnerId}) {
    return orderdetailslistpageAll.where((entry) {
      final matchesStatus = entry.orderStatus == status;
      final matchesDeliveryPartner = deliveryPartnerId == null ||
          entry.deliveryPartnerId == deliveryPartnerId;
      return matchesStatus && matchesDeliveryPartner;
    }).toList();
  }

  Future<void> getallDashboardOrderdetailslist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getallDashboardOrderdetailslist();
      var response = orderListmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        setState(() {
          orderdetailslistpage = response.list;
          orderdetailslistpageAll = orderdetailslistpage;

          // Apply filters
          unassigneddeliveryboy =
              filterOrdersByStatus("Order Placed", deliveryPartnerId: '0');
          print("tap 1 :${unassigneddeliveryboy}");
          inprogress = orderdetailslistpageAll.where((entry) {
            return entry.orderStatus == "Order Confirmed" &&
                entry.deliveryPartnerId != "0";
          }).toList();
          print("tap 2 :${inprogress}"); // Example deliveryPartnerId
          orderdelivered = orderdetailslistpageAll.where((entry) {
            return entry.orderStatus == "Order Delivered" &&
                entry.deliveryPartnerId != "0";
          }).toList();
          print("tap 3 :${orderdelivered}");

          isLoading = false;
        });
      } else {
        setState(() {
          orderdetailslistpage = [];
          orderdetailslistpageAll = [];

          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        orderdetailslistpage = [];
        orderdetailslistpageAll = [];

        isLoading = false;
      });
      // Handle the error (e.g., show a snack bar)
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }

  Future<void> whatsapp(String contact) async {
    String androidUrl = "whatsapp://send?phone=$contact";
    String iosUrl = "https://wa.me/$contact";
    String webUrl = "https://api.whatsapp.com/send/?phone=$contact";
    print("contact number $contact");
    try {
      if (await canLaunchUrl(Uri.parse(androidUrl))) {
        await launchUrl(Uri.parse(androidUrl));
      } else if (await canLaunchUrl(Uri.parse(iosUrl))) {
        await launchUrl(Uri.parse(iosUrl),
            mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(webUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch WhatsApp for $contact: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          children: [Text("Home", style: TextStyle(color: Colors.white))],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(children: [
          // Order Status Tabs
          // SizedBox(
          //   height: 10.0,
          // ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusTab(
                    'New Order (${unassigneddeliveryboy.length.toString()})',
                    0),
                _buildStatusTab(
                    'InProgress (${inprogress.length.toString()})', 1),
                _buildStatusTab(
                    'Delivered (${orderdelivered.length.toString()})', 2),
              ],
            ),
          ),

//New Order
          if (selectedIndex == 0 && unassigneddeliveryboy.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount: unassigneddeliveryboy.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final e = unassigneddeliveryboy[index];

                final currentCustomerAddress = e.customerAddress;
                // final currentStoreAddress = e.storeAddress;
                String formattedDate = e.createdDate != null
                    ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                    : '';

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: e.orderStatus != "Cancelled"
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Date : ${formattedDate ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: e.orderStatus ==
                                                    "Order Confirmed" ||
                                                e.orderStatus ==
                                                    "On Delivery" ||
                                                e.orderStatus == "Order Placed"
                                            ? Colors.green
                                            : AppColors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        e.orderStatus ?? 'Unknown Status',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pick Point: ",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Container(
                                                  height: 1,
                                                  color: Colors.black,
                                                  width: 80),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Row(children: [
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         _makePhoneCall(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.call_iconfill,
                                      //           height: 35,
                                      //           width: 35)),
                                      //   SizedBox(
                                      //     width: 5,
                                      //   ),
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         whatsapp(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.whatsapp_icon,
                                      //           // color: Colors.green,
                                      //           height: 35,
                                      //           width: 35)),
                                      // ])
                                    ]),
                                SizedBox(height: 10),
                                // Text(
                                //   "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                //   style: TextStyle(fontSize: 14),
                                // ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(Icons.location_on_outlined),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Delivery Point:",
                                              style: TextStyle(fontSize: 16)),
                                          Container(
                                              height: 1,
                                              color: Colors.black,
                                              width: 110),
                                        ],
                                      ),
                                    ]),
                                    Row(children: [
                                      GestureDetector(
                                          onTap: () async {
                                            _makePhoneCall(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.call_iconfill,
                                              height: 35,
                                              width: 35)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            whatsapp(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.whatsapp_icon,
                                              //  color: Colors.green,
                                              height: 35,
                                              width: 35))
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${currentCustomerAddress.address ?? ''}, ${currentCustomerAddress.city ?? ''}, ${currentCustomerAddress.state ?? ''}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount:",
                                        style: TextStyle(fontSize: 14)),
                                    Text("₹${e.totalPrice ?? '0.00'}",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                if (e.orderStatus != "Cancelled")
                                  e.deliveryPartnerId == '0'
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Deliveryperson(
                                                  orderId:
                                                      currentCustomerAddress
                                                          .orderId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Click to Assign Delivery Person",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.red),
                                              ),
                                              Image.asset(
                                                  AppAssets.forward_icon,
                                                  height: 25,
                                                  width: 25),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivery Person Details:",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      child: Image.asset(
                                                          AppAssets.UserRounded,
                                                          height: 20),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                        e.deliveryBoyName ?? '',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      AppColors.red,
                                                  child: Image.asset(
                                                      AppAssets.call_icon,
                                                      height: 25,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                              ],
                            ),
                          ),
                        )
                      : null,
                );
              },
            )),

// Order In progress

          if (selectedIndex == 1 && inprogress.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount: inprogress.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final e = inprogress[index];

                final currentCustomerAddress = e.customerAddress;
                // final currentStoreAddress = e.storeAddress;
                String formattedDate = e.createdDate != null
                    ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                    : '';

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: e.orderStatus != "Cancelled"
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Date : ${formattedDate ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: e.orderStatus ==
                                                    "Order Confirmed" ||
                                                e.orderStatus ==
                                                    "On Delivery" ||
                                                e.orderStatus == "Order Placed"
                                            ? Colors.green
                                            : AppColors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        e.orderStatus ?? 'Unknown Status',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pick Point: ",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Container(
                                                  height: 1,
                                                  color: Colors.black,
                                                  width: 80),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Row(children: [
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         _makePhoneCall(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.call_iconfill,
                                      //           height: 35,
                                      //           width: 35)),
                                      //   SizedBox(
                                      //     width: 5,
                                      //   ),
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         whatsapp(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.whatsapp_icon,
                                      //           // color: Colors.green,
                                      //           height: 35,
                                      //           width: 35)),
                                      // ])
                                    ]),
                                SizedBox(height: 10),
                                // Text(
                                //   "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                //   style: TextStyle(fontSize: 14),
                                // ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(Icons.location_on_outlined),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Delivery Point:",
                                              style: TextStyle(fontSize: 16)),
                                          Container(
                                              height: 1,
                                              color: Colors.black,
                                              width: 110),
                                        ],
                                      ),
                                    ]),
                                    Row(children: [
                                      GestureDetector(
                                          onTap: () async {
                                            _makePhoneCall(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.call_iconfill,
                                              height: 35,
                                              width: 35)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            whatsapp(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.whatsapp_icon,
                                              //  color: Colors.green,
                                              height: 35,
                                              width: 35))
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${currentCustomerAddress.address ?? ''}, ${currentCustomerAddress.city ?? ''}, ${currentCustomerAddress.state ?? ''}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount:",
                                        style: TextStyle(fontSize: 14)),
                                    Text("₹${e.totalPrice ?? '0.00'}",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                if (e.orderStatus != "Cancelled")
                                  e.deliveryPartnerId == '0'
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Deliveryperson(
                                                  orderId:
                                                      currentCustomerAddress
                                                          .orderId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Click to Assign Delivery Person",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.red),
                                              ),
                                              Image.asset(
                                                  AppAssets.forward_icon,
                                                  height: 25,
                                                  width: 25),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivery Person Details:",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      child: Image.asset(
                                                          AppAssets.UserRounded,
                                                          height: 20),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                        e.deliveryBoyName ?? '',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      AppColors.red,
                                                  child: Image.asset(
                                                      AppAssets.call_icon,
                                                      height: 25,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                              ],
                            ),
                          ),
                        )
                      : null,
                );
              },
            )),

          // Order Delivered

          if (selectedIndex == 2 && orderdelivered.isNotEmpty)
            Expanded(
                child: ListView.builder(
              itemCount: orderdelivered.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final e = orderdelivered[index];

                final currentCustomerAddress = e.customerAddress;
                // final currentStoreAddress = e.storeAddress;
                String formattedDate = e.createdDate != null
                    ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                    : '';

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: e.orderStatus != "Cancelled"
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Date : ${formattedDate ?? ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: e.orderStatus ==
                                                    "Order Confirmed" ||
                                                e.orderStatus ==
                                                    "On Delivery" ||
                                                e.orderStatus == "Order Placed"
                                            ? Colors.green
                                            : AppColors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        e.orderStatus ?? 'Unknown Status',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pick Point: ",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Container(
                                                  height: 1,
                                                  color: Colors.black,
                                                  width: 80),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Row(children: [
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         _makePhoneCall(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.call_iconfill,
                                      //           height: 35,
                                      //           width: 35)),
                                      //   SizedBox(
                                      //     width: 5,
                                      //   ),
                                      //   GestureDetector(
                                      //       onTap: () async {
                                      //         whatsapp(
                                      //             currentStoreAddress!
                                      //                 .mobile
                                      //                 .toString());
                                      //       },
                                      //       child: Image.asset(
                                      //           AppAssets.whatsapp_icon,
                                      //           // color: Colors.green,
                                      //           height: 35,
                                      //           width: 35)),
                                      // ])
                                    ]),
                                SizedBox(height: 10),
                                // Text(
                                //   "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                //   style: TextStyle(fontSize: 14),
                                // ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Icon(Icons.location_on_outlined),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Delivery Point:",
                                              style: TextStyle(fontSize: 16)),
                                          Container(
                                              height: 1,
                                              color: Colors.black,
                                              width: 110),
                                        ],
                                      ),
                                    ]),
                                    Row(children: [
                                      GestureDetector(
                                          onTap: () async {
                                            _makePhoneCall(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.call_iconfill,
                                              height: 35,
                                              width: 35)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            whatsapp(
                                                e.customerMobile.toString());
                                          },
                                          child: Image.asset(
                                              AppAssets.whatsapp_icon,
                                              //  color: Colors.green,
                                              height: 35,
                                              width: 35))
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${currentCustomerAddress.address ?? ''}, ${currentCustomerAddress.city ?? ''}, ${currentCustomerAddress.state ?? ''}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount:",
                                        style: TextStyle(fontSize: 14)),
                                    Text("₹${e.totalPrice ?? '0.00'}",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Divider(height: 20, color: Color(0xFFE8E8E8)),
                                if (e.orderStatus != "Cancelled")
                                  e.deliveryPartnerId == '0'
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Deliveryperson(
                                                  orderId:
                                                      currentCustomerAddress
                                                          .orderId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Click to Assign Delivery Person",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.red),
                                              ),
                                              Image.asset(
                                                  AppAssets.forward_icon,
                                                  height: 25,
                                                  width: 25),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Delivery Person Details:",
                                                style: TextStyle(fontSize: 14)),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 15,
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      child: Image.asset(
                                                          AppAssets.UserRounded,
                                                          height: 20),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                        e.deliveryBoyName ?? '',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      AppColors.red,
                                                  child: Image.asset(
                                                      AppAssets.call_icon,
                                                      height: 25,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                              ],
                            ),
                          ),
                        )
                      : null,
                );
              },
            )),
        ]),
      ),
    );
  }

  // Method to build the status tabs
  Widget _buildStatusTab(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selectedIndex == index
                  ? AppColors.blue
                  : Colors.grey.shade300),
        ),
        child: Text(
          '$label',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? AppColors.blue : AppColors.black,
          ),
        ),
      ),
    );
  }
}




































// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../constants/app_assets.dart';
// import '../../../constants/app_colors.dart';
// import '../../../services/comFuncService.dart';
// import '../../../services/nam_food_api_service.dart';
// import '../api_model/dashboard_orderlist_model.dart';
// import 'deliveryperson.dart';

// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   final NamFoodApiService apiService = NamFoodApiService();
//   int selectedIndex = 0;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();

//     getunassignDashboardOrderdetailslist();
//   }

//   List<OrderList> unassignorderdetailspage = [];
//   List<OrderList> unassignorderdetailspageAll = [];

//   Future getunassignDashboardOrderdetailslist() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       var result =
//           await apiService.getunasssigneddeliveryboyDashboardOrderlist();
//       var response = orderListmodelFromJson(result);

//       if (response.status == 'SUCCESS') {
//         setState(() {
//           unassignorderdetailspage = response.list;
//           unassignorderdetailspageAll = unassignorderdetailspage;

//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           unassignorderdetailspage = [];
//           unassignorderdetailspageAll = [];

//           isLoading = false;
//         });
//         showInSnackBar(context, response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         unassignorderdetailspage = [];
//         unassignorderdetailspageAll = [];

//         isLoading = false;
//       });
//       showInSnackBar(context, 'Error occurred: $e');
//       print("admin dashboard $e");
//     }
//   }

//   void _makePhoneCall(String phoneNumber) async {
//     final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
//     if (await canLaunchUrl(telUri)) {
//       await launchUrl(telUri);
//     } else {
//       throw 'Could not launch $telUri';
//     }
//   }

//   Future<void> whatsapp(String contact) async {
//     String androidUrl = "whatsapp://send?phone=$contact";
//     String iosUrl = "https://wa.me/$contact";
//     String webUrl = "https://api.whatsapp.com/send/?phone=$contact";
//     print("contact number $contact");
//     try {
//       if (await canLaunchUrl(Uri.parse(androidUrl))) {
//         await launchUrl(Uri.parse(androidUrl));
//       } else if (await canLaunchUrl(Uri.parse(iosUrl))) {
//         await launchUrl(Uri.parse(iosUrl),
//             mode: LaunchMode.externalApplication);
//       } else {
//         await launchUrl(Uri.parse(webUrl),
//             mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       print('Could not launch WhatsApp for $contact: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         // toolbarHeight: 100.0,
//         backgroundColor: Color(0xFFE23744),
//         automaticallyImplyLeading: false,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(15),
//           ),
//         ),
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [Text("Home", style: TextStyle(color: Colors.white))],
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Column(children: [
//             // Order Status Tabs
//             // SizedBox(
//             //   height: 10.0,
//             // ),
//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildStatusTab('New Order', 0),
//                   _buildStatusTab('In Progress', 1),
//                   _buildStatusTab('Delivered', 2),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 8.0),
// //New Order
//             if (selectedIndex == 0 && unassignorderdetailspage.isNotEmpty)
//               ListView.builder(
//                 itemCount: unassignorderdetailspage.length,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final e = unassignorderdetailspage[index];

//                   final currentCustomerAddress = e.customerAddress;
//                   // final currentStoreAddress = e.storeAddress;
//                   String formattedDate = e.createdDate != null
//                       ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
//                       : '';

//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
//                     child: e.orderStatus != "Cancelled"
//                         ? Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "Order ID #${currentCustomerAddress.orderId ?? ''}",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       ),
//                                       Text(
//                                         "Date : ${formattedDate ?? ''}",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: e.orderStatus ==
//                                                       "Order Confirmed" ||
//                                                   e.orderStatus ==
//                                                       "On Delivery" ||
//                                                   e.orderStatus ==
//                                                       "Order Placed"
//                                               ? Colors.green
//                                               : AppColors.red,
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: Text(
//                                           e.orderStatus ?? 'Unknown Status',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Divider(color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10),
//                                   Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on_outlined),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text("Pick Point: ",
//                                                     style: TextStyle(
//                                                         fontSize: 16)),
//                                                 Container(
//                                                     height: 1,
//                                                     color: Colors.black,
//                                                     width: 80),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         // Row(children: [
//                                         //   GestureDetector(
//                                         //       onTap: () async {
//                                         //         _makePhoneCall(
//                                         //             currentStoreAddress!
//                                         //                 .mobile
//                                         //                 .toString());
//                                         //       },
//                                         //       child: Image.asset(
//                                         //           AppAssets.call_iconfill,
//                                         //           height: 35,
//                                         //           width: 35)),
//                                         //   SizedBox(
//                                         //     width: 5,
//                                         //   ),
//                                         //   GestureDetector(
//                                         //       onTap: () async {
//                                         //         whatsapp(
//                                         //             currentStoreAddress!
//                                         //                 .mobile
//                                         //                 .toString());
//                                         //       },
//                                         //       child: Image.asset(
//                                         //           AppAssets.whatsapp_icon,
//                                         //           // color: Colors.green,
//                                         //           height: 35,
//                                         //           width: 35)),
//                                         // ])
//                                       ]),
//                                   SizedBox(height: 10),
//                                   // Text(
//                                   //   "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
//                                   //   style: TextStyle(fontSize: 14),
//                                   // ),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(children: [
//                                         Icon(Icons.location_on_outlined),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text("Delivery Point:",
//                                                 style: TextStyle(fontSize: 16)),
//                                             Container(
//                                                 height: 1,
//                                                 color: Colors.black,
//                                                 width: 110),
//                                           ],
//                                         ),
//                                       ]),
//                                       Row(children: [
//                                         GestureDetector(
//                                             onTap: () async {
//                                               _makePhoneCall(
//                                                   e.customerMobile.toString());
//                                             },
//                                             child: Image.asset(
//                                                 AppAssets.call_iconfill,
//                                                 height: 35,
//                                                 width: 35)),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         GestureDetector(
//                                             onTap: () async {
//                                               whatsapp(
//                                                   e.customerMobile.toString());
//                                             },
//                                             child: Image.asset(
//                                                 AppAssets.whatsapp_icon,
//                                                 //  color: Colors.green,
//                                                 height: 35,
//                                                 width: 35))
//                                       ]),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     "${currentCustomerAddress.address ?? ''}, ${currentCustomerAddress.city ?? ''}, ${currentCustomerAddress.state ?? ''}",
//                                     style: TextStyle(fontSize: 14),
//                                   ),
//                                   Divider(height: 20, color: Color(0xFFE8E8E8)),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text("Total Amount:",
//                                           style: TextStyle(fontSize: 14)),
//                                       Text("₹${e.totalPrice ?? '0.00'}",
//                                           style: TextStyle(fontSize: 14)),
//                                     ],
//                                   ),
//                                   Divider(height: 20, color: Color(0xFFE8E8E8)),
//                                   if (e.orderStatus != "Cancelled")
//                                     e.deliveryPartnerId == '0'
//                                         ? GestureDetector(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       Deliveryperson(
//                                                     orderId:
//                                                         currentCustomerAddress
//                                                             .orderId,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Click to Assign Delivery Person",
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: AppColors.red),
//                                                 ),
//                                                 Image.asset(
//                                                     AppAssets.forward_icon,
//                                                     height: 25,
//                                                     width: 25),
//                                               ],
//                                             ),
//                                           )
//                                         : Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text("Delivery Person Details:",
//                                                   style:
//                                                       TextStyle(fontSize: 14)),
//                                               SizedBox(height: 10),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         radius: 15,
//                                                         backgroundColor:
//                                                             Colors.grey[300],
//                                                         child: Image.asset(
//                                                             AppAssets
//                                                                 .UserRounded,
//                                                             height: 20),
//                                                       ),
//                                                       SizedBox(width: 10),
//                                                       Text(
//                                                           e.deliveryBoyName ??
//                                                               '',
//                                                           style: TextStyle(
//                                                               fontSize: 16)),
//                                                     ],
//                                                   ),
//                                                   CircleAvatar(
//                                                     radius: 15,
//                                                     backgroundColor:
//                                                         AppColors.red,
//                                                     child: Image.asset(
//                                                         AppAssets.call_icon,
//                                                         height: 25,
//                                                         color: Colors.white),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : null,
//                   );
//                 },
//               ),
//           ]),
//         ),
//       ),
//     );
//   }

//   // Method to build the status tabs
//   Widget _buildStatusTab(String label, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: selectedIndex == index
//                   ? AppColors.blue
//                   : Colors.grey.shade300),
//         ),
//         child: Text(
//           '$label',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: selectedIndex == index ? AppColors.blue : AppColors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
