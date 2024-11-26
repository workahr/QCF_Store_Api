import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../constants/app_colors.dart';
import '../../constants/constants.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../models/orderdetails_model.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getorderdetails();
  }

  //orderdetails
  List<DetailList> orderdetail = [];
  List<DetailList> orderdetailAll = [];
  bool isLoading = false;

  Future getorderdetails() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getorderdetails();
      var response = orderdetailsmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderdetail = response.list;
          orderdetailAll = orderdetail;
          isLoading = false;
        });
      } else {
        setState(() {
          orderdetail = [];
          orderdetailAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderdetail = [];
        orderdetailAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

//totalCalculation
  double calculateTotal() {
    return orderdetail.fold(
      0.0,
      (total, item) =>
          total + (int.parse(item.qty) * double.parse(item.amount)),
    );
  }

  //timer
  double _minutes = 0.0;

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
                      const SizedBox(height: 5),
                      HeadingWidget(title: '#334343343'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SubHeadingWidget(title: '12:30 PM'),
                          const SizedBox(width: 8),
                          const Text('|'),
                          const SizedBox(width: 8),
                          SubHeadingWidget(title: '4 items'),
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
                          SubHeadingWidget(title: 'Items'),
                          SubHeadingWidget(title: 'Qty X Price'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // ListView with Flexible
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderdetail.length,
                        itemBuilder: (context, index) {
                          final e = orderdetail[index];
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      e.dishtype == "Non-Veg"
                                          ? Image.asset(AppAssets.nonveg_icon,
                                              width: 14, height: 14)
                                          : Image.asset(AppAssets.veg_icon,
                                              width: 14, height: 14),
                                      const SizedBox(width: 8),
                                      HeadingWidget(
                                        title: e.dishname.toString(),
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      HeadingWidget(
                                          title: e.qty.toString(),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                      HeadingWidget(
                                          title: ' X ',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                      HeadingWidget(
                                          title: '₹${e.amount.toString()}',
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
                              title: '₹${calculateTotal().toStringAsFixed(2)}',
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
                        title: 'Cash on delivery',
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
                  setState(() {});
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
                  setState(() {});
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
