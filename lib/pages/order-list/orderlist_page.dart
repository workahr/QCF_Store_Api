import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/dashed_divider.dart';
import '../../constants/app_assets.dart';
import 'package:intl/intl.dart';

import '../../widgets/heading_widget.dart';

class OrderlistPage extends StatefulWidget {
  const OrderlistPage({super.key});

  @override
  State<OrderlistPage> createState() => _OrderlistPageState();
}

class _OrderlistPageState extends State<OrderlistPage> {
  bool isOnDuty = true;
  late String formattedDate;

  String toggleTitle = "On Duty";


  @override
  void initState() {
    super.initState();
    DateFormat('MMMM y').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM y').format(DateTime.now());
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 30.0, right: 16.0, bottom: 5),
              child: Text(
                formattedDate,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 16.0, right: 16.0, bottom: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '29-Oct-2024',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '#233352633356',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '3 items',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2 X Chicken Biryani',
                              style: TextStyle(fontSize: 14)),
                          Text('₹300.00', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('3 X Chicken Biryani',
                              style: TextStyle(fontSize: 14)),
                          Text('₹500.00', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 16),
                      DashedDivider(
                        color: Colors.grey,
                        height: 1,
                        dashWidth: 12,
                        spacing: 6,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Bill',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹800.00',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DashedDivider(
                        color: Colors.grey,
                        height: 1,
                        dashWidth: 12,
                        spacing: 6,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment method:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Cash on delivery',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 16.0, right: 16.0, bottom: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '29-Oct-2024',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '#233352633356',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '3 items',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2 X Chicken Biryani',
                              style: TextStyle(fontSize: 14)),
                          Text('₹300.00', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('3 X Chicken Biryani',
                              style: TextStyle(fontSize: 14)),
                          Text('₹500.00', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 16),
                      DashedDivider(
                        color: Colors.grey,
                        height: 1,
                        dashWidth: 12,
                        spacing: 6,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Bill',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹800.00',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DashedDivider(
                        color: Colors.grey,
                        height: 1,
                        dashWidth: 12,
                        spacing: 6,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment method:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Cash on delivery',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
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
