import 'package:flutter/material.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/custom_text_field.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

class AddDeliveryperson extends StatefulWidget {
  const AddDeliveryperson({super.key});

  @override
  State<AddDeliveryperson> createState() => _AddDeliverypersonState();
}

class _AddDeliverypersonState extends State<AddDeliveryperson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Color(0xFFE23744),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title:
            Text("Add delivery person", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Name',
                width: double.infinity,
                hint: 'Name',
              ),
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Mobile number',
                width: double.infinity,
                hint: 'Mobile number',
              ),
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Email id',
                width: double.infinity,
                hint: 'Email id',
              ),
              CustomeTextField(
                lines: 4,
                borderColor: AppColors.grey1,
                labelText: 'Address',
                contentPadding: EdgeInsets.all(18),
                width: double.infinity,
                hint: 'Address',
              ),
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Vehicle Number',
                width: double.infinity,
                hint: 'Vehicle Number',
              ),
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Driving license number',
                width: double.infinity,
                hint: 'Driving license number',
              ),
              SizedBox(
                height: 4,
              ),
              SubHeadingWidget(
                title: 'Note: Upload front and back side of License image',
              ),
              SizedBox(
                height: 8,
              ),
              OutlineBtnWidget(
                width: double.infinity,
                fillColor: AppColors.n_blue.withOpacity(0.1),
                borderColor: AppColors.n_blue,
                title: 'Upload Driving License Photo',
                titleColor: AppColors.n_blue,
                icon: Icons.add_a_photo_rounded,
                iconColor: AppColors.n_blue,
              ),
              SizedBox(
                height: 10,
              ),
              CustomeTextField(
                borderColor: AppColors.grey1,
                labelText: 'Rc book number',
                width: double.infinity,
                hint: 'Rc book number',
              ),
              SubHeadingWidget(
                title: 'Note: Upload front and back side of License image',
              ),
              SizedBox(
                height: 10,
              ),
              OutlineBtnWidget(
                width: double.infinity,
                fillColor: AppColors.n_blue.withOpacity(0.1),
                borderColor: AppColors.n_blue,
                title: 'Upload Rc Book Image',
                titleColor: AppColors.n_blue,
                icon: Icons.add_a_photo_rounded,
                iconColor: AppColors.n_blue,
              ),
              SizedBox(
                height: 18,
              ),
              OutlineBtnWidget(
                width: double.infinity,
                fillColor: AppColors.n_blue.withOpacity(0.1),
                borderColor: AppColors.n_blue,
                title: 'Upload Passport Size Photo',
                titleColor: AppColors.n_blue,
                icon: Icons.add_a_photo_rounded,
                iconColor: AppColors.n_blue,
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: ButtonWidget(
                  borderRadius: 10,
                  title: 'Save',
                  color: AppColors.red,
                  width: 150,
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
