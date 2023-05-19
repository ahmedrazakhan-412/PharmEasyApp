import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:medicalstore/API/Exphandling.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'BillingModule.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpHandling()),
                );
              },
              child: Text('Billing Details'),
            ),
            SizedBox(height: 16), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BillingModule()),
                );
              },
              child: Text('Generate Bill'),
            ),
          ],
        ),
      ),
    );
  }
}

