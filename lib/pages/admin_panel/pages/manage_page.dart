import 'package:flutter/material.dart';
import 'package:namstore/constants/constants.dart';
import 'package:namstore/pages/admin_panel/pages/add_delivery_charge_page.dart';

import 'package:namstore/pages/admin_panel/pages/store_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_Prime_location_page.dart';
import 'delivery_person_list.dart';
import 'report_page.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

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
              title: const Text('Store List'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreList()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.delivery,
                color: AppColors.red,
                height: 18,
                width: 18,
              ),
              title: const Text('Delivery Person List'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPersonList()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.UserRounded,
                height: 18,
                width: 18,
              ),
              title: const Text('Manage Password'),
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
              title: const Text('Prime Location'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrimeLocationPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.report,
                height: 18,
                width: 18,
              ),
              title: const Text('Add Delivery Charge'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddDeliveryChargePage()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportPage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                AppAssets.UserRounded,
                height: 18,
                width: 18,
              ),
              title: const Text('Log Out'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                _handleLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:namstore/constants/constants.dart';

// import 'package:namstore/pages/admin_panel/pages/store_list.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'delivery_person_list.dart';
// import 'manage_password_page.dart';
// import 'report_page.dart';

// class ManagePage extends StatefulWidget {
//   const ManagePage({super.key});

//   @override
//   State<ManagePage> createState() => _ManagePageState();
// }

// class _ManagePageState extends State<ManagePage> {
//   Future<void> _handleLogout() async {
//     // Clear SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     // Navigate to Login Page
//     Navigator.pushNamedAndRemoveUntil(
//         context, '/login', ModalRoute.withName('/login'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: 100.0,
//         title: const Text(
//           'Manage',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.red,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             ListTile(
//               leading: Image.asset(
//                 AppAssets.shop,
//                 color: AppColors.red,
//                 height: 18, // Adjusted for better visibility
//                 width: 18,
//               ),
//               title: const Text('Store List'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => StoreList()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Image.asset(
//                 AppAssets.delivery,
//                 color: AppColors.red,
//                 height: 18,
//                 width: 18,
//               ),
//               title: const Text('Delivery Person List'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DeliveryPersonList()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Image.asset(
//                 AppAssets.UserRounded,
//                 height: 18,
//                 width: 18,
//               ),
//               title: const Text('Manage Password'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ManagePasswordPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Image.asset(
//                 AppAssets.report,
//                 height: 18,
//                 width: 18,
//               ),
//               title: const Text('Report'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ReportPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Image.asset(
//                 AppAssets.UserRounded,
//                 height: 18,
//                 width: 18,
//               ),
//               title: const Text('Log Out'),
//               trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               onTap: () {
//                 _handleLogout();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
