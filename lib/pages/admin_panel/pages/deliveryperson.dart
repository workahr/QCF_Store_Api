import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';

import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/button1_widget.dart';
import '../models/delivery_person_model.dart';

class Deliveryperson extends StatefulWidget {
  const Deliveryperson({super.key});

  @override
  State<Deliveryperson> createState() => _DeliverypersonState();
}

class _DeliverypersonState extends State<Deliveryperson> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getdeliveryperson();
  }

  //deliveryperson
  List<deliverypersons> deliverypersonpage = [];
  List<deliverypersons> deliverypersonpageAll = [];
  bool isLoading1 = false;

  Future getdeliveryperson() async {
    setState(() {
      isLoading1 = true;
    });

    try {
      var result = await apiService.getdeliveryperson();
      var response = deliverypersonmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          deliverypersonpage = response.list;
          deliverypersonpageAll = deliverypersonpage;
          isLoading1 = false;
        });
      } else {
        setState(() {
          deliverypersonpage = [];
          deliverypersonpageAll = [];
          isLoading1 = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        deliverypersonpage = [];
        deliverypersonpageAll = [];
        isLoading1 = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView.builder(
          itemCount: deliverypersonpage.length,
          itemBuilder: (context, index) {
            final e = deliverypersonpage[index];
            return ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.grey1)),
                  child: Image.asset(
                    // AppAssets.UserRounded,
                    e.image.toString(),
                    width: 18,
                    height: 18,
                  ),
                ),
                title: SubHeadingWidget(
                  title: 'Name',
                ),
                subtitle: HeadingWidget(
                  title: e.title.toString(),
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: HeadingWidget(
                      title: 'Assign Now',
                      fontSize: 12.0,
                      color: AppColors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
