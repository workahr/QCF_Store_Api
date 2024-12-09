import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';

import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/button1_widget.dart';
import '../api_model/assign_deliveryboy_model.dart';
import '../api_model/deliveryperson_list_model.dart';
import '../models/delivery_person_model.dart';

class Deliveryperson extends StatefulWidget {
  int? orderId;
  Deliveryperson({super.key, this.orderId});

  @override
  State<Deliveryperson> createState() => _DeliverypersonState();
}

class _DeliverypersonState extends State<Deliveryperson> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    print(widget.orderId);
    getalldeliverypersonlist();
  }

  //deliveryperson
  List<ListDeliveryPerson> deliverypersonlistpage = [];
  List<ListDeliveryPerson> deliverypersonlistpageAll = [];
  bool isLoading = false;

  Future getalldeliverypersonlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getalldeliverypersonlist();
      var response = getallDeliveryPersonmodelFromJson(result);
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

  Future<void> assignDeliveryboy(String deliveryboy_id) async {
    Map<String, dynamic> postData = {
      "order_id": widget.orderId,
      "delivery_partner_id": deliveryboy_id
    };

    try {
      var result = await apiService.assignDeliveryboy(postData);
      AssignDeliveryBoymodel response = assignDeliveryBoymodelFromJson(result);

      if (response.status == 'SUCCESS') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
        setState(() {});
        showInSnackBar(context, "Delivery Boy Assigned Successfully");
      } else {
        showInSnackBar(context, response.message);
      }
    } catch (error) {
      print('Error adding quantity: $error');
      showInSnackBar(context, 'Failed . Please try again.');
    }
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView.builder(
                itemCount: deliverypersonlistpage.length,
                itemBuilder: (context, index) {
                  final e = deliverypersonlistpage[index];
                  return ListTile(
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.grey1)),
                        child: e.imageUrl == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  AppAssets.UserRounded,
                                  width: 18,
                                  height: 18,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  AppConstants.imgBaseUrl +
                                      e.imageUrl.toString(),
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                        //  Image.asset(
                        //   // AppAssets.UserRounded,
                        //   e.image.toString(),
                        //   width: 18,
                        //   height: 18,
                        // ),
                      ),
                      title: SubHeadingWidget(
                        title: 'Name',
                      ),
                      subtitle: HeadingWidget(
                        title: e.fullname.toString(),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          assignDeliveryboy(e.id.toString());
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.red, width: 1),
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
