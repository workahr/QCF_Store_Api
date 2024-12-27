import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_assets.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/svgiconButtonWidget.dart';
import '../models/dashboard_order_list_model.dart';
import '../order/orderdetails.dart';
import '../store_menu/mystoredetails_model.dart';
import '../store_menu/storestatusupdate_model.dart';
import 'order_status_model.dart';
import 'store_order_list_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isOnDuty = true;
  int selectedIndex = 0; // Default selected tab (Pending)

  String toggleTitle = "On Duty";

  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    getMyStoreDetails();
    getAllStoreOrders();
  }

  bool isLoading = false;

  List<StoreOrderListData> orderList = [];
  List<StoreOrderListData> orderListAll = [];
  List<StoreOrderListData> pendingList = [];
  List<StoreOrderListData> preparingList = [];
  List<StoreOrderListData> readyList = [];

  // double totalDiscountPrice = 0.0;

  double totalEarning = 0;
  double floatingBalance = 0;

  Future getAllStoreOrders() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getAllStoreOrders();
      var response = storeOrderListModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderList = response.list;
          orderListAll = orderList;
          isLoading = false;
          print(orderListAll);

          pendingList = filterOrdersByStatus("Order Placed");
          print(
              "Filtered Orders by 'Pending': ${filterOrdersByStatus("Order Placed")}");
          preparingList = filterOrdersByStatus("Order Confirmed");
          print(preparingList);
          readyList = filterOrdersByStatus("Ready to Pickup");
          print(readyList);
        });
      } else {
        setState(() {
          orderList = [];
          orderListAll = [];
          isLoading = false;
        });
        //  showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderList = [];
        orderListAll = [];
        isLoading = false;
      });
      // showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  List<StoreOrderListData> filterOrdersByStatus(String status) {
    return orderListAll.where((entry) => entry.orderStatus == status).toList();
  }

  Future orderStatusUpdate(int orderId, String status) async {
    try {
      Map<String, dynamic> postData = {
        "order_id": orderId,
        "order_status": status.toString()
      };
      var result = await apiService.orderStatusUpdate(postData);
      OrderStatusModel response = orderStatusModelFromJson(result);

      closeSnackBar(context: context);

      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          getMyStoreDetails();
          getAllStoreOrders();
        });
      } else {
        //   showInSnackBar(context, response.message.toString());
      }
    } catch (error) {
      //   showInSnackBar(context, error.toString());
    }
  }

