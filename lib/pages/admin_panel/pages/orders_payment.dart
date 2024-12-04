import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/orderpayment_model.dart';

class OrdersPayment extends StatefulWidget {
  const OrdersPayment({super.key});

  @override
  State<OrdersPayment> createState() => _OrdersPaymentState();
}

class _OrdersPaymentState extends State<OrdersPayment> {
  final NamFoodApiService apiService = NamFoodApiService();
  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  List<ListElement> ordersList = [];
  List<ListElement> ordersListAll = [];

  bool isLoading = false;

  String dateFormat(dynamic date) {
    DateTime dateTime = date is DateTime ? date : DateTime.parse(date);

    String formattedTime = DateFormat('h:mm a').format(dateTime).toLowerCase();
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);

    return "$formattedTime | $formattedDate";
  }

  Future getOrderList() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getDynamicAPI('v1/getallorderbyadmin');
      var response = ordersPaymentModelFromJson(result);

      if (response.status == 'SUCCESS') {
        print("Success");
        setState(() {
          ordersList = response.list;
          ordersListAll = ordersList;
          isLoading = false;

          print(ordersListAll);
        });
      } else {
        setState(() {
          ordersList = [];
          isLoading = false;
        });
        showInSnackBar(context, result.message.toString());
      }
    } catch (e) {
      setState(() {
        ordersList = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
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
        toolbarHeight: 100,
        leading: const Icon(
          Icons.chevron_left,
          size: 30,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 16.0, right: 16.0, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset(AppAssets.search_icon),
                  hintText: 'Search..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              )),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) {
              final order = ordersList[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 0.0, left: 16.0, right: 16.0, bottom: 5),
                      title: Text(
                        'Order ID #${order.invoiceNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in order.items)
                            Text(
                              '${item.quantity} ${item.quantity > 1 ? 'items' : 'item'} | ${dateFormat(order.createdDate)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          const SizedBox(height: 5),
                          Text(
                            order.paymentMethod == 'Cash'
                                ? 'Cash On Delivery '
                                : 'Online Payment',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Amount:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "₹${order.totalPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider to separate each item
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
