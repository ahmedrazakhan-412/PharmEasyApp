
import 'package:flutter/material.dart';
import 'package:medicalstore/Login/LoginScreen.dart';

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
      home: LoginScreen(),
    );
  }
}

// Git Hub Token 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