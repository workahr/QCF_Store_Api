import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class ManagePasswordPage extends StatefulWidget {
  const ManagePasswordPage({super.key});

  @override
  State<ManagePasswordPage> createState() => _ManagePasswordPageState();
}

class _ManagePasswordPageState extends State<ManagePasswordPage> {
  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'Back',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: storeForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      CustomTextField(
                        hintText: "Enter Old Password",
                        labelText: "Enter Old Password",
                        controller: oldPasswordController,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Enter New Password",
                        labelText: "Enter New Password",
                        controller: newPasswordController,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Confirm Password",
                        labelText: "Confirm Password",
                        controller: confirmPasswordController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Change Password',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration buildInputDecoration({
  required String hintText,
  required String labelText,
  Color borderColor = AppColors.lightGrey3,
  Color focusedColor = AppColors.red,
  Color TextColor = AppColors.grey,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: focusedColor),
    ),
    hintText: hintText,
    hintStyle: TextStyle(color: TextColor),
    labelText: labelText,
    labelStyle: TextStyle(color: TextColor), // Default label style
    floatingLabelStyle: TextStyle(
      color: focusedColor, // Floating label style when focused
      fontWeight: FontWeight.bold,
    ),
  );
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? prefixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: buildInputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
