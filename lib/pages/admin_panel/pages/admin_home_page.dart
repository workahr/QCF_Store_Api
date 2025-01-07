import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/custom_text_field.dart';
import '../api_model/dashboard_orderlist_model.dart';
import 'cancel_order_page.dart';
import 'deliveryperson.dart';
import 'edit_order.dart';

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
  List<OrderList> canceledorder = [];
  bool isLoading = false;

  Future<void> getallDashboardOrderdetailslist() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getallDashboardOrderdetailslist();
      var response = orderListmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        setState(() {
          final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

          orderdetailslistpageAll = response.list;
          unassigneddeliveryboy = orderdetailslistpageAll.where((entry) {
            return (entry.orderStatus == "Order Placed" ||
                    entry.orderStatus == "Ready to Pickup" ||
                    entry.orderStatus == "Order Confirmed" ||
                    entry.orderStatus == "Order Picked") &&
                entry.deliveryPartnerId == '0' &&
                DateFormat('yyyy-MM-dd').format(entry.createdDate!) == today;
          }).toList();

          inprogress = orderdetailslistpageAll.where((entry) {
            return entry.orderStatus != "Order Delivered" &&
                entry.deliveryPartnerId != '0' &&
                DateFormat('yyyy-MM-dd').format(entry.createdDate!) == today;
          }).toList();

          orderdelivered = orderdetailslistpageAll.where((entry) {
            return entry.orderStatus == "Order Delivered" &&
                entry.deliveryPartnerId != '0' &&
                DateFormat('yyyy-MM-dd').format(entry.createdDate!) == today;
          }).toList();

          canceledorder = orderdetailslistpageAll.where((entry) {
            return entry.orderStatus == "Cancelled" &&
                (entry.deliveryPartnerId != '0' ||
                    entry.deliveryPartnerId == '0') &&
                DateFormat('yyyy-MM-dd').format(entry.createdDate!) == today;
          }).toList();

          orderdetailslistpage = response.list;
          isLoading = false;
          print("tap 1 : $unassigneddeliveryboy");
          print("tap 2 : $inprogress");
          print("tap 3 : $orderdelivered");
          print("tap 3 : $canceledorder");
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

      print("Error: $e");
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

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
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

  void _showpickupconfirmDialog(List<Item> items) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // widget.orderitems.map((e) {
              // return
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order ${items.length.toString()} items',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.red,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.green,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            "#${items[0].orderId.toString()}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    ...items.map((e) {
                      return _buildItemDetailCard(
                        e.quantity.toString(),
                        e.productName.toString(),
                      );
                    }).toList(), //
                  ],
                ),
              )
            ]
                    // }).toList(),
                    ),
          ),
        );
      },
    );
  }

  Widget _buildItemDetailCard(String qty, String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        "$qty x $name",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
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
      body: isLoading
          ? ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                // Order Status Tabs
                // SizedBox(
                //   height: 10.0,
                // ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 8.0),
                    child: SingleChildScrollView(
                        scrollDirection:
                            Axis.horizontal, // Enable horizontal scrolling
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStatusTab(
                                  'New Order (${unassigneddeliveryboy.length.toString()})',
                                  0),
                              _buildStatusTab(
                                  'Onward (${inprogress.length.toString()})',
                                  1),
                              _buildStatusTab(
                                  'Sent (${orderdelivered.length.toString()})',
                                  2),
                              _buildStatusTab(
                                  'Canceled ${canceledorder.length.toString()})',
                                  3),

                              // _buildStatusTab('New Order', 0),
                              // _buildStatusTab('Progress', 1),
                              // _buildStatusTab('Delivered', 2),
                              // _buildStatusTab('Canceled', 3),
                            ],
                          ),
                        ))),

