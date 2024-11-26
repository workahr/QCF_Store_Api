import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../models/admindashboard_model.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final NamFoodApiService apiService = NamFoodApiService();
  @override
  void initState() {
    super.initState();
    getdashboardorderdetailslist();
  }

  //Store Menu Details

  List<OrderDetailsList> orderdetailslistpage = [];
  List<OrderDetailsList> orderdetailslistpageAll = [];
  bool isLoading = false;

  Future getdashboardorderdetailslist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getdashboardorderdetailslist();
      var response = adminorderdetailslistmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderdetailslistpage = response.list;
          orderdetailslistpageAll = orderdetailslistpage;
          isLoading = false;
        });
      } else {
        setState(() {
          orderdetailslistpage = [];
          orderdetailslistpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderdetailslistpage = [];
        orderdetailslistpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
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
                    "₹11,25,000.00",
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
                                    "250",
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
                                  "₹12,250.00",
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
                shrinkWrap:
                    true, // Let the list take only as much space as needed
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                itemBuilder: (context, index) {
                  final e = orderdetailslistpage[index];
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID #${e.orderid}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: e.orderstatus == "Order Confirm" ||
                                            e.orderstatus == "On Delivery"
                                        ? Colors.green
                                        : Color(0xFFF9B361),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      e.orderstatus, //    "Order Confirm",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
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
                                    Text(
                                      "Pick Point: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.black,
                                      width: 80,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              e.pickupaddress, //  "Grill Chicken Arabian Restaurant",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Row(children: [
                              Icon(Icons.location_on_outlined),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Point:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black,
                                    width: 110,
                                  ),
                                ],
                              ),
                            ]),
                            SizedBox(height: 10),
                            Text(
                              e.deliveryaddress, // "No,37 Paranjothi Nagar Thalakudi, Valar Nagar Bengaluru-620005",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              color: Color(0xFFE8E8E8),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount: ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "₹${e.totalamount}", //  "₹580.00",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              color: Color(0xFFE8E8E8),
                            ),
                            SizedBox(height: 10),
                            e.orderstatus == "Order Confirm"
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Click to Assign Delivery Person",
                                        style: TextStyle(
                                            fontSize: 16, color: AppColors.red),
                                      ),
                                      Image.asset(
                                        AppAssets.forward_icon,
                                        height: 25,
                                        width: 25,
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                          "Delivery Person Details :",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              221,
                                                              220,
                                                              220)),
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  AppAssets.UserRounded,
                                                  height: 20,
                                                  width: 20,
                                                )),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                e.deliverypersonName, // "Vaiyapuri",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ]),
                                            Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  color: AppColors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                    child: Image.asset(
                                                  AppAssets.call_icon,
                                                  height: 25,
                                                  width: 25,
                                                  color: Colors.white,
                                                ))),
                                          ],
                                        ),
                                      ])
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
