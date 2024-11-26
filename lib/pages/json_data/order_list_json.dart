Future getorderlistPageJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "orderid": "233456789",
        "ordereditem": "3",
        "qty1": "2",
        "qty2": "3",
        "dish1": "Chicken Briyani",
        "dish2": "Mutton Briyani",
        "price1": "300.00",
        "price2": "500.00",
        "totalamount": "800.00",
        "paymenttype": "Cash on delivery",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": null
      },
      {
        "id": 2,
        "orderid": "2334578555",
        "ordereditem": "3",
        "qty1": "2",
        "qty2": "3",
        "dish1": "Chicken Briyani",
        "dish2": "Mutton Briyani",
        "price1": "300.00",
        "price2": "500.00",
        "totalamount": "800.00",
        "paymenttype": "Cash on delivery",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": null
      }
    ],
    "code": "206",
    "message": "Listed Succesfully."
  };

  return result;
}
