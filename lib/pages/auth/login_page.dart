import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namstore/pages/maincontainer.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/custom_text_field.dart';
import 'auth_validations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  AuthValidation authValidation = AuthValidation();
  final NamFoodApiService apiService = NamFoodApiService();

   var obscureText = true;
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
                    type: const TextInputType.numberWithOptions(),
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
                              : Icon(
                                  MdiIcons.eyeOff,
                                  color: AppColors.red
                                ),
                        ),
                        width: MediaQuery.of(context).size.width / 1.1,
                      ),

                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainContainer(
                              
                            ),
                          ),
                        );
                        //login();
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
