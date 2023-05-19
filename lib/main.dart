
import 'package:flutter/material.dart';
import 'package:medicalstore/Login/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicalstore/firebase_options.dart';
import 'package:medicalstore/Login/UserProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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

// Padding(
// padding: const EdgeInsets.only(left: 16.0),
// child: Text(
// '$currentDate $currentTime',
// style: TextStyle(
// fontSize: 16.0,
// fontWeight: FontWeight.bold,
// color: Colors.white70,
// ),
// ),
// ),








