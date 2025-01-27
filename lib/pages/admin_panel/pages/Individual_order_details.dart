// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import 'package:namstore/pages/admin_panel/api_model/dashboard_orderlist_model.dart'
    as dashboard;
import 'package:namstore/pages/admin_panel/api_model/indivualorderpage_model.dart'
    as individual;

class Individualorderdetails extends StatefulWidget {
  List<dashboard.Item> items;
  String? invoiceNumber;
  int? item;
  String? date;
  String? username;
  String? usermobilenumber;
  String? useraddress;
  String? useraddressline2;
  String? userlandmark;
  String? usercity;
  String? userstate;
  String? userpincode;
  String? storename;
  String? storemobilenumber;
  String? storeaddress;
  String? pickup_date;
  String? delivered_date;
  String? storeaddressline2;
  String? storelandmark;
  String? storecity;
  String? storestate;
  String? storepincode;
  String? deliveryboyname;
  String? deliveryboymobilenumber;

  String? totalPrice;
  String? deliverycharge;
  String? plateformfee;
  String? gstfee;
  String? totalamount;
  String? paymentMethod;

  Individualorderdetails({
    Key? key,
    this.invoiceNumber,
    this.item,
    required this.items,
    this.username,
    this.usermobilenumber,
    this.useraddress,
    this.useraddressline2,
    this.userlandmark,
    this.usercity,
    this.userstate,
    this.userpincode,
    this.storename,
    this.storeaddress,
    this.pickup_date,
    this.delivered_date,
    this.storeaddressline2,
    this.storelandmark,
    this.storecity,
    this.storestate,
    this.storepincode,
    this.storemobilenumber,
    this.deliveryboyname,
    this.deliveryboymobilenumber,
    this.date,
    this.totalPrice,
    this.deliverycharge,
    this.gstfee,
    this.paymentMethod,
    this.plateformfee,
    this.totalamount,
  }) : super(key: key);

  @override
  State<Individualorderdetails> createState() => _IndividualorderdetailsState();
}

class _IndividualorderdetailsState extends State<Individualorderdetails> {
  final NamFoodApiService apiService = NamFoodApiService();
  String? totalPriceFormatted;
  @override
  void initState() {
    super.initState();
    double totalPrice = double.parse(widget.totalPrice!) -
        double.parse(widget.deliverycharge!); // Convert to double and calculate
    totalPriceFormatted = "$totalPrice";
    // getindividualorderdetails();
  }

  // //Individualorderdetails
  // List<OrderList> indivualorderpage = [];
  // List<OrderList> indivualorderpageAll = [];
  // bool isLoading1 = false;

  // Future getindividualorderdetails() async {
  //   setState(() {
  //     isLoading1 = true;
  //   });

  //   try {
  //     var result =
  //         await apiService.getallOrderdetailslist();
  //     final response = orderListmodelFromJson(result);
  //     if (response.status.toString() == 'SUCCESS') {
  //       setState(() {
  //         indivualorderpage = response.list;
  //         indivualorderpageAll = indivualorderpage;
  //         isLoading1 = false;
  //       });
  //     } else {
  //       setState(() {
  //         indivualorderpage = [];
  //         indivualorderpageAll = [];
  //         isLoading1 = false;
  //       });
  //       showInSnackBar(context, response.message.toString());
  //     }
  //   } catch (e) {
  //     setState(() {
  //       indivualorderpage = [];
  //       indivualorderpageAll = [];
  //       isLoading1 = false;
  //     });
  //     showInSnackBar(context, 'Error occurred: $e');
  //     print(e);
  //   }

