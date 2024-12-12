import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../constants/constants.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../dashboard/order_status_model.dart';
import '../dashboard/store_order_list_model.dart';
import '../maincontainer.dart';
import '../models/orderdetails_model.dart';
import '../order_confirm_page.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  final String time;
  final String totalPrice;
  final String paymentMethod;
  final String mobilenumber;
  List<OrderItems> orderitems;
  OrderDetails(
      {super.key,
      required this.orderitems,
      required this.paymentMethod,
      required this.orderId,
      required this.time,
      required this.mobilenumber,
      required this.totalPrice});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
  }

// //totalCalculation
//   double calculateTotal() {
//     return orderdetail.fold(
//       0.0,
//       (total, item) =>
//           total + (int.parse(item.qty) * double.parse(item.amount)),
//     );
//   }

  //timer
  double _minutes = 0.0;

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

  Future orderStatusUpdate() async {
    try {
      Map<String, dynamic> postData = {
        "order_id": widget.orderitems[0].orderId,
        "order_status": "Cancelled"
      };
      var result = await apiService.orderStatusUpdate(postData);
      OrderStatusModel response = orderStatusModelFromJson(result);

      closeSnackBar(context: context);

      if (response.status.toString() == 'SUCCESS') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainContainer(),
          ),
        );
        setState(() {});
      } else {
        // showInSnackBar(context, response.message.toString());
      }
    } catch (error) {
      //  showInSnackBar(context, error.toString());
    }
  }

  Future orderConfirm() async {
    try {
      Map<String, dynamic> postData = {
        "order_id": widget.orderitems[0].orderId,
        "prepare_min": _minutes.toString()
      };
      var result = await apiService.orderConfirm(postData);
      OrderStatusModel response = orderStatusModelFromJson(result);

      closeSnackBar(context: context);

      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderConfirmPage(),
            ),
          );
        });
      } else {
        // showInSnackBar(context, response.message.toString());
      }
    } catch (error) {
      //   showInSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                HeadingWidget(
                                  title: 'Order ID',
                                  fontWeight: FontWeight.w400,
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // Handle order notification tap
                                makePhoneCall(widget.mobilenumber.toString());
                              },
                              child: Container(
                                height: 30,
                                width: 120,
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    //color: AppColors.light,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    border: Border.all(color: AppColors.red)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                          color: AppColors.red, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(height: 5),
                      HeadingWidget(title: widget.orderId.toString()),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SubHeadingWidget(
                            title: dateFormat(widget.time.toString()),
                            color: const Color.fromARGB(255, 60, 60, 60),
                          ),
                          const SizedBox(width: 8),
                          const Text('|'),
                          const SizedBox(width: 8),
                          SubHeadingWidget(
                            title:
                                '${widget.orderitems.length.toString()} items',
                            color: const Color.fromARGB(255, 60, 60, 60),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: AppColors.grey1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingWidget(
                            title: 'Items',
                            color: const Color.fromARGB(255, 60, 60, 60),
                          ),
                          SubHeadingWidget(
                            title: 'Qty X Price',
                            color: const Color.fromARGB(255, 60, 60, 60),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // ListView with Flexible
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.orderitems.length,
                        itemBuilder: (context, index) {
                          final e = widget.orderitems[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // e.dishtype == "Non-Veg"
                                      //     ? Image.asset(AppAssets.nonveg_icon,
                                      //         width: 14, height: 14)
                                      //     : Image.asset(AppAssets.veg_icon,
                                      //         width: 14, height: 14),
                                      const SizedBox(width: 8),
                                      HeadingWidget(
                                        title: e.productName.toString(),
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      HeadingWidget(
                                          title: e.quantity.toString(),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                      HeadingWidget(
                                          title: ' X ',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                      HeadingWidget(
                                          title: '₹${e.price.toString()}',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              )
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      DottedLine(
                        lineThickness: 2,
                        direction: Axis.horizontal,
                        dashColor: AppColors.grey1,
                        dashLength: 2,
                        dashGapLength: 2,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeadingWidget(
                            title: 'Total',
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                          HeadingWidget(
                              title: '₹${widget.totalPrice}',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DottedLine(
                        lineThickness: 2,
                        direction: Axis.horizontal,
                        dashColor: AppColors.grey1,
                        dashLength: 2,
                        dashGapLength: 2,
                      ),
                      const SizedBox(height: 12),
                      HeadingWidget(
                        title: 'Set preparation time',
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 12),

                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: AppColors.grey1),
                        ),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_minutes > 0) _minutes -= 0.5;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightred,
                                ),
                                height: 60,
                                width: 80,
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                            Text(
                              '${_minutes.toStringAsFixed(2)} mins',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _minutes += 0.5;
                                });
                              },
                              child: Container(
                                height: 60,
                                width: 80,
                                color: AppColors.lightred,
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.red,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),
                      HeadingWidget(
                        title: 'Payment method',
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      HeadingWidget(
                        title: widget.paymentMethod == "Cash"
                            ? 'Cash on delivery'
                            : "Online Payment",
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    orderStatusUpdate();
                  });
                },
                child: Container(
                  height: 60,
                  color: AppColors.white,
                  child: Center(
                    child: HeadingWidget(
                      title: 'Reject',
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    orderConfirm();
                  });
                },
                child: Container(
                  height: 60,
                  color: AppColors.green,
                  child: Center(
                    child: HeadingWidget(
                      title: 'Confirm',
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
