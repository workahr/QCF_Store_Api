Future getindividualorderdetailsJsonData() async {
  var result = {
    "status": "SUCCESS",
    "code": "200",
    "message": "Listed Successfully",
    "list": [
      {
        "id": 1,
        "orderid": "0012345",
        "items": "12",
        "orderstatus": "On Delivery",
        "date": "20-Oct-2024",
        "userdetails": [
          {
            "username": "Vaiyapuri",
            "usermobilenumber": "98545444454",
            "useraddress":
                "No 37 Paranjothi Nagar Thalakudi, vallar Nagar Trichy-620005",
          }
        ],
        "storedetails": [
          {
            "storename": "Grill Chicken Arabian Restaurant",
            "storeownername": "Vaiyapuri",
            "storemobilenumber": "98545444454",
            "storeaddress":
                "No 37 Paranjothi Nagar Thalakudi, vallar Nagar Trichy-620005",
          }
        ],
        "deliverydetails": [
          {
            "deliverypersonname": "Vaiyapuri",
            "deliverypersonmobilenumber": "98545444454",
            "deliveryaddress":
                "No 37 Paranjothi Nagar Thalakudi, vallar Nagar Trichy-620005",
          }
        ],
        "orderdetails": [
          {
            "dishname": "Chicken Biryani",
            "dishqty": "2",
            "singleprice": "150.00",
          },
          {
            "dishname": "Chicken Biryani",
            "dishqty": "2",
            "singleprice": "150.00",
          }
        ],
        "paymentdetails": [
          {
            "itemtotal": "1,350.00",
            "deliverychargers": "350.00",
            "platformfee": "350.00",
            "restaurantcharges": "350.00",
            "totalamount": "350.00",
            "paymentmethod": "Cash on delivery",
          }
        ],
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": null,
        "updated_by": 102,
        "updated_date": null,
      },
    ]
  };

  return result;
}
