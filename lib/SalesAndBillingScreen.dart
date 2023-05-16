import 'package:flutter/material.dart';

class SalesAndBillingScreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(
    child:  Text('Sales And Billing Screen'),
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
        child: Text('Sales And Billing Screen'),
      ),
    );
  }
}
