import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../models/orders_payment_model.dart';

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
    getorderspaymentpage();
  }

  //Payments

  List<OrdersPaymentList> orderpaymentpage = [];
  List<OrdersPaymentList> orderpaymentpageAll = [];
  bool isLoading = false;

  Future getorderspaymentpage() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getorderspaymentpage();
      var response = orderspaymentmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          orderpaymentpage = response.list;
          orderpaymentpageAll = orderpaymentpage;
          isLoading = false;
        });
      } else {
        setState(() {
          orderpaymentpage = [];
          orderpaymentpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        orderpaymentpage = [];
        orderpaymentpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
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
          // const SizedBox(height: ),
          Expanded(
              child: ListView.builder(
            itemCount: orderpaymentpage.length,
            itemBuilder: (context, index) {
              final e = orderpaymentpage[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                child: Column(
                  children: [
                    // ListTile for the order details
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                          top: 0.0, left: 16.0, right: 16.0, bottom: 5),
                      title: Text(
                        'Order ID #${e.orderid}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${e.items}items | ${e.time} am | ${e.date}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            e.delivery,
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
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "₹ ${e.amount}",
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
                      color: Colors.grey[300], // Set the color of the divider
                      thickness: 1, // Set the thickness of the divider
                      indent: 10, // Indentation on the left
                      endIndent: 10, // Indentation on the right
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
