// import 'package:flutter/material.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:namstore/widgets/heading_widget.dart';
// import 'package:namstore/widgets/sub_heading_widget.dart';

// import '../../../constants/constants.dart';
// import '../../../services/comFuncService.dart';
// import '../../../services/nam_food_api_service.dart';
// import '../api_model/dashboard_orderlist_model.dart';
// import '../api_model/indivualorderpage_model.dart';

// class Individualorderdetails extends StatefulWidget {
//   const Individualorderdetails({super.key});

//   @override
//   State<Individualorderdetails> createState() => _IndividualorderdetailsState();
// }

// class _IndividualorderdetailsState extends State<Individualorderdetails> {
//   final NamFoodApiService apiService = NamFoodApiService();

//   @override
//   void initState() {
//     super.initState();

//     getindividualorderdetails();
//   }

//   //Individualorderdetails
//   List<OrderList> indivualorderpage = [];
//   List<OrderList> indivualorderpageAll = [];
//   bool isLoading1 = false;

//   Future getindividualorderdetails() async {
//     setState(() {
//       isLoading1 = true;
//     });

//     try {
//       var result = await apiService.getallOrderdetailslist();
//       final response = orderListmodelFromJson(result);
//       if (response.status.toString() == 'SUCCESS') {
//         setState(() {
//           indivualorderpage = response.list;
//           indivualorderpageAll = indivualorderpage;
//           isLoading1 = false;
//         });
//       } else {
//         setState(() {
//           indivualorderpage = [];
//           indivualorderpageAll = [];
//           isLoading1 = false;
//         });
//         showInSnackBar(context, response.message.toString());
//       }
//     } catch (e) {
//       setState(() {
//         indivualorderpage = [];
//         indivualorderpageAll = [];
//         isLoading1 = false;
//       });
//       showInSnackBar(context, 'Error occurred: $e');
//       print(e);
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double responsiveLineLength = screenHeight * 0.17;
//     double responsiveLineLength1 = screenHeight * 0.24;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100.0,
//         title: const Text(
//           'Back',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.red,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20.0),
//             bottomRight: Radius.circular(20.0),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: ListView.builder(
//           itemCount: indivualorderpage.length,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) {
//             final e = indivualorderpage[index];

