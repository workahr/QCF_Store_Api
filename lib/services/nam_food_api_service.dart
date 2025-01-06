import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../pages/admin_panel/json_data/admin_orderdetails_json.dart';
import '../pages/admin_panel/json_data/delivery_person_json.dart';
import '../pages/admin_panel/json_data/delivery_person_list_json.dart';
import '../pages/admin_panel/json_data/individual_order_details_json.dart';
import '../pages/admin_panel/json_data/orders_payment_json.dart';
import '../pages/admin_panel/json_data/payments_page_json.dart';
import '../pages/admin_panel/json_data/report_json.dart';
import '../pages/admin_panel/json_data/screenshot_page_json.dart';
import '../pages/admin_panel/json_data/store_list_json.dart';
import '../pages/json_data/dashboard_orderlist_json.dart';
import '../pages/json_data/menu_details_json.dart';
import '../pages/json_data/order_list_json.dart';
import '../pages/json_data/orderdetails_json.dart';

class NamFoodApiService {
  static String liveApiPath = AppConstants.apiBaseUrl;
  static String liveImgPath = AppConstants.imgBaseUrl;

  static String appApiPath = '';
  final client = http.Client();

//  static var headerData = {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json ',
//   };

  static var headerData;

  NamFoodApiService() {
    getBearerToken();
  }
  getBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('auth_token');
    headerData = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $value',
    };
  }

