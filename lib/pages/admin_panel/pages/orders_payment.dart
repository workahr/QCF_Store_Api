import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';

class OrdersPayment extends StatefulWidget {
  const OrdersPayment({super.key});

  @override
  State<OrdersPayment> createState() => _OrdersPaymentState();
}

class _OrdersPaymentState extends State<OrdersPayment> {
  final List<Map<String, String>> orders = [
    {
      'id': '233352633356',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
    {
      'id': '233352633357',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
    {
      'id': '233352633357',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
    {
      'id': '233352633357',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
    {
      'id': '233352633357',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
    {
      'id': '233352633357',
      'items': '3 items',
      'time': '10:32 am',
      'date': '29-Oct-2024',
      'payment': 'Cash on delivery',
      'amount': '₹1,000.00',
    },
  ];

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
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
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
                        'Order ID #${order['id']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${order['items']} | ${order['time']} | ${order['date']}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            order['payment']!,
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
                            order['amount']!,
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
