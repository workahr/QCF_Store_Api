import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/sub_heading_widget.dart';
import '../../maincontainer.dart';
import '../api_model/add_qty_model.dart';
import '../api_model/address_listforuser_orderedit.dart';
import '../api_model/create_order_model.dart';
import '../api_model/dashboard_orderlist_model.dart' as dashboard;
import '../api_model/edit_order_list_model.dart';
import '../api_model/editorder_admin_model.dart';

class Editorder extends StatefulWidget {
  String? invoiceNumber;
  List<dashboard.Item> items;

  Editorder({
    super.key,
    this.invoiceNumber,
    required this.items,
  });

  @override
  _EditorderState createState() => _EditorderState();
}

class _EditorderState extends State<Editorder> {
  final NamFoodApiService apiService = NamFoodApiService();

  final TextEditingController quantitycontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Future admindeleteCart(id) async {
    final dialogBoxResult = await showAlertDialogInfo(
        context: context,
        title: 'Are you sure?',
        msg: 'You want to delete this data',
        status: 'danger',
        okBtn: false);
    if (dialogBoxResult == 'OK') {
      Map<String, dynamic> postData = {
        "order_item_id": id,
      };

      var result = await apiService.admindeleteitem(postData);
      var response = addQuantityModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        showInSnackBar(context, response.message.toString());
        setState(() {
          setState(() {
            widget.items.removeWhere((item) => item.orderItemId == id);
          });
        });
      } else {
        showInSnackBar(context, response.message.toString());
      }
      setState(() {});
    }
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
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 63,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 103,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 123,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(13), // Add border radius
              child: Container(
                width: double.infinity,
                height: 63,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future AdmineditOrderbyid(id, newValue) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "order_item_id": id,
      "quantity": newValue,
    };
    print("edit order $postData");
    var result = await apiService.admineditorder(postData);

    AdmineditorderModel response = admineditorderModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      // showInSnackBar(context, response.message.toString());
      showInSnackBar(context, "Order Updated Successfully");
      setState(() {});
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  late String newqty;


