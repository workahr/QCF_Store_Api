import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/dashboard_orderlist_model.dart';
import '../models/admindashboard_model.dart';
import 'delivery_person_list.dart';
import 'deliveryperson.dart';
import 'totalorder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    getallDashboardOrderdetailslist();
    getunassignDashboardOrderdetailslist();
  }

  List<OrderList> unassignorderdetailspage = [];
  List<OrderList> unassignorderdetailspageAll = [];

  Future getunassignDashboardOrderdetailslist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result =
          await apiService.getunasssigneddeliveryboyDashboardOrderlist();
      var response = orderListmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        setState(() {
          unassignorderdetailspage = response.list;
          unassignorderdetailspageAll = unassignorderdetailspage;

          isLoading = false;
        });
      } else {
        setState(() {
          unassignorderdetailspage = [];
          unassignorderdetailspageAll = [];

          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        unassignorderdetailspage = [];
        unassignorderdetailspageAll = [];

        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
      print("admin dashboard $e");
    }
  }

  //Store Menu Details

  List<OrderList> orderdetailslistpage = [];
  List<OrderList> orderdetailslistpageAll = [];

  bool isLoading = false;

  int? totalOrdersCount;
  double? totalOrderPrice;

  Future getallDashboardOrderdetailslist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getallDashboardOrderdetailslist();
      var response = orderListmodelFromJson(result);

      if (response.status == 'SUCCESS') {
        print("hi");
        setState(() {
          orderdetailslistpage = response.list;
          orderdetailslistpageAll = orderdetailslistpage;

          totalOrdersCount = orderdetailslistpage.length;
          print("Total Orders: $totalOrdersCount");

          int totalProducts = orderdetailslistpage.fold(
              0, (sum, order) => sum + (order.totalProduct ?? 0));
          print("Total Products: $totalProducts");

          totalOrderPrice = orderdetailslistpage.fold(0.0, (sum, order) {
            return sum! + double.tryParse(order.totalPrice ?? '0')!;
          });
          print("Total Order Price: $totalOrderPrice");

          calculateTodayOrders();

          isLoading = false;
        });
      } else {
        setState(() {
          orderdetailslistpage = [];
          orderdetailslistpageAll = [];

          isLoading = false;
        });
        //  showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderdetailslistpage = [];
        orderdetailslistpageAll = [];

        isLoading = false;
      });
      //  showInSnackBar(context, 'Error occurred: $e');
    }
  }

  int? totalTodayOrdersCount;
  double? totalTodayOrderPrice;
  void calculateTodayOrders() {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);

    List<OrderList> todayOrders = orderdetailslistpage.where((order) {
      return order.createdDate != null &&
          order.createdDate!.isAfter(startOfToday);
    }).toList();

    totalTodayOrdersCount = todayOrders.length;
    int totalTodayProducts =
        todayOrders.fold(0, (sum, order) => sum + (order.totalProduct ?? 0));
    totalTodayOrderPrice = todayOrders.fold(0.0, (sum, order) {
      return sum! + double.tryParse(order.totalPrice ?? '0')!;
    });

    print("Today's Orders Count: $totalTodayOrdersCount");
    print("Today's Total Products: $totalTodayProducts");
    print("Today's Total Order Price: $totalTodayOrderPrice");

    setState(() {});
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
              height: 5,
            ),
            Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: 270,
                height: 83,
                color: Colors.white,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13), // Add border radius
                  child: Container(
                    width: 170,
                    height: 133,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13), // Add border radius
                  child: Container(
                    width: 170,
                    height: 133,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13), // Add border radius
                  child: Container(
                    width: 170,
                    height: 133,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13), // Add border radius
                  child: Container(
                    width: 170,
                    height: 133,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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
          children: [Text("Dashboard", style: TextStyle(color: Colors.white))],
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Earnings Section
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Total Earnings",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "₹${totalOrderPrice}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio:
                          1.5, // Control the height-to-width ratio
                      children: [
                        IntrinsicHeight(
                          child: SizedBox(
                            height: 120, // Height explicitly set here
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                                color: Color(0xFFFBFBFB),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today Orders",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          AppAssets.textedit_icon,
                                          height: 25,
                                          width: 25,
                                        ),
                                        Text(
                                          "$totalTodayOrdersCount", // "250",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Totalorder(),
                                ),
                              );
                            },
                            child: IntrinsicHeight(
                                child: SizedBox(
                              height: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: Color(0xFFFBFBFB),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Orders",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            AppAssets.textedit_icon,
                                            height: 25,
                                            width: 25,
                                          ),
                                          Text(
                                            "$totalOrdersCount",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
                        IntrinsicHeight(
                            child: SizedBox(
                          height: 120,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                              color: Color(0xFFFBFBFB),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today Earning",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        AppAssets.rupee_symbol,
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "₹$totalTodayOrderPrice",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                        IntrinsicHeight(
                            child: SizedBox(
                          height: 120,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                              color: Color(0xFFFBFBFB),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Delivery Per..",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        AppAssets.scooter_icon,
                                        height: 25,
                                        width: 25,
                                      ),
                                      Text(
                                        "1,500",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 1.0),
                    child: Text(
                      "Current Orders",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: unassignorderdetailspage.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final e = unassignorderdetailspage[index];

                      final currentCustomerAddress = e.customerAddress;
                      // final currentStoreAddress = e.storeAddress;
                      String formattedDate = e.createdDate != null
                          ? DateFormat('dd-MM-yyyy').format(e.createdDate!)
                          : '';

                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
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
                  ),
                ],
              ),
            ),
    );
  }
}
