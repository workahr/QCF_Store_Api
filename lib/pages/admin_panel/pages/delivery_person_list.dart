import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';

import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/button1_widget.dart';
import '../models/delivery_person_list_model.dart';

class DeliveryPersonList extends StatefulWidget {
  const DeliveryPersonList({super.key});

  @override
  State<DeliveryPersonList> createState() => _DeliverypersonState();
}

class _DeliverypersonState extends State<DeliveryPersonList> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();

    getdeliverypersonlist();
  }

  //deliveryperson
  List<Lists> deliverypersonlistpage = [];
  List<Lists> deliverypersonlistpageAll = [];
  bool isLoading = false;

  Future getdeliverypersonlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getdeliverypersonlist();
      var response = deliverypersonlistmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          deliverypersonlistpage = response.list;
          deliverypersonlistpageAll = deliverypersonlistpage;
          isLoading = false;
        });
      } else {
        setState(() {
          deliverypersonlistpage = [];
          deliverypersonlistpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        deliverypersonlistpage = [];
        deliverypersonlistpageAll = [];
        isLoading = false;
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
          'Delivery person list',
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: ListView.builder(
          itemCount: deliverypersonlistpage.length,
          itemBuilder: (context, index) {
            final e = deliverypersonlistpage[index];
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.grey1)),
                    child: Image.asset(
                      e.image.toString(),
                      width: 18,
                      height: 18,
                    ),
                  ),
                  title: HeadingWidget(
                    title: e.title.toString(),
                  ),
                  subtitle: SubHeadingWidget(
                    title: e.mobilenumber,
                    color: AppColors.black,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.red)),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 24,
                          color: AppColors.red,
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.red)),
                        child: Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: AppColors.grey1,
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
