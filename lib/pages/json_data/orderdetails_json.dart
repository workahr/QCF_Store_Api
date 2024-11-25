Future getorderdetailsPageJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "dishtype": "Non-Veg",
        "dishname": "Chicken Briyani",
        "qty": '2',
        "amount": "250.00",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null
      },
      {
        "id": 2,
        "dishtype": "Non-Veg",
        "dishname": "Chicken Kebab",
        "qty": '3',
        "amount": "200.00",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null
      },
    ],
    "code": "206",
    "message": "Listed Succesfully."
  };

  return result;
}
