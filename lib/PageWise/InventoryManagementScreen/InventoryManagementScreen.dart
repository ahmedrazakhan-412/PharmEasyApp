import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatelessWidget {
  @override

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
    child: Text('Inventory Management Screen'),
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
        child: Text('Inventory Management Screen'),
      ),
    );
  }

}
