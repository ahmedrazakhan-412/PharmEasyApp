import 'package:flutter/material.dart';

class PaymentGatewaysIntegration extends StatelessWidget {
  @override

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
    child:  Text('Payment Gateways Integration'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('PaymentGatewaysIntegration'),
      ),
    );
  }
}
