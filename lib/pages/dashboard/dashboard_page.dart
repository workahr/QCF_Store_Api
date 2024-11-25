import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/heading_widget.dart';

import '../../constants/app_assets.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/svgiconButtonWidget.dart';
import '../models/dashboard_order_list_model.dart';

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

    getDashboardOrderlist();
  }

  List<DashboardOrderList> orderList = [];
  List<DashboardOrderList> orderListAll = [];
  List<DashboardOrderList> pendingList = [];
  List<DashboardOrderList> preparingList = [];
  List<DashboardOrderList> readyList = [];

  bool isLoading = false;
  double totalDiscountPrice = 0.0;

  Future getDashboardOrderlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getDashboardOrderlist();
      var response = dashboardOrderListModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderList = response.list;
          orderListAll = orderList;
          orderListAll.forEach((order) {
            print("Order ID: ${order.orderId}, Status: ${order.orderStatus}");
          });
          isLoading = false;
          print(orderListAll);

          pendingList = filterOrdersByStatus("Pending");
          print(
              "Filtered Orders by 'Pending': ${filterOrdersByStatus("Pending")}");
          preparingList = filterOrdersByStatus("Preparing");
          print(preparingList);
          readyList = filterOrdersByStatus("Ready");
          print(readyList);
        });
      } else {
        setState(() {
          orderList = [];
          orderListAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderList = [];
        orderListAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  List<DashboardOrderList> filterOrdersByStatus(String status) {
    return orderListAll.where((entry) => entry.orderStatus == status).toList();
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
                    child:
                  Switch(
                    value: isOnDuty,
                    onChanged: (value) {
                      setState(() {
                        isOnDuty = value;
                        if (isOnDuty == true) {
                          toggleTitle = "On Duty";
                        } else {
                          toggleTitle = "Off Duty";
                        }
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
        body: SingleChildScrollView(
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
                    _buildStatusTab('Pending', 0),
                    _buildStatusTab('Preparing', 1),
                    _buildStatusTab('Ready', 2),
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
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              border: Border.all(color: AppColors.lightGrey3)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          item.orderId.toString(),
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
                                  '${item.time.toString()} pm | ${item.items.toString()} items',
                                  // '12.30 pm | 4 items',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 16),
                                // Food Item Details
                                ...item.dishes.map((dish) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${dish.quantity.toString()} * ${dish.name.toString()}',
                                        // '2 X Chicken Biryani',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '₹ ${dish.amount.toString()}.00',
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
                                        // Handle order notification tap
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                            //color: AppColors.light,
                                            borderRadius: BorderRadius.all(
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
                                              'Call Customer',
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
                                        leadingIcon:
                                            Icon(Icons.check_circle_outline),
                                        width: 150.0,
                                        fontSize: 13.0,
                                        height: 50.0,
                                        onTap: () {}),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
                              border: Border.all(color: AppColors.lightGrey3)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          item.orderId.toString(),
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
                                  '${item.time.toString()} pm | ${item.items.toString()} items',
                                  // '12.30 pm | 4 items',
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 16),
                                // Food Item Details
                                ...item.dishes.map((dish) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${dish.quantity.toString()} * ${dish.name.toString()}',
                                        // '2 X Chicken Biryani',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '₹ ${dish.amount.toString()}.00',
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

                                HeadingWidget(
                                  title: 'Delivery Person Details',
                                  fontSize: 16.0,
                                  color: AppColors.black,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        // Profile Icon in a round container
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.grey.shade300,
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
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              item.deliveryPerson.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                decorationColor: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Call Icon in a round container
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                      child: Image.asset(
                                        AppAssets.call_icon,
                                        width: 23.0,
                                        height: 23.0,
                                        color: AppColors.light,
                                      ),
                                    ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
          getDashboardOrderlist();
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
          '$label (0)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? AppColors.blue : AppColors.black,
          ),
        ),
      ),
    );
  }
}
