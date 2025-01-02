import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:namstore/pages/admin_panel/pages/orders_payment.dart';
import 'package:namstore/pages/order-list/orderlist_page.dart';
import 'package:namstore/services/comFuncService.dart';
import 'controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'constants/constants.dart';
import 'package:upgrader/upgrader.dart';
import 'pages/admin_panel/pages/Individual_order_details.dart';
import 'pages/admin_panel/pages/totalorder.dart';
import 'pages/auth/login_page.dart';
import 'pages/landing_page.dart';
import 'pages/loginmanagement.dart';
import 'pages/maincontainer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'services/firebase_services/firebase_api_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// import 'package:flutter/services.dart';
final navigatorKey = GlobalKey<NavigatorState>();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // if (Platform.isAndroid) {
//   //   // Request notification permission on Android 13+
//   //   if (await Permission.notification.isDenied) {
//   //     await Permission.notification.request();
//   //   }
//   // }
//   // // Initialize Firebase
//   // await Firebase.initializeApp();

//   if (!kIsWeb) {
//     // await FirebaseAPIServices().initNotifications();
//   }

//   BaseController baseCtrl = Get.put(BaseController());

//   // Ensure the token is retrieved after initialization
//   // String? token = await FirebaseMessaging.instance.getToken();
//   // print("token $token");

//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    // Request notification permission on Android 13+
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }
  // Initialize Firebase
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   showNotification(message);
  // });

  if (!kIsWeb) {
    await FirebaseAPIServices().initNotifications();
  }

  BaseController baseCtrl = Get.put(BaseController());

  // Ensure the token is retrieved after initialization
  String? token = await FirebaseMessaging.instance.getToken();
  print("token $token");
  baseCtrl.fbUserId = token;

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showNotification(message);
}

Future<void> showNotification(RemoteMessage message) async {
  print("notify");

  // Define notification details for Android
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id_5',
    'test',
    sound: RawResourceAndroidNotificationSound('sound'), // Set custom sound
    importance: Importance.high,
    priority: Priority.high,
  );
  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);
  print(platformDetails);

  int? notificationId; // nullable
  notificationId ??= 12;
  // print(notification.title);
  // Show the notification
  await flutterLocalNotificationsPlugin.show(
    notificationId,
    message.notification?.title,
    message.notification?.body,
    platformDetails,
    payload: 'Custom_Sound_Notification',
  );
  // showInSnackBar(context, 'Processing...');
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  BaseController baseCtrl = Get.put(BaseController());

  _MyAppState() {
    print('baseCtrl ${baseCtrl.isDarkModeEnabled.value}');
    // baseCtrl.isDarkModeEnabled.listen((value) {
    //   refresh();
    // });
  }

  refresh() {
    setState(() {
      isDarkModeEnabled = baseCtrl.isDarkModeEnabled.value;
      AppColors();
    });
  }

  bool isDarkModeEnabled = false;
  var position;

  toggleDarkMode() {
    setState(() {
      isDarkModeEnabled = !isDarkModeEnabled;
      AppColors();
      print('color ${AppColors.dark}');
      print('isDarkModeEnabled ${AppColors.dark}');
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  bool isDebugMode() {
    bool isDebug = false;
    if (!kReleaseMode && (kDebugMode || kProfileMode)) {
      isDebug = true;
    }
    return isDebug;
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  void deactivate() async {
    print('page deactivate');
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    } else if (state == AppLifecycleState.inactive) {
      // checkuserlog("-close");
    } else if (state == AppLifecycleState.paused) {
      // checkuserlog("-pause");
    }
  }

  // Future<void> main() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   if (!kIsWeb) {
  //     await Firebase.initializeApp();
  //     await FirebaseAPIServices().initNotifications();
  //   }

  //   BaseController baseCtrl = Get.put(BaseController());

  //   String? token = baseCtrl.fbUserId;

  //   print("token $token");

  //   runApp(MyApp());
  // }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: isDarkModeEnabled ? AppTheme.darkTheme : AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/login': (context) => UpgradeAlert(
                upgrader: Upgrader(
                  showIgnore: false,
                  showLater: false,
                  durationUntilAlertAgain: const Duration(seconds: 1),
                ),
                child: const LoginPage(),
                // child: LoginPageGoogle(),
              ),
          '/home': (context) => UpgradeAlert(
                upgrader: Upgrader(
                  showIgnore: false,
                  showLater: false,
                  durationUntilAlertAgain: const Duration(seconds: 1),
                ),
                child: LoginManagement(),
              ),
        },
        // home: const OrdersPayment(),
      ),
    );
  }
}
