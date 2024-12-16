import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';

import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/outline_btn_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/button1_widget.dart';
import '../api_model/delete_deliveryperson_model.dart';
import '../api_model/deliveryperson_list_model.dart';
import '../models/delivery_person_list_model.dart';
import 'add_deliveryperson.dart';

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

  Future deleteDeleverypersonById(String userid) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {"user_id": userid};
    print("delete $postData");

    var result = await apiService.deleteDeleverypersonById(postData);
    DeleteDeliveryPersonmodel response =
        deleteDeliveryPersonmodelFromJson(result);

    if (!mounted) return; // Ensure widget is still in the tree

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        getalldeliverypersonlist();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 83,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
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
      body: isLoading
          ? ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : Padding(
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
                          child: e.imageUrl == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    AppAssets.UserRounded,
                                    width: 18,
                                    height: 18,
                                    //  fit: BoxFit.cover,
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
                          //                            Image.asset(
                          //   e.imageUrl.toString(),
                          //   width: 18,
                          //   height: 18,
                          // ),
                        ),
                        title: HeadingWidget(
                          title: e.fullname.toString(),
                        ),
                        subtitle: SubHeadingWidget(
                          title: e.mobile,
                          color: AppColors.black,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddDeliveryperson(
                                        deliverypersonId: e.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
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
                                )),
                            const SizedBox(width: 10), // Spacing between
                            GestureDetector(
                                onTap: () {
                                  deleteDeleverypersonById(e.id.toString());
                                },
                                child: Container(
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
                                )),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDeliveryperson(
                  // storeId: e.storeId,
                  ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
