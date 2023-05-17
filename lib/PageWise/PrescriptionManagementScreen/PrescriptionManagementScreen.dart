import 'package:flutter/material.dart';

class PrescriptionManagementScreen extends StatelessWidget {
  @override

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
    child: Text('Prescription Management Screen'),
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
        child: Text('Prescription Management Screen'),
      ),
    );
  }
}
