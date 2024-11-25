
Future getDashboardOrderJsonData() async {
  var result = {
    "status": "SUCCESS",
    "list": [
      {
        "id": 1,
        "order_id": "#1234567",
        "time": "12.40",
        "items": "3",
        "dishes": [
           {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": "Chicken 65", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "Barani",
        "order_status":"Preparing",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },
      {
        "id": 2,
        "order_id": "#456785",
        "time": "12.40",
        "items": "3",
        "dishes": [
           {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": "Soup", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "kumar",
        "order_status":"Preparing",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

        {
        "id": 3,
        "order_id": "#4567851",
        "time": "12.40",
        "items": "3",
        "dishes": [
          {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": "Chicken Soup", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "Beskey",
        "order_status":"Ready",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

       {
        "id": 4,
        "order_id": "#4567852",
        "time": "12.40",
        "items": "3",
        "dishes": [
         {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": "Mutton Biriyani", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "Barani",
        "order_status":"Ready",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

       {
        "id": 5,
        "order_id": "#4567853",
        "time": "12.40",
        "items": "3",
        "dishes": [
         {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": " Biriyani", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "Prasath",
        "order_status":"Pending",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      },

       {
        "id": 6,
        "order_id": "#4567854",
        "time": "12.40",
        "items": "3",
        "dishes": [
          {
            "name": " Biriyani", 
            "quantity": 3, 
            "amount": "200"
            },
          {
            "name": " Kabab", 
            "quantity": 4, 
            "amount": "200"
            },
          {
            "name": " Biriyani", 
            "quantity": 5,
            "amount": "200"
            }
        ],
        "delivery_person": "sulai",
        "order_status":"Pending",
        "status": 1,
        "active": 1,
        "created_by": 101,
        "created_date": "2024-11-12 10:40:29",
        "updated_by": 102,
        "updated_date": "2024-11-12 10:40:29"
      }
    ],
    "code": "206",
    "message": "Listed Successfully."
  };

  return result;
}
