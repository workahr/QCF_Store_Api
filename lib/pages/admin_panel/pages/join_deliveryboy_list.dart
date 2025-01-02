import 'package:flutter/material.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_colors.dart';

class JoinDeliveryboy extends StatefulWidget {
  const JoinDeliveryboy({super.key});

  @override
  State<JoinDeliveryboy> createState() => _JoinDeliveryboyState();
}

List<Map<String, dynamic>> deliveryBoyDetails = [
  {
    'name': 'Joe',
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
];

class _JoinDeliveryboyState extends State<JoinDeliveryboy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'Join as Delivery Boy',
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
      body: ListView.builder(
        itemCount: deliveryBoyDetails.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['name'],
                        ),
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['Mobile'],
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['Address'],
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['Pincode'],
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['Mail'],
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        HeadingWidget(
                          title: deliveryBoyDetails[index]['description'],
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