   Future<bool> _onWillPop() async {
  Navigator.pop(context, true); // Notify the parent screen
  return false; // Block default back navigation
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          appBar: AppBar(
            title: HeadingWidget(
              title: "Edit Order",
              fontSize: 20.0,
            ),
            backgroundColor: AppColors.lightGrey3,
            foregroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          TextEditingController quantityController =
                              TextEditingController(
                            text:
                                widget.items[index].quantity?.toString() ?? '0',
                          );
                          final FocusNode quantityFocusNode = FocusNode();
                          void updateQuantity(String newValue) {
                            int? newQty = int.tryParse(newValue);
                            if (newQty != null && newQty >= 0) {
                              setState(() {
                                widget.items[index].quantity = newQty;

                                double price = double.tryParse(
                                        widget.items[index].price ?? "0") ??
                                    0.0;
                                widget.items[index].totalPrice =
                                    (newQty * price).toStringAsFixed(2);

                                // Print updated values
                                print('Updated Quantity: $newQty');
                                print(
                                    'Total Price: ${widget.items[index].totalPrice}');
                              });
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Image placeholder
                                    widget.items[index].imageUrl == null
                                        ? Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.grey,
                                            child: Icon(Icons.image),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              AppConstants.imgBaseUrl +
                                                  widget.items[index].imageUrl
                                                      .toString(),
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            )),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                widget.items[index].productName
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Quantity Input
                                              Row(
                                                children: [
                                                  Text(
                                                    '₹${widget.items[index].price}',
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    '  X  ',
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  Container(
                                                    width: 70,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      focusNode:
                                                          quantityFocusNode,
                                                      controller:
                                                          quantityController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor: Colors.blue,
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (newValue) {
                                                        updateQuantity(
                                                            newValue);
                                                        newqty = newValue;
                                                        print(
                                                            "newqty  $newqty");
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          vertical: 4,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10),

                                              Text(
                                                'Total: ₹${widget.items[index].totalPrice ?? "0.00"}',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    admindeleteCart(widget
                                                        .items[index]
                                                        .orderItemId);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .delete_outlined,
                                                            color:
                                                                AppColors.red,
                                                          ),
                                                          SizedBox(height: 3),
                                                          HeadingWidget(
                                                            title: 'Remove',
                                                            color:
                                                                AppColors.red,
                                                            fontSize: 13.0,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        height: 1,
                                                        width: 70,
                                                        color: AppColors.red,
                                                      ),
                                                    ],
                                                  )),
                                              GestureDetector(
                                                  onTap: () {
                                                    AdmineditOrderbyid(
                                                        widget.items[index]
                                                            .orderItemId,
                                                        newqty);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.update,
                                                            color:
                                                                AppColors.red,
                                                          ),
                                                          SizedBox(height: 3),
                                                          HeadingWidget(
                                                            title: 'Update',
                                                            color:
                                                                AppColors.red,
                                                            fontSize: 13.0,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      Container(
                                                        height: 1,
                                                        width: 70,
                                                        color: AppColors.red,
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(height: 16),
                  // HeadingWidget(
                  //   title: "Bill Details",
                  // ),
                  // SizedBox(height: 16),
                  // Container(
                  //   padding: EdgeInsets.all(16.0),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     border: Border.all(color: Colors.grey.shade300),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SubHeadingWidget(
                  //               title: "Item total", color: AppColors.black),
                  //           SubHeadingWidget(
                  //               title: "",
                  //               //  "₹${totalDiscountPrice.toStringAsFixed(2)}",
                  //               color: AppColors.black),
                  //         ],
                  //       ),
                  //       SizedBox(height: 8),
                  //       Divider(
                  //         color: Colors.grey,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           HeadingWidget(title: "To Pay", fontSize: 16.0),
                  //           HeadingWidget(
                  //               title:
                  //                   "", // "₹${finalTotal.toStringAsFixed(2)}",
                  //               fontSize: 16.0),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          // bottomNavigationBar: isLoading
          //     ? SizedBox(
          //         height: 1,
          //       )
          //     : cartdetails != "FAILED"
          //         ? BottomAppBar(
          //             height: 80.0,
          //             elevation: 0,
          //             color: AppColors.light,
          //             child: SafeArea(
          //                 child: Padding(
          //               padding: EdgeInsets.all(5.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       SubHeadingWidget(
          //                         title: "Total Amount",
          //                         color: AppColors.black,
          //                       ),
          //                       HeadingWidget(
          //                         title: '₹${finalTotal.toString()}',
          //                         color: AppColors.red,
          //                         fontSize: 18.0,
          //                       ),
          //                     ],
          //                   ),
          //                   ElevatedButton(
          //                     onPressed: () {
          //                       if (cartdetails == "FAILED") {
          //                         showInSnackBar(context,
          //                             "Please Add Any One of the Item ");
          //                       } else if (selectedValue == '' ||
          //                           selectedValue == null ||
          //                           selectedValue == "cash_on_delivery") {
          //                         showInSnackBar(context,
          //                             "Select the Payment Method Field ");
          //                         print("Select the Payment Method Field ");
          //                       } else if (selectedaddressid == '' ||
          //                           selectedaddressid == null) {
          //                         showInSnackBar(
          //                             context, "Select the Address Field ");
          //                       } else {
          //                         // if (cartdetails == "FAILED") {
          //                         //   showInSnackBar(
          //                         //       context, "Please Add Any One of the Item ");
          //                         //   // createorder();
          //                         // }
          //                         //  else {
          //                         createorder();
          //                       }
          //                     },
          //                     child: Padding(
          //                         padding: EdgeInsets.symmetric(
          //                             horizontal: 10, vertical: 12),
          //                         child: Row(
          //                           children: [
          //                             SubHeadingWidget(
          //                               title: "Update Order",
          //                               color: Colors.white,
          //                             ),
          //                             Icon(Icons.arrow_forward)
          //                           ],
          //                         )),
          //                     style: ElevatedButton.styleFrom(
          //                       backgroundColor: AppColors.red,
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(8),
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             )))
          //         : null
        ));
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 25,
        width: 30,
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE23744)),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        // Container(
        //   width: 27,
        //   height: 27,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        child: Icon(icon, size: 15, color: Color(0xFFE23744)),
      ),
    );
  }

  Widget _buildPaymentMethod(Image image, String method) {
    return ListTile(
      leading: image,
      title: Text(method),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