// My Store List

  StoreDetails? MyStoreDetails;

  Future getMyStoreDetails() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getMyStoreDetails();
      var response = myStoreDetailsmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          MyStoreDetails = response.list;
          isLoading = false;
        });
      } else {
        setState(() {
          MyStoreDetails = null;
          isLoading = false;
        });
        // showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        MyStoreDetails = null;
        isLoading = false;
      });
      // showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  // Store Status Update

  Future updateStoreStatus(status) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {"store_status": status};
    print("store_status $postData");
    var result = await apiService.updateStoreStatus(postData);

    StoreStatusUpdatemodel response = storeStatusUpdatemodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      //    Navigator.pop(context);
      setState(() {
        getMyStoreDetails(); // Update the state variable
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Third_party_List(),
      //   ),
      // );
    } else {
      print(response.message.toString());
      // showInSnackBar(context, response.message.toString());
    }
  }

  String dateFormat(dynamic date) {
    try {
      DateTime dateTime = date is DateTime ? date : DateTime.parse(date);
      String formattedTime =
          DateFormat('h:mm a').format(dateTime).toLowerCase();
      String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
      return "$formattedTime | $formattedDate";
    } catch (e) {
      return "Invalid date"; // Fallback for invalid date format
    }
  }

  Widget _buildShimmerPlaceholder(int selectedIndex) {
    if (selectedIndex == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: const Color.fromARGB(255, 36, 22, 22),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    } else {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: const Color.fromARGB(255, 36, 22, 22),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Container(
                      width: 100,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
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
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            value:
                                MyStoreDetails!.storeStatus == 1, // isOnDuty,
                            onChanged: (value1) {
                              setState(() {
                                isOnDuty = value1;
                                print(MyStoreDetails!.storeStatus);
                                if (MyStoreDetails!.storeStatus == 1) {
                                  toggleTitle = "Off Duty";
                                } else {
                                  toggleTitle = "On Duty";
                                }
                                updateStoreStatus(value1 ? 1 : 0);
                                print(value1 ? 1 : 0);
                              });
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey.shade300,
                          ))),
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
                  return _buildShimmerPlaceholder(selectedIndex);
                },
              )
            : SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
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
                              'Pending (${pendingList.length.toString()})', 0),
                          _buildStatusTab(
                              'Preparing (${preparingList.length.toString()})',
                              1),
                          _buildStatusTab(
                              'Ready (${readyList.length.toString()})', 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8.0),

                    // Order Notification Card
                    if (selectedIndex == 0 && pendingList.isNotEmpty)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: pendingList.length,
                          itemBuilder: (context, index) {
                            final item = pendingList[index];
                            return Card(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Handle order notification tap
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                        orderId: item.invoiceNumber.toString(),
                                        time: item.createdDate.toString(),
                                        totalPrice: item.totalPrice.toString(),
                                        orderitems: item.items,
                                        paymentMethod:
                                            item.paymentMethod.toString(),
                                        mobilenumber:
                                            item.deliveryBoyMobile.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.celebration,
                                              color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            'You have a order!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                    if (selectedIndex == 1)
                      CustomeTextField(
                        width: MediaQuery.of(context).size.width - 10.0,
                        hint: 'Order ID',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.red,
                        ),
                        labelColor: Colors.grey[900],
                        focusBorderColor: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderColor: AppColors.lightGrey3,
                      ),
                    if (selectedIndex == 1)
                      SizedBox(
                        height: 12.0,
                      ),

                    // Order Card
                    if (selectedIndex == 1 && preparingList.isNotEmpty)
                      Stack(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: preparingList.length,
                            itemBuilder: (context, index) {
                              final item = preparingList[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColors.lightGrey3)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Order ID and Status
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Order ID',
                                                style: TextStyle(
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                item.invoiceNumber.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Order Time and Items Count
                                      Text(
                                        '${dateFormat(item.createdDate.toString())}  | ${item.items.length.toString()} items',
                                        // '12.30 pm | 4 items',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(height: 16),
                                      // Food Item Details
                                      ...item.items.map((dish) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${dish.quantity.toString()} * ${dish.productName.toString()}',
                                              // '2 X Chicken Biryani',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              '₹ ${dish.totalPrice.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      }),
                                      const SizedBox(height: 8),

                                      const SizedBox(height: 16),
                                      // Divider Line
                                      const DottedLine(
                                        direction: Axis.horizontal,
                                        dashColor: AppColors.black,
                                        lineLength: 320,
                                        dashLength: 6,
                                        dashGapLength: 4,
                                      ),
                                      const SizedBox(height: 8),
                                      // Action Buttons
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // makePhoneCall(item.customerMobile
                                              //     .toString());
                                              makePhoneCall("9360159625");
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  //color: AppColors.light,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  border: Border.all(
                                                      color: AppColors.red)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.call_icon,
                                                    width: 23.0,
                                                    height: 23.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    'Call NAM Food',
                                                    style: TextStyle(
                                                        color: AppColors.red),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // ElevatedButton.icon(
                                          //   onPressed: () {},
                                          //   style: ElevatedButton.styleFrom(
                                          //     backgroundColor: Colors.red,
                                          //     foregroundColor: Colors.red,
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.circular(8),
                                          //     ),
                                          //   ),
                                          //   icon: const Icon(Icons.check_circle_outline,
                                          //       color: Colors.white),
                                          //   label: const Text('Food Ready',style: TextStyle(color: AppColors.light),),
                                          // ),

                                          SvgIconButtonWidget(
                                              title: ' Food Ready ',
                                              // color: AppColors.light,
                                              color: Colors.red,
                                              borderColor: Colors.red,
                                              titleColor: AppColors.light,
                                              // titleColor: AppColors.dark,
                                              // borderColor: AppColors.dark,
                                              leadingIcon: Icon(
                                                  Icons.check_circle_outline),
                                              width: 150.0,
                                              fontSize: 13.0,
                                              height: 50.0,
                                              onTap: () {
                                                orderStatusUpdate(
                                                    item.items[0].orderId,
                                                    "Ready to Pickup");
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          top: 18,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFFF3B43F),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ), // Ro
                            ),
                            child: const Text(
                              'Preparing',
                              style: TextStyle(
                                color: AppColors.light,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ]),

                    if (selectedIndex == 2)
                      CustomeTextField(
                        width: MediaQuery.of(context).size.width - 10.0,
                        hint: 'Order ID',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.red,
                        ),
                        labelColor: Colors.grey[900],
                        focusBorderColor: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderColor: AppColors.lightGrey3,
                      ),

                    if (selectedIndex == 2)
                      SizedBox(
                        height: 12.0,
                      ),

                    // Order Card
                    if (selectedIndex == 2 && readyList.isNotEmpty)
                      Stack(children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: readyList.length,
                            itemBuilder: (context, index) {
                              final item = readyList[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 15.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppColors.lightGrey3)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Order ID and Status
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Order ID',
                                                style: TextStyle(
                                                  //fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                item.invoiceNumber.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Order Time and Items Count
                                      Text(
                                        '${dateFormat(item.createdDate.toString())}  | ${item.items.length.toString()} items',
                                        // '12.30 pm | 4 items',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const SizedBox(height: 16),
                                      // Food Item Details
                                      ...item.items.map((dish) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${dish.quantity.toString()} * ${dish.productName.toString()}',
                                              // '2 X Chicken Biryani',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              '₹ ${dish.totalPrice.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      }),
                                      // const SizedBox(height: 8),
                                      // const Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       '3 X Chicken Biryani',
                                      //       style: TextStyle(fontSize: 16),
                                      //     ),
                                      //     Text(
                                      //       '₹500.00',
                                      //       style: TextStyle(fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ],
                                      // ),

                                      const SizedBox(height: 16.0),
                                      // Divider Line
                                      const DottedLine(
                                        direction: Axis.horizontal,
                                        dashColor: AppColors.black,
                                        lineLength: 320,
                                        dashLength: 6,
                                        dashGapLength: 4,
                                      ),
                                      const SizedBox(height: 10.0),

                                      if (item.deliveryBoyName.toString() !=
                                          "null")
                                        HeadingWidget(
                                          title: 'Delivery Person Details',
                                          fontSize: 16.0,
                                          color: AppColors.black,
                                        ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      if (item.deliveryBoyName.toString() !=
                                          "null")
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                // Profile Icon in a round container
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 2),
                                                  ),
                                                  child: Image.asset(
                                                    AppAssets.UserRounded,
                                                    width: 23.0,
                                                    height: 23.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                // Name Text
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Text(
                                                        'Name           : ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      if (item.deliveryBoyName
                                                              .toString() !=
                                                          "null")
                                                        Text(
                                                          item.deliveryBoyName
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decorationColor:
                                                                Colors.blue,
                                                          ),
                                                        ),
                                                    ]),
                                                    Row(children: [
                                                      Text(
                                                        'Pickup Code: ',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.black,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      if (item.deliveryBoyName
                                                              .toString() !=
                                                          "null")
                                                        Text(
                                                          item.code.toString(),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decorationColor:
                                                                Colors.blue,
                                                          ),
                                                        ),
                                                    ])
                                                  ],
                                                ),
                                              ],
                                            ),
                                            // Call Icon in a round container
                                            GestureDetector(
                                                onTap: () {
                                                  makePhoneCall(item
                                                      .deliveryBoyMobile
                                                      .toString());
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red,
                                                  ),
                                                  child: Image.asset(
                                                    AppAssets.call_icon,
                                                    width: 23.0,
                                                    height: 23.0,
                                                    color: AppColors.light,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      const SizedBox(height: 10.0),
                                      if (item.deliveryBoyName.toString() !=
                                          "null")
                                        const DottedLine(
                                          direction: Axis.horizontal,
                                          dashColor: AppColors.black,
                                          lineLength: 320,
                                          dashLength: 6,
                                          dashGapLength: 4,
                                        ),
                                      const SizedBox(height: 10.0),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //  if (item.deliveryBoyMobile != null)
                                          InkWell(
                                            onTap: () {
                                              makePhoneCall("9360159625");
                                            },
                                            child: Container(
                                              // height: 40,
                                              // width: 120,
                                              padding: EdgeInsets.all(7.0),
                                              decoration: BoxDecoration(
                                                  //color: AppColors.light,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  border: Border.all(
                                                      color: AppColors.red)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    AppAssets.call_icon,
                                                    width: 23.0,
                                                    height: 23.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    'Call Nam Food',
                                                    style: TextStyle(
                                                        color: AppColors.red),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SvgIconButtonWidget(
                                              title: ' Done ',
                                              // color: AppColors.light,
                                              color: Colors.red,
                                              borderColor: Colors.red,
                                              titleColor: AppColors.light,
                                              // titleColor: AppColors.dark,
                                              // borderColor: AppColors.dark,
                                              leadingIcon: Icon(
                                                  Icons.check_circle_outline),
                                              width: 150.0,
                                              fontSize: 13.0,
                                              height: 50.0,
                                              onTap: () {
                                                orderStatusUpdate(
                                                    item.items[0].orderId,
                                                    "Order Picked");
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          top: 18,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ), // Ro
                            ),
                            child: const Text(
                              'Food Ready',
                              style: TextStyle(
                                color: AppColors.light,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ]),
                  ],
                ),
              )));
  }

  // Method to build the status tabs
  Widget _buildStatusTab(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          getAllStoreOrders();
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
