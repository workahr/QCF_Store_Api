import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/paymentreport_model.dart';
import '../models/report_model.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    getallstorepaymentlist();
  }

  List<PaymentList> reportlistpage = [];
  List<PaymentList> reportlistpageAll = [];
  bool isLoading = false;

  Future getallstorepaymentlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getallstorepaymentlist();
      var response = paymentReportmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          reportlistpage = response.list;
          reportlistpageAll = reportlistpage;
          isLoading = false;
        });
      } else {
        setState(() {
          reportlistpage = [];
          reportlistpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        reportlistpage = [];
        reportlistpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  Widget _buildShimmerPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(13), // Add border radius
                child: Container(
                  width: 250,
                  height: 53,
                  color: Colors.white,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(13), // Add border radius
                child: Container(
                  width: 80,
                  height: 53,
                  color: Colors.white,
                ),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 583,
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
        automaticallyImplyLeading: false,
        toolbarHeight: 100.0,
        title: const Text(
          'Payment',
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildShimmerPlaceholder();
              },
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingWidget(
                        title: 'Report',
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.red,
                        ),
                        child: SubHeadingWidget(
                          title: 'Print',
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ListView.builder(
                          itemCount: reportlistpage.length +
                              1, // +1 for the header row
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // Header Row
                              return Container(
                                // color: AppColors.grey.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'S.no',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'Store Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Method',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'Amount',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              // Data Rows
                              final e =
                                  reportlistpage[index - 1]; // Offset by 1
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(e.date);
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: AppColors.grey.withOpacity(0.5),
                                    thickness: 0.5,
                                    height: 1, // Adjust spacing around divider
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(e.id.toString()),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            e.storeName.toString(),
                                            style: TextStyle(
                                              color: AppColors.red,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: AppColors.red,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(formattedDate),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child:
                                              Text(e.paymentMethod.toString()),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(e.amount.toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
