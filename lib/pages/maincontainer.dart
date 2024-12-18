import 'package:flutter/material.dart';
import 'package:namstore/pages/admin_panel/pages/add_store_page.dart';
import 'package:namstore/pages/admin_panel/pages/admin_home_page.dart';
import 'package:namstore/pages/admin_panel/pages/admindashboardpage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_assets.dart';
import 'admin_panel/pages/manage_page.dart';
import 'admin_panel/pages/payments_page.dart';
import 'admin_panel/pages/report_page.dart';
import 'admin_panel/pages/screenshot_page.dart';
import 'admin_panel/pages/store_list.dart';
import 'dashboard/dashboard_page.dart';
import 'order-list/orderlist_page.dart';
import 'order/orderdetails.dart';
import 'store_menu/menu_details_screen.dart';

class MainContainer extends StatefulWidget {
  final int initialPage;
  final Widget? childWidget;
  MainContainer({super.key, this.childWidget, this.initialPage = 0});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    DashboardPage(),
    MenuDetailsScreen(),
    OrderlistPage()
  ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      // Handle logout
      await _handleLogout();
    } else {
      // Handle other navigation
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.initialPage;
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

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
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 0
                    ? AppAssets.homeIconSelected // Selected icon
                    : AppAssets.home_icon,
                height: 25,
                width: 25,
              ),
              label: 'Home',

              //   backgroundColor: Color(0xFFE23744)
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 1
                    ? AppAssets.menuIconSelected
                    : AppAssets.menuIcon,
                height: 25,
                width: 25,
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 2
                    ? AppAssets.orderIconSelected
                    : AppAssets.orderImg,
                height: 25,
                width: 25,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 3
                    ? AppAssets.orderIconSelected
                    : AppAssets.orderImg,
                height: 25,
                width: 25,
              ),
              label: 'LogOut',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFE23744),
        ),
      ),
    );
  }
}

// Admin Panel Main Conatiner

class AdminMainContainer extends StatefulWidget {
  AdminMainContainer({super.key, this.childWidget, this.admininitialPage = 0});

  final Widget? childWidget;
  final int admininitialPage;

  @override
  State<AdminMainContainer> createState() => _AdminMainContainerState();
}

class _AdminMainContainerState extends State<AdminMainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    AdminHomePage(),
    AdminDashboardPage(),
    PaymentsPage(),
    ManagePage()
  ];

  void _onItemTapped(int index) async {
    // if (index == 2) {
    //   // Handle logout
    //   await _handleLogout();
    // } else {
    // Handle other navigation
    setState(() {
      _selectedIndex = index;
    });
    //}
  }

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.admininitialPage;
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

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
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 0
                    ? AppAssets.homeIconSelected // Selected icon
                    : AppAssets.home_icon,
                height: 25,
                width: 25,
              ),
              label: 'Home',

              //   backgroundColor: Color(0xFFE23744)
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 1
                    ? AppAssets.homeIconSelected // Selected icon
                    : AppAssets.home_icon,
                height: 25,
                width: 25,
              ),
              label: 'Dashboard',

              //   backgroundColor: Color(0xFFE23744)
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 2
                    ? AppAssets.menuIconSelected
                    : AppAssets.menuIcon,
                height: 25,
                width: 25,
              ),
              label: 'Payment',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 3
                    ? AppAssets.orderIconSelected
                    : AppAssets.orderImg,
                height: 25,
                width: 25,
              ),
              label: 'Manage',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFE23744),
        ),
      ),
    );
  }
}