//             return Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     HeadingWidget(
//                       title: "Order ID #${e.invoiceNumber}",
//                     ),
//                     SubHeadingWidget(
//                       title: "${e.items.length} items | ${e.createdDate}",
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 Container(
//                                   width: 30,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColors.red,
//                                   ),
//                                   child: const Center(
//                                     child: Image(
//                                       image: AssetImage(
//                                         AppAssets.UserRounded,
//                                       ),
//                                       width: 18,
//                                       height: 18,
//                                       color: AppColors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 DottedLine(
//                                   direction: Axis.vertical,
//                                   dashColor: AppColors.red,
//                                   lineLength: responsiveLineLength,
//                                   dashLength: 2,
//                                   dashGapLength: 2,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               // Ensures responsiveness
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'User details',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 20.0),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border:
//                                             Border.all(color: AppColors.grey1),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 height: 45,
//                                                 width: 45,
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   border: Border.all(
//                                                       color: AppColors.grey1),
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.UserRounded,
//                                                   width: 18,
//                                                   height: 18,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     HeadingWidget(
//                                                       title: e.customerAddress
//                                                           .pincode,
//                                                     ),
//                                                     SubHeadingWidget(
//                                                       title: e.customerAddress
//                                                           .pincode,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // height: 24,
//                                                 // width: 24,
//                                                 padding: EdgeInsets.all(6),
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors.red,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.call_icon,
//                                                   width: 30,
//                                                   height: 30,
//                                                   color: AppColors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                               height:
//                                                   10), // Add spacing for better alignment
//                                           Wrap(
//                                             children: [
//                                               SubHeadingWidget(
//                                                 title: e.customerAddress.address
//                                                     .toString(),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 Container(
//                                   width: 30,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AppColors.red),
//                                   child: const Center(
//                                     child: Image(
//                                       image: AssetImage(
//                                         AppAssets.shop,
//                                       ),
//                                       width: 18,
//                                       height: 18,
//                                     ),
//                                   ),
//                                 ),
//                                 DottedLine(
//                                   direction: Axis.vertical,
//                                   dashColor: AppColors.red,
//                                   lineLength: responsiveLineLength1,
//                                   dashLength: 2,
//                                   dashGapLength: 2,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               // Ensures responsiveness
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Store details',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 20.0),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border:
//                                             Border.all(color: AppColors.grey1),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Wrap(
//                                             children: [
//                                               HeadingWidget(
//                                                 title: e.storeAddress.name
//                                                     .toString(),
//                                                 fontSize: 18.0,
//                                               ),
//                                               SizedBox(
//                                                 height: 30,
//                                               ),
//                                               SubHeadingWidget(
//                                                 title: e.storeAddress.address
//                                                     .toString(),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Divider(
//                                             height: 10,
//                                             color: AppColors.grey1,
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 height: 45,
//                                                 width: 45,
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   border: Border.all(
//                                                       color: AppColors.grey1),
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.UserRounded,
//                                                   width: 18,
//                                                   height: 18,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     HeadingWidget(
//                                                       title: e.storeAddress.name
//                                                           .toString(),
//                                                     ),
//                                                     SubHeadingWidget(
//                                                       title: e
//                                                           .storeAddress.mobile
//                                                           .toString(),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // height: 24,
//                                                 // width: 24,
//                                                 padding: EdgeInsets.all(6),
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors.red,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.call_icon,
//                                                   width: 30,
//                                                   height: 30,
//                                                   color: AppColors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           // Add spacing for better alignment
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               children: [
//                                 Container(
//                                   width: 30,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColors.red,
//                                   ),
//                                   child: const Center(
//                                     child: Image(
//                                       image: AssetImage(
//                                         AppAssets.delivery,
//                                       ),
//                                       width: 18,
//                                       height: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               // Ensures responsiveness
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Delivery person details',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 20.0),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border:
//                                             Border.all(color: AppColors.grey1),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 height: 45,
//                                                 width: 45,
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   border: Border.all(
//                                                       color: AppColors.grey1),
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.UserRounded,
//                                                   width: 18,
//                                                   height: 18,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     HeadingWidget(
//                                                       title: e.deliveryBoyName
//                                                           .toString(),
//                                                     ),
//                                                     SubHeadingWidget(
//                                                       title: e.deliveryBoyMobile
//                                                           .toString(),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // height: 24,
//                                                 // width: 24,
//                                                 padding: EdgeInsets.all(6),
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors.red,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: Image.asset(
//                                                   AppAssets.call_icon,
//                                                   width: 30,
//                                                   height: 30,
//                                                   color: AppColors.white,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                               height:
//                                                   10), // Add spacing for better alignment
//                                           Wrap(
//                                             children: [
//                                               SubHeadingWidget(
//                                                 title: e.deliveryBoyName
//                                                     .toString(),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         HeadingWidget(
//                           title: 'Ordered details',
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 16, horizontal: 16),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: AppColors.grey1),
//                           ),
//                           child: Column(
//                             children: [
//                               ...e.items.map((item) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         HeadingWidget(
//                                           title: item.productName,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         HeadingWidget(
//                                           title:
//                                               '${item.quantity} X ${item.price}',
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                       ],
//                                     ),
//                                     HeadingWidget(
//                                       title: "₹${item.totalPrice}",
//                                       fontWeight: FontWeight.w500,
//                                     )
//                                   ],
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         HeadingWidget(
//                           title: 'Bill & payment details',
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         SizedBox(
//                           height: 12,
//                         ),
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 16, horizontal: 16),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: AppColors.grey1),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'Item total',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: "₹${e.totalPrice}",
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'Delivery Chargers',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: "₹${e.totalPrice}",
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 color: AppColors.grey1,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'Platform Fee',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: "₹${e.totalPrice}",
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'GST & Restaurant Charges',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: "₹${e.totalPrice}",
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               DottedLine(
//                                 direction: Axis.horizontal,
//                                 dashColor: AppColors.grey,
//                                 dashLength: 4,
//                                 dashGapLength: 4,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'Total Amount',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: "₹${e.totalPrice}",
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               DottedLine(
//                                 direction: Axis.horizontal,
//                                 dashColor: AppColors.grey,
//                                 dashLength: 4,
//                                 dashGapLength: 4,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   HeadingWidget(
//                                     title: 'Payment method:',
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                   HeadingWidget(
//                                     title: e.paymentMethod,
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
