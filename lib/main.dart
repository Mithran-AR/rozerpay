import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  late Razorpay _razorpay;


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');

  }
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Razorpay Sample App'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(onPressed: (){

                    openCheckout(100,"zoople","sreejith discription","8787878770","zoople@gmail.com");
                  }, child: Text('Open'))
                ])),
      ),
    );
  }



  void openCheckout(int amt,String shopname,String discription,String no,String email) async {
    var options = {
      //dynamic key of clint please replace key with ur key
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      //amt in pisa
      'amount': amt*100,
      'name': '${shopname}',
      'description': '${discription}',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '$no', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }

  }


}