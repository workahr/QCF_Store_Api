import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_assets.dart';
import 'maincontainer.dart';

class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage({super.key});

  @override
  State<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage> {


@override
void initState() {
    // TODO: implement initState

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 1), ()=> 
      //  Navigator.pushNamedAndRemoveUntil(
      //       context, '/landing', ModalRoute.withName('/landing'))

       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainContainer(
                              
                            ),
                          ),
                        )
    );

    super.initState();
  }

  @override
void dispose() {
    // TODO: implement dispose

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Container(
        width: double.infinity, 
        child: Image.asset(AppAssets.orderConfirmImg,
         fit: BoxFit.fill
         ),
         )
         );
  }
}