//New Order

                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: CustomeTextField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.red,
                      ),
                      hint: 'Search Orders',
                      hintColor: AppColors.grey,
                      borderColor: AppColors.grey,
                      onChanged: (value) {
                        final today =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        value = value.trim().toLowerCase();
                        setState(() {
                          if (selectedIndex == 0) {
                            unassigneddeliveryboy = value.isNotEmpty
                                ? orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus == "Order Placed" &&
                                        order.deliveryPartnerId == '0' &&
                                        (order.customerAddress.orderId
                                                ?.toString()
                                                .toLowerCase()
                                                .contains(value) ??
                                            false))
                                    .toList()
                                : orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus == "Order Placed" &&
                                        order.deliveryPartnerId == '0' &&
                                        DateFormat('yyyy-MM-dd')
                                                .format(order.createdDate!) ==
                                            today)
                                    .toList();
                          } else if (selectedIndex == 1) {
                            inprogress = value.isNotEmpty
                                ? orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus !=
                                            "Order Delivered" &&
                                        order.deliveryPartnerId != '0' &&
                                        DateFormat('yyyy-MM-dd')
                                                .format(order.createdDate!) ==
                                            today &&
                                        (order.customerAddress.orderId
                                                ?.toString()
                                                .toLowerCase()
                                                .contains(value) ??
                                            false))
                                    .toList()
                                : orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus !=
                                            "Order Delivered" &&
                                        order.deliveryPartnerId != '0' &&
                                        DateFormat('yyyy-MM-dd')
                                                .format(order.createdDate!) ==
                                            today)
                                    .toList();
                          } else if (selectedIndex == 2) {
                            orderdelivered = value.isNotEmpty
                                ? orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus ==
                                            "Order Delivered" &&
                                        order.deliveryPartnerId != '0' &&
                                        (order.customerAddress.orderId
                                                ?.toString()
                                                .toLowerCase()
                                                .contains(value) ??
                                            false))
                                    .toList()
                                : orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus ==
                                            "Order Delivered" &&
                                        order.deliveryPartnerId != '0' &&
                                        DateFormat('yyyy-MM-dd')
                                                .format(order.createdDate!) ==
                                            today)
                                    .toList();
                          } else if (selectedIndex == 3) {
                            canceledorder = value.isNotEmpty
                                ? orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus == "Cancelled" &&
                                        (order.deliveryPartnerId != '0' ||
                                            order.deliveryPartnerId == '0') &&
                                        (order.customerAddress.orderId
                                                ?.toString()
                                                .toLowerCase()
                                                .contains(value) ??
                                            false))
                                    .toList()
                                : orderdetailslistpageAll
                                    .where((order) =>
                                        order.orderStatus == "Cancelled" &&
                                        (order.deliveryPartnerId != '0' ||
                                            order.deliveryPartnerId == '0' &&
                                                DateFormat('yyyy-MM-dd').format(
                                                        order.createdDate!) ==
                                                    today))
                                    .toList();
                          }
                        });
                      },

                      //  },
                    )),

                if (selectedIndex == 0 && unassigneddeliveryboy.isNotEmpty)
                  Expanded(
                      child: ListView.builder(
                    itemCount: unassigneddeliveryboy.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final e = unassigneddeliveryboy[index];

                      final currentCustomerAddress = e.customerAddress;
                      final currentStoreAddress = e.storeAddress;
                      String formattedDate = e.createdDate != null
                          ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                          : '';
                      String formattedTime = e.createdDate != null
                          ? DateFormat('hh:mm a').format(
                              e.createdDate!) // Formats time in 12-hour format
                          : '';
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: e.orderStatus != "Cancelled"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${formattedDate ?? ''}|${formattedTime ?? ''}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ]),

                                                // Text(
                                                //   "Time :    ${formattedTime ?? ''}",
                                                //   style: TextStyle(
                                                //       fontWeight: FontWeight.bold,
                                                //       fontSize: 16),
                                                // ),

                                                GestureDetector(
                                                  onTap: () async {
                                                    _showpickupconfirmDialog(
                                                        e.items);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'View Menu',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                AppColors.red),
                                                      ),
                                                      // Image.asset(
                                                      //   AppAssets.forward_icon,
                                                      //   height: 25,
                                                      //   width: 25,
                                                      //   color: Colors.white,
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: e.orderStatus ==
                                                          "Order Confirmed" ||
                                                      e.orderStatus ==
                                                          "On Delivery" ||
                                                      e.orderStatus ==
                                                          "Order Placed"
                                                  ? Colors.green
                                                  : AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e.orderStatus ?? 'Unknown Status',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                Icon(
                                                    Icons.location_on_outlined),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pick Point: ",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Container(
                                                        height: 1,
                                                        color: Colors.black,
                                                        width: 80),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    _makePhoneCall(
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
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
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
                                                  },
                                                  child: Image.asset(
                                                      AppAssets.whatsapp_icon,
                                                      // color: Colors.green,
                                                      height: 35,
                                                      width: 35)),
                                            ])
                                          ]),
                                      SizedBox(height: 10),
                                      Text(
                                        "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                        style: TextStyle(fontSize: 14),
                                      ),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
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
                                                  _makePhoneCall(e
                                                      .customerMobile
                                                      .toString());
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
                                                  whatsapp(e.customerMobile
                                                      .toString());
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Editorder(
                                                      invoiceNumber:
                                                          e.invoiceNumber,
                                                      items: e.items,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                    border: Border.all(
                                                        color: AppColors.red)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Edit Order',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                    Image.asset(
                                                      AppAssets.forward_icon,
                                                      height: 20,
                                                      width: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CancelBookingPage(
                                                              cancelId:
                                                                  currentCustomerAddress
                                                                      .orderId,
                                                            ))).then(
                                                    (value) {});
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0)),
                                                    border: Border.all(
                                                        color: AppColors.red)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Cancel Order',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white),
                                                    ),
                                                    Image.asset(
                                                      AppAssets.forward_icon,
                                                      height: 25,
                                                      width: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  Text(
                                                      "Delivery Person Details:",
                                                      style: TextStyle(
                                                          fontSize: 14)),
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
                                                                Colors
                                                                    .grey[300],
                                                            child: Image.asset(
                                                                AppAssets
                                                                    .UserRounded,
                                                                height: 20),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              e.deliveryBoyName ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            AppColors.red,
                                                        child: Image.asset(
                                                            AppAssets.call_icon,
                                                            height: 25,
                                                            color:
                                                                Colors.white),
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
                      final currentStoreAddress = e.storeAddress;
                      String formattedDate = e.createdDate != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(e.createdDate!) // Formats date
                          : '';

                      String formattedTime = e.createdDate != null
                          ? DateFormat('hh:mm a').format(
                              e.createdDate!) // Formats time in 12-hour format
                          : '';

                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: e.orderStatus != "Cancelled"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${formattedDate ?? ''}|${formattedTime ?? ''}",
                                                        style: TextStyle(
                                                            // color: Colors.grey,
                                                            // fontWeight:
                                                            //     FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ])
                                              ],
                                            ),
                                            // Text(
                                            //   "Time :    ${formattedTime ?? ''}",
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: 16),
                                            // ),
                                          ]),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: e.orderStatus ==
                                                          "Order Confirmed" ||
                                                      e.orderStatus ==
                                                          "On Delivery" ||
                                                      e.orderStatus ==
                                                          "Order Placed"
                                                  ? Colors.green
                                                  : AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e.orderStatus ?? 'Unknown Status',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                Icon(
                                                    Icons.location_on_outlined),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pick Point: ",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Container(
                                                        height: 1,
                                                        color: Colors.black,
                                                        width: 80),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    _makePhoneCall(
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
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
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
                                                  },
                                                  child: Image.asset(
                                                      AppAssets.whatsapp_icon,
                                                      // color: Colors.green,
                                                      height: 35,
                                                      width: 35)),
                                            ])
                                          ]),
                                      SizedBox(height: 10),
                                      Text(
                                        "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                        style: TextStyle(fontSize: 14),
                                      ),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
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
                                                  _makePhoneCall(e
                                                      .customerMobile
                                                      .toString());
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
                                                  whatsapp(e.customerMobile
                                                      .toString());
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  Text(
                                                      "Delivery Person Details:",
                                                      style: TextStyle(
                                                          fontSize: 14)),
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
                                                                Colors
                                                                    .grey[300],
                                                            child: Image.asset(
                                                                AppAssets
                                                                    .UserRounded,
                                                                height: 20),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              e.deliveryBoyName ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            AppColors.red,
                                                        child: Image.asset(
                                                            AppAssets.call_icon,
                                                            height: 25,
                                                            color:
                                                                Colors.white),
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
                      final currentStoreAddress = e.storeAddress;
                      String formattedDate = e.createdDate != null
                          ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                          : '';
                      String formattedTime = e.createdDate != null
                          ? DateFormat('hh:mm a').format(
                              e.createdDate!) // Formats time in 12-hour format
                          : '';
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: e.orderStatus != "Cancelled"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${formattedDate ?? ''}|${formattedTime ?? ''}",
                                                      style: TextStyle(
                                                          // color: Colors.grey,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ])
                                            ],
                                          ),
                                          // Text(
                                          //   "Time :    ${formattedTime ?? ''}",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 16),
                                          // ),
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
                                                      e.orderStatus ==
                                                          "Order Placed"
                                                  ? Colors.green
                                                  : AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e.orderStatus ?? 'Unknown Status',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                Icon(
                                                    Icons.location_on_outlined),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pick Point: ",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Container(
                                                        height: 1,
                                                        color: Colors.black,
                                                        width: 80),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    _makePhoneCall(
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
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
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
                                                  },
                                                  child: Image.asset(
                                                      AppAssets.whatsapp_icon,
                                                      // color: Colors.green,
                                                      height: 35,
                                                      width: 35)),
                                            ])
                                          ]),
                                      SizedBox(height: 10),
                                      Text(
                                        "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                        style: TextStyle(fontSize: 14),
                                      ),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
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
                                                  _makePhoneCall(e
                                                      .customerMobile
                                                      .toString());
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
                                                  whatsapp(e.customerMobile
                                                      .toString());
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  Text(
                                                      "Delivery Person Details:",
                                                      style: TextStyle(
                                                          fontSize: 14)),
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
                                                                Colors
                                                                    .grey[300],
                                                            child: Image.asset(
                                                                AppAssets
                                                                    .UserRounded,
                                                                height: 20),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              e.deliveryBoyName ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            AppColors.red,
                                                        child: Image.asset(
                                                            AppAssets.call_icon,
                                                            height: 25,
                                                            color:
                                                                Colors.white),
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

                if (selectedIndex == 3 && canceledorder.isNotEmpty)
                  Expanded(
                      child: ListView.builder(
                    itemCount: canceledorder.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final e = canceledorder[index];

                      final currentCustomerAddress = e.customerAddress;
                      final currentStoreAddress = e.storeAddress;
                      String formattedDate = e.createdDate != null
                          ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                          : '';
                      String formattedTime = e.createdDate != null
                          ? DateFormat('hh:mm a').format(
                              e.createdDate!) // Formats time in 12-hour format
                          : '';
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: e.orderStatus == "Cancelled"
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Order ID #${currentCustomerAddress.orderId ?? ''}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "${formattedDate ?? ''}|${formattedTime ?? ''}",
                                                      style: TextStyle(
                                                          // color: Colors.grey,
                                                          // fontWeight:
                                                          //     FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                  ])
                                            ],
                                          ),
                                          // Text(
                                          //   "Time :    ${formattedTime ?? ''}",
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 16),
                                          // ),
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
                                                      e.orderStatus ==
                                                          "Order Placed"
                                                  ? Colors.green
                                                  : AppColors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e.orderStatus ?? 'Unknown Status',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                Icon(
                                                    Icons.location_on_outlined),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pick Point: ",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Container(
                                                        height: 1,
                                                        color: Colors.black,
                                                        width: 80),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    _makePhoneCall(
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
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
                                                        currentStoreAddress!
                                                            .mobile
                                                            .toString());
                                                  },
                                                  child: Image.asset(
                                                      AppAssets.whatsapp_icon,
                                                      // color: Colors.green,
                                                      height: 35,
                                                      width: 35)),
                                            ])
                                          ]),
                                      SizedBox(height: 10),
                                      Text(
                                        "${currentStoreAddress!.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                                        style: TextStyle(fontSize: 14),
                                      ),
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
                                                    style: TextStyle(
                                                        fontSize: 16)),
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
                                                  _makePhoneCall(e
                                                      .customerMobile
                                                      .toString());
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
                                                  whatsapp(e.customerMobile
                                                      .toString());
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                      Divider(
                                          height: 20, color: Color(0xFFE8E8E8)),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                  Text(
                                                      "Delivery Person Details:",
                                                      style: TextStyle(
                                                          fontSize: 14)),
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
                                                                Colors
                                                                    .grey[300],
                                                            child: Image.asset(
                                                                AppAssets
                                                                    .UserRounded,
                                                                height: 20),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              e.deliveryBoyName ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                        ],
                                                      ),
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            AppColors.red,
                                                        child: Image.asset(
                                                            AppAssets.call_icon,
                                                            height: 25,
                                                            color:
                                                                Colors.white),
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
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                color:
                    selectedIndex == index ? AppColors.blue : AppColors.black,
              ),
            ),
          ),
        ));
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
