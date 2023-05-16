import 'package:flutter/material.dart';

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
        Navigator.popUntil(context, (route) => route.isFirst);
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
