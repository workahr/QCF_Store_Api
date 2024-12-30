import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:namstore/pages/maincontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../controllers/base_controller.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import '../admin_panel/pages/add_store_page.dart';
import '../admin_panel/pages/admindashboardpage.dart';
import 'auth_validations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  AuthValidation authValidation = AuthValidation();
  BaseController baseCtrl = Get.put(BaseController());
  final NamFoodApiService apiService = NamFoodApiService();

  var obscureText = true;

  Future login() async {
    print("baseCtrl.fbUserId${baseCtrl.fbUserId}");
    try {
      showInSnackBar(context, 'Processing...');

      if (usernameCtrl.text != "" && passwordCtrl.text != "") {
        Map<String, dynamic> postData = {
          "username": usernameCtrl.text,
          "password": passwordCtrl.text,
          'mobile_push_id': baseCtrl.fbUserId
          // 'mobile_push_id': baseCtrl.fbUserId
        };
        var result = await apiService.storeLogin(postData);
        LoginModel response = loginModelFromJson(result);

        closeSnackBar(context: context);

        if (response.status.toString() == 'SUCCESS') {
          final prefs = await SharedPreferences.getInstance();

          //prefs.setString('fullname', response.fullname ?? '');

          if (response.authToken != null) {
            Navigator.pushNamed(context, '/');
            prefs.setString('auth_token', response.authToken ?? '');
            prefs.setBool('isLoggedin', true);
            prefs.setInt('role', response.role);

            Navigator.pushNamedAndRemoveUntil(
                context, '/home', ModalRoute.withName('/home'));
          }

          setState(() {});
        } else {
          showInSnackBar(context, response.message.toString());
        }
      } else {
        showInSnackBar(context, "Please fill required fields");
      }
    } catch (error) {
      showInSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and header section
            const SizedBox(height: 15.0),
            Image.asset(
              AppAssets.logo,
              width: double.infinity,
              // height: 280.0,
              fit: BoxFit.fill,
            ),
            //const SizedBox(height: 200.0),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  //  const SizedBox(height: 10.0),
                  CustomeTextField(
                    labelText: 'User Name',
                    control: usernameCtrl,
                    validator:
                        authValidation.errValidateMobileNo(usernameCtrl.text),
                    width: MediaQuery.of(context).size.width / 1.1,
                    // type: const TextInputType.numberWithOptions(),
                    prefixIcon: Image.asset(AppAssets.UserRounded),
                  ),

                  // CustomeTextField(
                  //     labelText: 'Password',
                  //     control: passwordCtrl,
                  //     validator:
                  //         authValidation.errValidateMobileNo(passwordCtrl.text),
                  //     width: MediaQuery.of(context).size.width / 1.1,
                  //     type: const TextInputType.numberWithOptions(),
                  //     prefixIcon: Image.asset(AppAssets.passwordImg),
                  //     suffixIcon: Image.asset(
                  //         AppAssets.passwordEye) // Set +91 as prefixText
                  //     ),

                  CustomeTextField(
                    obscureText: obscureText,
                    labelText: 'Password',
                    control: passwordCtrl,
                    validator: authValidation
                        .errValidatePasswordForLogin(passwordCtrl.text),
                    prefixIcon: Image.asset(AppAssets.passwordImg),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText
                          ? Icon(
                              MdiIcons.eye,
                              color: AppColors.red,
                            )
                          : Icon(MdiIcons.eyeOff, color: AppColors.red),
                    ),
                    width: MediaQuery.of(context).size.width / 1.1,
                  ),

                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MainContainer(

                        //     ),
                        //   ),
                        // );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AdminMainContainer()),
                        // );
                        login();
                        print(
                            'Get OTP tapped with number: ${passwordCtrl.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style:
                            TextStyle(fontSize: 16.0, color: AppColors.light),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