//get all UserBranchList
  Future getAllUserBranchList() async {
    try {
      final url = Uri.parse('${liveApiPath}UserBranches/getUserBranchesList');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // get Kpi chart data
  Future getKpiChartData(postData) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}SignumReport/KPIEvolution/KPIEvolutionAllDataBranchwiseVisual');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Overview chart data
  Future getOverviewChartData(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}SignumReport/RoleBasedKPIVisual');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get festival
  Future getFilterFestivalData() async {
    try {
      final url =
          Uri.parse('${liveApiPath}ControlPanelSettingMasters/FestivalMaster');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Brands
  Future getFilterBrandsData(postData) async {
    try {
      final url =
          Uri.parse('${liveApiPath}ControlPanelSettingMasters/GeneralMaster');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Types
  Future getFilterTypesData(postData) async {
    try {
      final url =
          Uri.parse('${liveApiPath}ControlPanelSettingMasters/GeneralMaster');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Shape
  Future getFilterShapeData() async {
    try {
      final url = Uri.parse('${liveApiPath}Filter/FilterShape');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Shape
  Future getFilterFluorData() async {
    try {
      final url = Uri.parse('${liveApiPath}Filter/FilterFluor');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // get Salesman
  Future getFilterSalesmanData() async {
    try {
      final url =
          Uri.parse('${liveApiPath}ControlPanelSettingMasters/Salesman');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // post customer details
  Future inertCustomerDetails(postData) async {
    try {
      final url =
          Uri.parse('${liveApiPath}PosCustomerMaster/InsertCustomerMaster');
      final response = await client.post(url,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return jsonDecode(json);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // update customer details
  Future updateCustomerDetails(postData) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}PosCustomerMaster/UpdateCustomerMaster/Code=${postData['CODE']}');
      final response = await client.put(url,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return jsonDecode(json);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  handleError({message}) {
    throw Exception(message ?? 'Network Error');
  }

  // user  login
  Future userLogin(strUsername, strPassword) async {
    try {
      final url = Uri.parse('${liveApiPath}ValidatePassword?strusername=' +
          strUsername +
          '&strPassword=' +
          strPassword);
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // user Login With Otp
  Future userLoginWithOtp(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/mobilelogin');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        throw Exception(
            'Failed to login . Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

// carlist
  Future getcarList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/cars/getallcars');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

// save the car

  // Future saveCar(
  //     String apiCtrl, Map<String, dynamic> postData, imageFile) async {
  //   try {
  //     final url = Uri.parse(liveApiPath + apiCtrl);

  //     print('url $url');

  //     var headers = headerData;
  //     var request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );
  //     request.headers.addAll(headerData);

  //     for (var entry in postData.entries) {
  //       request.fields[entry.key] = entry.value.toString();
  //     }

  //     if (imageFile != null) {
  //       var image = await http.MultipartFile.fromPath('media', imageFile!.path);
  //       print(image);
  //       request.files.add(image);
  //     }

  //     request.headers.addAll(headers);
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       final json = await response.stream.bytesToString();
  //       return json;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return e;
  //   }
  // }

//save car and update

  Future saveCar(
      String apiCtrl, Map<String, dynamic> postData, imageFile) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('media', imageFile!.path);
        request.files.add(image);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // delete CarById
  Future deleteCarById(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/cars/delete-cars');
      final response = await client.delete(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get Carbyid
  Future getCarById(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/cars/list-cars-ById?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // update Car
  // Future updatecar(postData, imageFile) async {
  //   try {
  //     final url = Uri.parse('${liveApiPath}v1/cars/update-cars');
  //     final response = await client.post(url,
  //         headers: headerData, body: jsonEncode(postData));
  //     var request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );
  //     if (imageFile != null) {
  //       var image = await http.MultipartFile.fromPath('media', imageFile!.path);
  //       print(image);
  //       request.files.add(image);
  //     }

  //     if (response.statusCode == 200) {
  //       final json = response.body;
  //       return json;
  //     } else {
  //       print('error');
  //       throw Exception(
  //           'Failed. Status code: ${response.statusCode} ${response.toString()}');
  //     }
  //   } catch (e) {
  //     print('catcherror ${e}');
  //     return e;
  //   }
  // }

  // driverlist
  Future getdriverList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/user_details/getalluser_details');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // booking details by customer

  // get all booking
  Future getbookingbycustomer() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/list-booking-ByUser');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //booking  update by driver id and car id

  Future updatebookingbydriverid(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/update-booking');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  //save the Booking

  Future saveBooking(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/create-booking');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

// cancle update
  Future updatecancelbooking(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/booking-cancel');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // get all booking
  Future getbookingList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/getallbooking');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // get booking by id

  Future getBookingById(id) async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/booking/list-booking-ById?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // get kilometer for booking

  Future getkilometerByfromto(from, to) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/booking/calculate-distance?from_location=$from&to_location=$to');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // calculate bookinfg charges
  Future getboookingchargeBykmdate(
      totalkm, Fromdate, Todate, selectedCar) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/booking/calculate-booking_charge?total_distance=$totalkm&from_datetime=$Fromdate&to_datetime=$Todate&car_id=$selectedCar');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // thirdparty details Add

  Future saveThirdParty(postData) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/rental_owner_details/create-rental_owner_details');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // delete thirdpartyById
  Future deleteThirdpartyById(postData) async {
    print('thirdparty delete test $postData');
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/rental_owner_details/delete-rental_owner_details');
      final response = await client.delete(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get Thirdpartybyid
  Future getThirdpartyById(id) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/rental_owner_details/list-rental_owner_details-ById?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // update ThirdParty
  Future updatethirdparty(postData) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/rental_owner_details/update-rental_owner_details');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  Future getthirdpartyList() async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/rental_owner_details/getallrental_owner_details');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Driver Panel get all driver mytrip

  Future getmytripByidList(id) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/user_details/driver-trip-list?driver_id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

// Save Vehicalstatus

  Future savevehicalstatus(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/cars/update-vehicle_status');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // save the Expenses

  Future saveexpenses(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/expenses/create-expenses');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Expenses list
  Future getexpensesList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/expenses/getallexpenses');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // delete ExpensesById
  Future deleteExpensesById(postData) async {
    print('driver delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/expenses/delete-expenses');
      final response = await client.delete(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get expenses by id

  Future getExpensesById(id) async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/expenses/list-expenses-ById?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // expenses update

  Future updateexpenses(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/expenses/update-expenses');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // Start Kilomter  update

  Future updatestartkilomter(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/booking/startkm-endkm');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

// save the Driver

  Future saveDriver(String apiCtrl, Map<String, dynamic> postData) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      print('url $url');

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }

      // if (imageFile != null) {
      //   var image = await http.MultipartFile.fromPath('media', imageFile!.path);
      //   print(image);
      //   request.files.add(image);
      // }

      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // delete DriverById
  Future deleteDriverById(postData) async {
    print('driver delete test $postData');
    try {
      final url =
          Uri.parse('${liveApiPath}v1/user_details/delete-user_details');
      final response = await client.delete(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get Driverbyid
  Future getDriverById(id) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/user_details/list-user_details-ById?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // update Driver
  Future updatedriver(postData) async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/user_details/update-user_details');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // get all employee details
  Future employeeDetails(strUsername) async {
    try {
      final url =
          Uri.parse('${liveApiPath}EmployeeDetails?EMPMST_NAME=' + strUsername);
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // get daily Status
  Future getAllDailyStatus(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}ComOverallReports');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get all
  Future get(apiUrl) async {
    try {
      final url = Uri.parse(liveApiPath + apiUrl);
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // get all Leave Balance
  Future getAllLeaveBalance() async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeDetails?EMPMST_NAME');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  //get all LeaveApproval
  Future getAllLeaveApproval() async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComLeave');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // update customer details
  Future requestAction(postData) async {
    try {
      final url =
          Uri.parse('${liveApiPath}EmployeeComLeave?MID=${postData['MID']}');
      final response = await client.put(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return jsonDecode(json);
      } else {
        print('error response $response');
        throw Exception(response.toString());
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Save EntryWorkFromHome
  Future saveEntryWorkFromHome(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComWorkfromhome');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Save EntryLeave
  Future saveEntryLeave(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComLeave');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Save Entry Permission
  Future saveEntryPermission(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComPermission');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Save Entry Working Extra
  Future saveEntryWorkingExtra(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComWorkingExtra');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Save Entry Client Visit
  Future saveEntryClientVisit(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComClientLocation');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // get Overview chart data
  Future getAllEntryList(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}ComOverallReports');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // update Entry WorkFromHome
  Future updateEntryWorkFromHome(mid, postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComWorkfromhome?MID=$mid');

      final response = await client.put(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror $e');
      return e;
    }
  }

// delete WorkFromHomeById
  Future delete(apiUrl) async {
    try {
      final url = Uri.parse(liveApiPath + apiUrl);
      //final url = Uri.parse('${liveApiPath}EmployeeComWorkfromhome?MID=$mid');
      final response = await client.delete(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // update Entry Permission
  Future updateEntryPermission(mid, postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComPermission?MID=$mid');

      final response = await client.put(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror $e');
      return e;
    }
  }

// delete PermissionById
  Future deletePermissionById(mid) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComPermission?MID=$mid');
      final response = await client.delete(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // update Entry Leave
  Future updateEntryLeave(mid, postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComLeave?MID=$mid');

      final response = await client.put(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror $e');
      return e;
    }
  }

  // update Entry WorkingExtra
  Future updateEntryWorkingExtra(mid, postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComWorkingExtra?MID=$mid');

      final response = await client.put(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror $e');
      return e;
    }
  }

// update Entry ClientVisit
  Future updateEntryClientVisit(mid, postData) async {
    try {
      final url = Uri.parse('${liveApiPath}EmployeeComClientLocation?MID=$mid');

      final response = await client.put(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror $e');
      return e;
    }
  }

  // driverlist
  // Future getdriverList() async {
  //   try {
  //     final url = Uri.parse('${liveApiPath}v1/user_details/getalluser_details');
  //     final response = await client.get(
  //       url,
  //       headers: headerData,
  //     );
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to retrieve driver data: $e');
  //   }
  // }

  // Future getstoreList() async {
  //   try {
  //     // Create a list of DriversList with hardcoded data

  //     var result = await getStoreListJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve driver data: $e');
  //   }
  // }

  // //ecomAddtoCart

  // Future getdashbordlist() async {
  //   try {
  //     // Create a list of DriversList with hardcoded data

  //     var result = await gethomedashboardPageJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve AddtoCart: $e');
  //   }
  // }

  // //Homepage_Carousel

  // Future gethomecarousel() async {
  //   try {
  //     var result = await getHomeCarouselJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve Carousel: $e');
  //   }
  // }

  // //nam_myorderpage

  // Future getmyorderpage() async {
  //   try {
  //     // Create a list of DriversList with hardcoded data

  //     var result = await getMyOrderJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve MyOrder: $e');
  //   }
  // }

  // //ecomAddtoCart

  // Future getstoredishlist() async {
  //   try {
  //     // Create a list of DriversList with hardcoded data

  //     var result = await getStoreListJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve AddtoCart: $e');
  //   }
  // }

  //   Future getOrderPreviewlist() async {
  //   try {
  //     // Create a list of DriversList with hardcoded data

  //     var result = await getOrderPreviewListJsonData();
  //     return jsonEncode(result);
  //   } catch (e) {
  //     // Handle any errors
  //     throw Exception('Failed to retrieve AddtoCart: $e');
  //   }
  // }

  // Store Menu Details List

  Future getmenudetailslist() async {
    try {
      // Create a list of DriversList with hardcoded data

      var result = await gethomedashboardPageJsonData();
      return jsonEncode(result);
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to retrieve AddtoCart: $e');
    }
  }

  Future getDashboardOrderlist() async {
    try {
      // Create a list of DriversList with hardcoded data

      var result = await getDashboardOrderJsonData();
      return jsonEncode(result);
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to retrieve AddtoCart: $e');
    }
  }

  // Orderdetails

  Future getorderdetails() async {
    try {
      // Create a list of DriversList with hardcoded data

      var result = await getorderdetailsPageJsonData();
      return jsonEncode(result);
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // Orderlist

  Future getorderlist() async {
    try {
      var result = await getorderlistPageJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

// Admin panel :

  // Dashboard Order Details

  Future getdashboardorderdetailslist() async {
    try {
      var result = await getadmindashboradorderdetailsJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // Dashboard Order Details

  Future getstoredetailslist() async {
    try {
      var result = await getadminstorelistJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }
  // admindeliveryperson

  Future getdeliveryperson() async {
    try {
      var result = await getdeliverypersonJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }
  // admindeliverypersonlist

  Future getdeliverypersonlist() async {
    try {
      var result = await getdeliverypersonlistJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }
  // adminIndividualorderdetails

  Future getindividualorderdetails() async {
    try {
      var result = await getindividualorderdetailsJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }
  // adminpayments

  Future getpaymentspage() async {
    try {
      var result = await getpaymentspageJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // store Login
  Future storeLogin(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/login');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        throw Exception(
            'Failed to login . Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // get All Store Orders
  Future getAllStoreOrders() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallorderbystore');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Order Status Update
  Future orderStatusUpdate(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/orderstatusupdate');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        throw Exception(
            'Failed to login . Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  // Order Confirm
  Future orderConfirm(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/orderconfirm');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        throw Exception(
            'Failed to login . Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }
  // adminorderspayment

  Future getorderspaymentpage() async {
    try {
      var result = await getorderspaymentJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // adminreports
  Future getreportpage() async {
    try {
      var result = await getreportJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // adminscreenshot
  Future getscreenshotpage() async {
    try {
      var result = await getscreenshotpageJsonData();
      return jsonEncode(result);
    } catch (e) {
      throw Exception('Failed to retrieve OrderDetails: $e');
    }
  }

  // Store Api

  // Menu List
  Future getmenuList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallitem');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Menu List
  Future getmenuadminList(ID) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallitem_admin?store_id=$ID');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // MyStoreDetails
  Future getMyStoreDetails() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/mystoredetails');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //get MenuById
  Future getMenuById(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getitembyid?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //  Add Category

  Future addcategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createitemcategory');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Admin  Add Category

  // Future Adminaddcategory(postData, id) async {
  //   try {
  //     final url =
  //         Uri.parse('${liveApiPath}v1/createitemcategory_admin?store_id=$id');
  //     print("test1 ");
  //     final response = await client.post(
  //       url,
  //       headers: headerData,
  //       body: jsonEncode(postData),
  //     );
  //     print("test2 ");
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     return e;
  //   }
  // }

  Future Adminaddcategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createitemcategory_admin');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Category List
  Future getcategoryList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallitemcategory');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Admin  Category List
  Future AdmingetcategoryList(id) async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/getallitemcategory_admin?store_id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Admin Category List
  Future admingetcategoryList(Id) async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/getallitemcategory_admin?store_id=$Id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // update menu stock
  Future updatemenustock(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/itemstockupdate');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // update Store Status

  Future updateStoreStatus(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/storestatusupdate');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  //Admin update Store Status

  Future adminupdateStoreStatus(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/storestatusupdate_admin');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // Admin

  // Store List
  Future getStoreList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallstorebyadmin');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Add Store

  Future addstore(String apiCtrl, Map<String, dynamic> postData, imageFile,
      imageFile1) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('media', imageFile!.path);
        request.files.add(image);
      }
      if (imageFile1 != null) {
        var image =
            await http.MultipartFile.fromPath('store_media', imageFile1!.path);
        request.files.add(image);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get StoreById
  Future getStoreById(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getstorebyid?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Delivery Person List List
  Future getalldeliverypersonlist() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getalldeliveryperson');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Add Delivery Person

  Future adddeliveryperson(String apiCtrl, Map<String, dynamic> postData,
      imageFile, imageFile1, imageFileRc, imageFilePerson) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath(
            'license_front_img', imageFile!.path);
        request.files.add(image);
      }
      if (imageFile1 != null) {
        var image = await http.MultipartFile.fromPath(
            'license_back_img', imageFile1!.path);
        request.files.add(image);
      }
      if (imageFileRc != null) {
        var image =
            await http.MultipartFile.fromPath('vehicle_img', imageFileRc!.path);
        request.files.add(image);
      }
      if (imageFilePerson != null) {
        var image =
            await http.MultipartFile.fromPath('media', imageFilePerson!.path);
        request.files.add(image);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //get delivery person ById
  Future getDeliverypersonById(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getdeliverypersonbyid?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // delete Store Id
  Future deleteStoreById(postData) async {
    print('store delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deletestore');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // delete Delivery Person Id
  Future deleteDeleverypersonById(postData) async {
    print('Delivery person delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deletedeliveryperson');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

// assign Delivery Boy
  Future assignDeliveryboy(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/assigndeliveryorder');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //  get All Order Detail List for Admin Dashboard

  Future getallDashboardOrderdetailslist() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallorderbyadmin');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // add Payment

  Future addpayment(
      String apiCtrl, Map<String, dynamic> postData, imageFile) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('media', imageFile!.path);
        request.files.add(image);
      }

      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // Delivery Person List List
  Future getallstorepaymentlist() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallpayment');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  Future<String> getallOrderdetailslist() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallorderbyadmin');
      // final response = await client.get(
      //   url,
      //   headers: headerData,
      // );
      final response = await client.get(
        url,
        headers: headerData,
      );
      return response.body ?? '';

      // Debug log for response
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return response.body; // Return the response body as String
      } else {
        // Handle non-200 status codes
        print('Error: Received status code ${response.statusCode}');
        return json.encode({
          'status': 'ERROR',
          'message':
              'Failed to fetch data. Status code: ${response.statusCode}',
          'data': null,
        });
      }
    } catch (e) {
      // Catch and log exceptions
      print('Exception occurred: $e');
      return json.encode({
        'status': 'ERROR',
        'message': 'An error occurred while making the API call',
        'error': e.toString(),
      });
    }
  }

// paymentpage
  Future getPaymentpage() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallstorepayment');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  Future getDynamicAPI(String api) async {
    try {
      final url = Uri.parse('$liveApiPath$api');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

// un Assigned Delivery Boy
  Future getunasssigneddeliveryboyDashboardOrderlist() async {
    try {
      final url =
          Uri.parse('${liveApiPath}v1/getallorderbyadmin-unassigndelivery');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //  un Assigned Delivery Boy
  Future getallpaymentlist() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallpayment');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Admin

  // Store List
  // Future getStoreList() async {
  //   try {
  //     final url = Uri.parse('${liveApiPath}v1/getallstorebyadmin');
  //     final response = await client.get(
  //       url,
  //       headers: headerData,
  //     );
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     return e;
  //   }
  // }

  //Add Store

  // Future addstore(
  //     String apiCtrl, Map<String, dynamic> postData, imageFile) async {
  //   try {
  //     final url = Uri.parse(liveApiPath + apiCtrl);

  //     var headers = headerData;
  //     var request = http.MultipartRequest(
  //       'POST',
  //       url,
  //     );
  //     request.headers.addAll(headerData);

  //     for (var entry in postData.entries) {
  //       request.fields[entry.key] = entry.value.toString();
  //     }
  //     if (imageFile != null) {
  //       var image = await http.MultipartFile.fromPath('media', imageFile!.path);
  //       request.files.add(image);
  //     }
  //     request.headers.addAll(headers);
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       final json = await response.stream.bytesToString();
  //       return json;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return e;
  //   }
  // }

// //getallorders
//   Future getallOrderdetailslist() async {
//     try {
//       final url = Uri.parse('${liveApiPath}v1/getallorderbyadmin');
//       final response = await client.get(
//         url,
//         headers: headerData,
//       );
//       if (response.statusCode == 200) {
//         return response.body;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return e;
//     }
//   }

  // Future<String> getallOrderdetailslist() async {
  //   try {
  //     final url = Uri.parse('${liveApiPath}v1/getallorderbyadmin');
  //     // final response = await client.get(
  //     //   url,
  //     //   headers: headerData,
  //     // );
  //     final response = await client.get(
  //       url,
  //       headers: headerData,
  //     );
  //     return response.body ?? '';

  //     // Debug log for response
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       return response.body; // Return the response body as String
  //     } else {
  //       // Handle non-200 status codes
  //       print('Error: Received status code ${response.statusCode}');
  //       return json.encode({
  //         'status': 'ERROR',
  //         'message':
  //             'Failed to fetch data. Status code: ${response.statusCode}',
  //         'data': null,
  //       });
  //     }
  //   } catch (e) {
  //     // Catch and log exceptions
  //     print('Exception occurred: $e');
  //     return json.encode({
  //       'status': 'ERROR',
  //       'message': 'An error occurred while making the API call',
  //       'error': e.toString(),
  //     });
  //   }
  // }

//screenshotpage
  Future getScreenshotpage(Id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getpaymentbystore?store_id=$Id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //store menu save

  Future saveMenu(
      String apiCtrl, Map<String, dynamic> postData, imageFile) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('media', imageFile!.path);
        request.files.add(image);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //Admin store menu save

  Future AdminsaveMenu(
      String apiCtrl, Map<String, dynamic> postData, imageFile) async {
    try {
      final url = Uri.parse(liveApiPath + apiCtrl);

      var headers = headerData;
      var request = http.MultipartRequest(
        'POST',
        url,
      );
      request.headers.addAll(headerData);

      for (var entry in postData.entries) {
        request.fields[entry.key] = entry.value.toString();
      }
      if (imageFile != null) {
        var image = await http.MultipartFile.fromPath('media', imageFile!.path);
        request.files.add(image);
      }
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        final json = await response.stream.bytesToString();
        return json;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //Admin  get All Cart List by order for edit the order

  Future admingetCartList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getcart');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Admin add quantity for products edit order
  Future adminaddQuantity(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/addquantity');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('error response $response');
        throw Exception(response.toString());
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  //Admin remove quantity for products edit order
  Future adminremoveQuantity(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/removequantity');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('error response $response');
        throw Exception(response.toString());
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  //Admin User update Order

  Future adminupdateorder(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createorder');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //Admin Delete Cart
  Future admindeleteCart(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/deleteitem');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('error response $response');
        throw Exception(response.toString());
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  //Admin Get All Address For User

  Future admingetalladdressListuser() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getalladdress');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Admin delete Menu Id
  Future admindeleteMenuById(postData) async {
    print('store delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deleteitems_admin');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  //Admmin get MenuById
  Future admingetMenuById(id, store_id) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/getitembyid_admin?id=$id&store_id=$store_id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //get categorybyid

  Future getcategorybyid(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getitemcategorybyid?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

//get categorybyid

  Future Admingetcategorybyid(id, storeid) async {
    try {
      final url = Uri.parse(
          '${liveApiPath}v1/getitemcategorybyid_admin?id=$id&store_id=$storeid');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // delete categorybyid
  Future deletecategorybyid(postData) async {
    print('Delivery person delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deleteitemcategory');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // delete categorybyid
  Future Admindeletecategorybyid(postData, id) async {
    print('category delete test $postData');
    try {
      final url =
          Uri.parse('${liveApiPath}v1/deleteitemcategory_admin?store_id=$id');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

// update itemcategory

  Future updateItemCategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/updateitemcategory');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  //Admin update itemcategory

  // Future AdminupdateItemCategory(postData, id) async {
  //   try {
  //     final url =
  //         Uri.parse('${liveApiPath}v1/updateitemcategory_admin?store_id=$id');
  //     final response = await client.post(url,
  //         headers: headerData, body: jsonEncode(postData));

  //     if (response.statusCode == 200) {
  //       final json = response.body;
  //       return json;
  //     } else {
  //       print('error');
  //       throw Exception(
  //           'Failed. Status code: ${response.statusCode} ${response.toString()}');
  //     }
  //   } catch (e) {
  //     print('catcherror ${e}');
  //     return e;
  //   }
  // }

  Future AdminupdateItemCategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/updateitemcategory_admin');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // Admin Category List
  Future getadmincategoryList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallitemcategory');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Admin Add Category

  Future adminaddcategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createitemcategory');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //get admincategorybyid

  Future getadmincategorybyid(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getitemcategorybyid?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // admindelete categorybyid
  Future MenuEditAdminmodel(postData) async {
    print('Delivery person delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deleteitemcategory');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

// adminupdate itemcategory

  Future adminupdateItemCategory(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/updateitemcategory');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  // Admin edit the order

  Future admineditorder(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/alterorderitem');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

  //Admin Delete order item
  Future admindeleteitem(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/deleteorderitem');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('error response $response');
        throw Exception(response.toString());
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }

  //  Add PrimeLocation

  Future addprimelocation(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createmainlocation');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // Prime Location List
  Future getprimelocationList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallmainlocation');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // delete primelocation
  Future deleteprimelocation(postData) async {
    print('  delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deletemainlocation');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

  // Sub Location List
  Future getsublocationList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallsublocation');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  //  Add SubLocation

  Future addsublocation(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/createsublocation');
      print("test1 ");
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      print("test2 ");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

  // main location
  Future getallmainlocationList() async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getallmainlocation');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }

// delete sublocation
  Future deletesublocation(postData) async {
    print('  delete test $postData');
    try {
      final url = Uri.parse('${liveApiPath}v1/deletesublocation');
      final response = await client.post(
        url,
        headers: headerData,
        body: jsonEncode(postData),
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return [];
      }
    } catch (e) {
      return e;
    }
  }

// get PrimelocationByID
  Future getprimelocationbyid(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getmainlocationby?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
// Primelocation update

  Future updateprimelocation(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/updatemainlocation');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

// get sublocationByID
  Future getsublocationbyid(id) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/getsublocationby?id=$id');
      final response = await client.get(
        url,
        headers: headerData,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response;
      }
    } catch (e) {
      return e;
    }
  }
// sublocation update

  Future updatesublocation(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/updatesublocation');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));

      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        print('error');
        throw Exception(
            'Failed. Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('catcherror ${e}');
      return e;
    }
  }

// category on off

  Future categoryStatusUpdate(postData) async {
    try {
      final url = Uri.parse('${liveApiPath}v1/itemcateogrystatusupdate');
      final response = await client.post(url,
          headers: headerData, body: jsonEncode(postData));
      if (response.statusCode == 200) {
        final json = response.body;
        return json;
      } else {
        throw Exception(
            'Failed to login . Status code: ${response.statusCode} ${response.toString()}');
      }
    } catch (e) {
      print('error $e');
      handleError();
    }
  }
}
