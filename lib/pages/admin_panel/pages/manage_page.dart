import 'package:flutter/material.dart';
import 'package:namstore/constants/constants.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.0,
        title: const Text(
          'Manage',
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
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.shop,
                color: AppColors.red,
                height: 18, // Adjusted for better visibility
                width: 18,
              ),
              title: const Text('Store list'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or functionality here
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.delivery,
                color: AppColors.red,
                height: 18,
                width: 18,
              ),
              title: const Text('Delivery person list'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or functionality here
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.UserRounded,
                height: 18,
                width: 18,
              ),
              title: const Text('Manage password'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or functionality here
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.report,
                height: 18,
                width: 18,
              ),
              title: const Text('Report'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
