import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/svgiconButtonWidget.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../widgets/button1_widget.dart';

class MenuCategorie extends StatefulWidget {
  const MenuCategorie({super.key});

  @override
  State<MenuCategorie> createState() => _MenuCategorieState();
}

class _MenuCategorieState extends State<MenuCategorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Categories list',
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
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
              padding:
                  EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset(AppAssets.search_icon),
                  hintText: 'Search..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              )),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingWidget(
                                    title: 'Categories Name:',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  HeadingWidget(
                                    title: 'Indian Masala Food',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.00,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: AppColors.red)),
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
                                        border:
                                            Border.all(color: AppColors.red)),
                                    child: Icon(
                                      Icons.delete_outline,
                                      size: 24,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          HeadingWidget(
                            title: 'Description:',
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          HeadingWidget(
                            title:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.:',
                            fontWeight: FontWeight.w500,
                            fontSize: 18.00,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: SvgIconButtonWidget(
        title: 'Add New Categories',
        fontSize: 20.00,
        leadingIcon: Icon(
          Icons.add,
          size: 24,
        ),
        borderColor: (Colors.transparent),
        color: AppColors.red,
        onTap: () {},
      )),
    );
  }
}
