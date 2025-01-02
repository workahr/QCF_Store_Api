import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/heading_widget.dart';

class JoinStore extends StatefulWidget {
  const JoinStore({super.key});

  @override
  State<JoinStore> createState() => _JoinStoreState();
}

List<Map<String, dynamic>> storedetails = [
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
  {
    'name': 'Joe',
    'storename': 'Joe Store',
    'Storeimage': AppAssets.profileimg,
    'Mobile': 1234567890,
    'Address': 'No.1 Toll Gate, Trichy',
    'Pincode': 623154,
    'Mail': 'joe@gmail.com',
    'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
  },
];

class _JoinStoreState extends State<JoinStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'Join as Store',
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
        itemCount: storedetails.length,
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              storedetails[index]['Storeimage'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingWidget(
                                    title: storedetails[index]['name'],
                                  ),
                                  HeadingWidget(
                                    title: storedetails[index]['storename'],
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  HeadingWidget(
                                    title: storedetails[index]['Mobile'],
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Wrap(
                                    children: [
                                      HeadingWidget(
                                        title: storedetails[index]['Address'],
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  HeadingWidget(
                                    title: storedetails[index]['Pincode'],
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  HeadingWidget(
                                    title: storedetails[index]['Mail'],
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Wrap(
                                    children: [
                                      HeadingWidget(
                                        title: storedetails[index]
                                            ['description'],
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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
