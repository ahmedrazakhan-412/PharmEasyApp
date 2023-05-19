import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';

class AdministrationAndSecurityScreen extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: Center(
    child: Text('Administration And Security Screen'),
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
        child: Text('Administration And Security Screen'),
      ),
    );
  }
}
