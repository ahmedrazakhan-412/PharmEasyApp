import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';

class LoginScreen extends StatelessWidget {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title:Center(
          child: Text('User Login'),
    ),
    ),
    body: Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 300,
                      width: 300,
                      child: Image.asset('assets/images/login.jpg')
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Userame/E-mail',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform user login logic

                // Simulate successful login
                bool isLoggedIn = true;

                if (isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    ),
  );
}
}
