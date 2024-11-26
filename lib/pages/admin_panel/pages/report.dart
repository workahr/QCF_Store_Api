import 'package:flutter/material.dart';
import 'package:namstore/widgets/heading_widget.dart';
import 'package:namstore/widgets/sub_heading_widget.dart';

import '../../../constants/app_colors.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Map<String, String>> _reportData = [
    {'sno': '01', 'storeName': 'Grill chickeni..', 'date': '01-11-2024'},
    {'sno': '02', 'storeName': 'Grill chickeni..', 'date': '06-11-2024'},
    {'sno': '03', 'storeName': 'Grill chickeni..', 'date': '08-11-2024'},
  ];

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
      body: Padding(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
            SingleChildScrollView(
              scrollDirection:
                  Axis.vertical, // Allows horizontal scrolling if needed
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: DataTable(
                    dividerThickness: 0.2,
                    columnSpacing: 30,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'S.no',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Store Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: _reportData.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(data['sno']!)),
                        DataCell(Text(data['storeName']!,
                            style: TextStyle(
                                color: AppColors.red,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.red))),
                        DataCell(Text(data['date']!)),
                      ]);
                    }).toList(),
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
