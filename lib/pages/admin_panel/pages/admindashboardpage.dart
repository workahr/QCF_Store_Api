import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/dashboard_orderlist_model.dart';
import '../models/admindashboard_model.dart';
import 'delivery_person_list.dart';
import 'deliveryperson.dart';

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
  }

  //Store Menu Details

  List<OrderList> orderdetailslistpage = [];
  List<OrderList> orderdetailslistpageAll = [];
  CustomerAddress? customeraddress;
  StoreAddress? storeaddress;
  bool isLoading = false;

  int? totalOrdersCount;
  double? totalOrderPrice;

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

          totalOrdersCount = orderdetailslistpage.length;
          print("Total Orders: $totalOrdersCount");

          int totalProducts = orderdetailslistpage.fold(
              0, (sum, order) => sum + (order.totalProduct ?? 0));
          print("Total Products: $totalProducts");

          totalOrderPrice = orderdetailslistpage.fold(0.0, (sum, order) {
            return sum! + double.tryParse(order.totalPrice ?? '0')!;
          });
          print("Total Order Price: $totalOrderPrice");

          if (orderdetailslistpage.isNotEmpty) {
            customeraddress = orderdetailslistpage.first.customerAddress;
          } else {
            customeraddress = null;
          }

          calculateTodayOrders();

          isLoading = false;
        });
      } else {
        setState(() {
          orderdetailslistpage = [];
          orderdetailslistpageAll = [];
          customeraddress = null;
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderdetailslistpage = [];
        orderdetailslistpageAll = [];
        customeraddress = null;
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }
  }

  int? totalTodayOrdersCount;
  late double totalTodayOrderPrice;
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
      return sum + double.tryParse(order.totalPrice ?? '0')!;
    });

    print("Today's Orders Count: $totalTodayOrdersCount");
    print("Today's Total Products: $totalTodayProducts");
    print("Today's Total Order Price: $totalTodayOrderPrice");

    setState(() {
      // Update your state variables if needed
    });
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
      body: SingleChildScrollView(
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
                childAspectRatio: 1.5, // Control the height-to-width ratio
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
                              "Total Orders",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "Today Earning",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AppAssets.rupee_symbol,
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  " $totalTodayOrderPrice",
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              itemCount: orderdetailslistpage.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final e = orderdetailslistpage[index];

                // Access the specific customer and store addresses for each order
                final currentCustomerAddress = e.customerAddress;
                final currentStoreAddress = e.storeAddress;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                  child: Container(
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
                          Text(
                            "Order ID #${currentCustomerAddress.orderId ?? ''}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: e.orderStatus == "Order Confirmed" ||
                                          e.orderStatus == "On Delivery"
                                      ? Colors.green
                                      : Color(0xFFF9B361),
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
                            children: [
                              Icon(Icons.location_on_outlined),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pick Point: ",
                                      style: TextStyle(fontSize: 16)),
                                  Container(
                                      height: 1,
                                      color: Colors.black,
                                      width: 80),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${currentStoreAddress.name ?? 'Unknown'}, ${currentStoreAddress.address ?? 'N/A'}, ${currentStoreAddress.city ?? 'N/A'}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delivery Point:",
                                      style: TextStyle(fontSize: 16)),
                                  Container(
                                      height: 1,
                                      color: Colors.black,
                                      width: 110),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${currentCustomerAddress.address ?? 'N/A'}, ${currentCustomerAddress.city ?? 'N/A'}, ${currentCustomerAddress.state ?? 'N/A'}",
                            style: TextStyle(fontSize: 14),
                          ),
                          Divider(height: 20, color: Color(0xFFE8E8E8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Amount:",
                                  style: TextStyle(fontSize: 14)),
                              Text("₹${e.totalPrice ?? '0.00'}",
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Divider(height: 20, color: Color(0xFFE8E8E8)),
                          e.orderStatus == "Order Confirmed"
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Deliveryperson(
                                          orderId:
                                              currentCustomerAddress.orderId,
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
                                            fontSize: 16, color: AppColors.red),
                                      ),
                                      Image.asset(AppAssets.forward_icon,
                                          height: 25, width: 25),
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delivery Person Details:",
                                        style: TextStyle(fontSize: 14)),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              backgroundColor: Colors.grey[300],
                                              child: Image.asset(
                                                  AppAssets.UserRounded,
                                                  height: 20),
                                            ),
                                            SizedBox(width: 10),
                                            Text(e.deliveryBoyName ?? '',
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: AppColors.red,
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
