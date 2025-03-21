import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/app_colors.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../api_model/delete_userdetails_model.dart';
import '../api_model/prime_location_list_model.dart';
import '../api_model/registered_user_list.dart';

class RegisteredUserList extends StatefulWidget {
  RegisteredUserList({super.key});

  @override
  State<RegisteredUserList> createState() => _RegisteredUserListState();
}

class _RegisteredUserListState extends State<RegisteredUserList> {
  final NamFoodApiService apiService = NamFoodApiService();
  final GlobalKey<FormState> storeForm = GlobalKey<FormState>();

  List<RegisteredUser>? RegisteredListData;
  List<RegisteredUser>? RegisteredListDataAll;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getRegistereduserList();
  }

  Future<void> getRegistereduserList() async {
    setState(() {
      isLoading = true;
    });
    await apiService.getBearerToken();
    var result = await apiService.getregistereduserList();
    var response = registeredListmodelFromJson(result);
    if (response.status.toString() == 'SUCCESS') {
      setState(() {
        RegisteredListData = response.list;
        RegisteredListDataAll = RegisteredListData;
        isLoading = false;
      });
    } else {
      setState(() {
        RegisteredListData = [];
        RegisteredListDataAll = [];
        isLoading = false;
      });
      showInSnackBar(context, response.message.toString());
    }
  }



  // Delete User 
  Future deleteuser(String id) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "id": id,
    };
    print("delete $postData");

    var result = await apiService.deleteuser(postData);
    DeleteUserdetailsModel response = deleteUserdetailsModelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      setState(() {
        getRegistereduserList();
      });
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

//Shimmer
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
                height: 800,
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
          iconTheme: IconThemeData(
            color: Colors.white, // Set the color of the leading icon
          ),
          title: const Text(
            'Registered Users',
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
            : SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.all(15),
                child: RegisteredListData != null &&
                        RegisteredListData!.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: DataTable(
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                              verticalInside: BorderSide.none,
                            ),
                            columnSpacing: 18,
                            horizontalMargin: 8,
                            columns: [
                              DataColumn(label: Text('S.No')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('User Name')),
                              DataColumn(label: Text('Mobile')),
                               DataColumn(label: Text('Delete User')),
                            ],
                            rows: List<DataRow>.generate(
                              RegisteredListData!.length,
                              (index) {
                                final element = RegisteredListData![index];
                                final RegisteredId =
                                    element.id?.toString() ?? '';

                                final Registereduser =
                                    element.fullname != null &&
                                            element.fullname!.isNotEmpty
                                        ? element.fullname![0].toUpperCase() +
                                            element.fullname!.substring(1)
                                        : "-";
                                final mobile = element.mobile ?? ' ';
                                String formattedDate =
                                    element.createdDate != null
                                        ? DateFormat('dd-MM-yyyy')
                                            .format(element.createdDate!)
                                        : '';
                                final isEven = index % 2 == 0;

                                return DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) =>
                                        isEven ? Colors.grey.shade100 : null,
                                  ),
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(formattedDate)),
                                    DataCell(Text(Registereduser)),
                                    DataCell(Text(mobile)),
                                    DataCell(
                                          TextButton.icon(
                                            onPressed: () {
                                              if (RegisteredId.isNotEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(
                                                        'Confirm Deletion',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    content: Text(
                                                        'Do you really want to delete this User Details?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          deleteuser(
                                                              RegisteredId);
                                                        },
                                                        child: Text('Confirm',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            label: Text('Delete'),
                                          ),
                                        ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ))
                    : Center(
                        child: Text(
                          'No Registered User found.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
              )));
  }
}