  //   setState(() {});
  // }
  void _makePhoneCall(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double responsiveLineLength = screenHeight * 0.17;
    double responsiveLineLength1 = screenHeight * 0.24;
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
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(
                        title: "Order ID #${widget.invoiceNumber}",
                      ),
                      SubHeadingWidget(
                        title: "${widget.items.length} items | ${widget.date}",
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.red,
                                    ),
                                    child: const Center(
                                      child: Image(
                                        image: AssetImage(
                                          AppAssets.UserRounded,
                                        ),
                                        width: 18,
                                        height: 18,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashColor: AppColors.red,
                                    lineLength: responsiveLineLength,
                                    dashLength: 2,
                                    dashGapLength: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                // Ensures responsiveness
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.grey1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColors.grey1),
                                                  ),
                                                  child: Image.asset(
                                                    AppAssets.UserRounded,
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      HeadingWidget(
                                                        title: widget
                                                                    .username ==
                                                                null
                                                            ? ""
                                                            : widget.username,
                                                      ),
                                                      SubHeadingWidget(
                                                        title: widget
                                                            .usermobilenumber,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      _makePhoneCall(widget
                                                          .usermobilenumber
                                                          .toString());
                                                    },
                                                    child: Container(
                                                      // height: 24,
                                                      // width: 24,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        AppAssets.call_icon,
                                                        width: 30,
                                                        height: 30,
                                                        color: AppColors.white,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                                height:
                                                    10), // Add spacing for better alignment
                                            Wrap(
                                              children: [
                                                SubHeadingWidget(
                                                    title:
                                                        "${widget.useraddress != null ? widget.useraddress : ''}${widget.useraddress != null ? "," : ""}"
                                                        " ${widget.useraddressline2 != null ? widget.useraddressline2 : ''}${widget.useraddressline2 != null ? "," : ""}"
                                                        " ${widget.userlandmark != null ? widget.userlandmark : ''}${widget.userlandmark != null ? "," : ""}"
                                                        " ${widget.usercity != null ? widget.usercity : ''}${widget.usercity != null ? "," : ""}"
                                                        " ${widget.userstate != null ? widget.userstate : ''}${widget.userstate != null ? "," : ""}"
                                                        " ${widget.userpincode != null ? widget.userpincode : ''}${widget.userpincode != null ? "," : ""}"),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(children: [
                                              HeadingWidget(
                                                title: "Delivery Time: ",
                                              ),
                                              SubHeadingWidget(
                                                title: widget.delivered_date !=
                                                        null
                                                    ? DateFormat('hh:mm a').format(
                                                        DateTime.parse(widget
                                                            .delivered_date!) // Parse the string to DateTime
                                                        )
                                                    : "",
                                                color: AppColors.black,
                                              ),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.red),
                                    child: const Center(
                                      child: Image(
                                        image: AssetImage(
                                          AppAssets.shop,
                                        ),
                                        width: 18,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    dashColor: AppColors.red,
                                    lineLength: responsiveLineLength1,
                                    dashLength: 2,
                                    dashGapLength: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                // Ensures responsiveness
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Store details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.grey1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              children: [
                                                HeadingWidget(
                                                  title: widget.storename
                                                      .toString(),
                                                  fontSize: 18.0,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                SubHeadingWidget(
                                                  title: widget.storeaddress
                                                      .toString(),
                                                ),
                                                SizedBox(height: 10),
                                                Row(children: [
                                                  HeadingWidget(
                                                    title: "Pick up Time: ",
                                                  ),
                                                  SubHeadingWidget(
                                                    title: widget.pickup_date !=
                                                            null
                                                        ? DateFormat('hh:mm a').format(
                                                            DateTime.parse(widget
                                                                .pickup_date!) // Parse the string to DateTime
                                                            )
                                                        : "",
                                                    color: AppColors.black,
                                                  ),
                                                ])
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              height: 10,
                                              color: AppColors.grey1,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColors.grey1),
                                                  ),
                                                  child: Image.asset(
                                                    AppAssets.UserRounded,
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Wrap(children: [
                                                        HeadingWidget(
                                                          title: widget
                                                                      .storename ==
                                                                  null
                                                              ? ''
                                                              : widget.storename
                                                                  .toString(),
                                                        ),
                                                      ]),
                                                      SubHeadingWidget(
                                                        title: widget
                                                                    .storemobilenumber ==
                                                                null
                                                            ? ''
                                                            : widget
                                                                .storemobilenumber
                                                                .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      _makePhoneCall(widget
                                                          .storemobilenumber
                                                          .toString());
                                                    },
                                                    child: Container(
                                                      // height: 24,
                                                      // width: 24,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        AppAssets.call_icon,
                                                        width: 30,
                                                        height: 30,
                                                        color: AppColors.white,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            // Add spacing for better alignment
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.red,
                                    ),
                                    child: const Center(
                                      child: Image(
                                        image: AssetImage(
                                          AppAssets.delivery,
                                        ),
                                        width: 18,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                // Ensures responsiveness
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivery person details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.grey1),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColors.grey1),
                                                  ),
                                                  child: Image.asset(
                                                    AppAssets.UserRounded,
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      HeadingWidget(
                                                        title: widget
                                                                    .deliveryboyname ==
                                                                null
                                                            ? "Deliveryboy Name "
                                                            : widget
                                                                .deliveryboyname
                                                                .toString(),
                                                      ),
                                                      SubHeadingWidget(
                                                        title: widget
                                                                    .deliveryboymobilenumber ==
                                                                null
                                                            ? "Deliveryboy Mobile "
                                                            : widget
                                                                .deliveryboymobilenumber
                                                                .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      _makePhoneCall(widget
                                                          .deliveryboymobilenumber
                                                          .toString());
                                                    },
                                                    child: Container(
                                                      // height: 24,
                                                      // width: 24,
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.asset(
                                                        AppAssets.call_icon,
                                                        width: 30,
                                                        height: 30,
                                                        color: AppColors.white,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            // const SizedBox(
                                            //     height:
                                            //         10), // Add spacing for better alignment
                                            // Wrap(
                                            //   children: [
                                            //     SubHeadingWidget(
                                            //       title:
                                            //           widget.deliveryboyaddress ==
                                            //                   null
                                            //               ? "Deliveryboy Name "
                                            //               : widget
                                            //                   .deliveryboyaddress
                                            //                   .toString(),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          HeadingWidget(
                            title: 'Ordered details',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey1),
                            ),
                            child: ListView.builder(
                                shrinkWrap:
                                    true, // Prevents infinite height error
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable ListView scroll
                                itemCount: widget.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                              '${widget.items[index].productName}',
                                              style: TextStyle(fontSize: 16),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          HeadingWidget(
                                            title:
                                                '${widget.items[index].quantity} X ${widget.items[index].price}',
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      HeadingWidget(
                                        title:
                                            "₹${widget.items[index].totalPrice}",
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          HeadingWidget(
                            title: 'Bill & payment details',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grey1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'Item total',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title: "₹${totalPriceFormatted}  ",
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'Delivery Chargers',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title: "₹${widget.deliverycharge}",
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: AppColors.grey1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'Platform Fee',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title:
                                          "₹${widget.plateformfee != null ? widget.plateformfee : '0.00'}",
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'GST & Restaurant Charges',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title:
                                          "₹${widget.gstfee != null ? widget.gstfee : '0.00'}",
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  dashColor: AppColors.grey,
                                  dashLength: 4,
                                  dashGapLength: 4,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'Total Amount',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title:
                                          // "₹${widget.totalamount != null ? widget.totalamount : '0.00'}",
                                          "₹${widget.totalPrice != null ? widget.totalPrice : '0.00'}",
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  dashColor: AppColors.grey,
                                  dashLength: 4,
                                  dashGapLength: 4,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HeadingWidget(
                                      title: 'Payment method:',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    HeadingWidget(
                                      title: widget.paymentMethod,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}
