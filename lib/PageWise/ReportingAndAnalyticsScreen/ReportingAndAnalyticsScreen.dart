import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'package:medicalstore/PageWise/CustomerManagementScreen/RegistrationForm.dart';

import 'DailySaleRecords.dart';

class ReportingAndAnalyticsScreen extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
    child: Text('Reporting And Analytics Screen'),
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
                  MaterialPageRoute(builder: (context) => InvoiceListPage()),
                );
              },
              child: Text('Report Details'),
            ),
            SizedBox(height: 16), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationForm()),
                );
              },
              child: Text('Add Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
    