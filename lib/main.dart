
import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Store App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: DashboardScreen(),
    );
  }
}