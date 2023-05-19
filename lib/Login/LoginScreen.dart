import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<List<Map<String, dynamic>>> retrieveUserRegistrationData() async {
    // Get the collection reference
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('EazyMed');

    // Query the collection and retrieve documents
    QuerySnapshot querySnapshot = await usersCollection.get();

    // Extract data from documents
    List<Map<String, dynamic>> userRegistrationData = [];

    querySnapshot.docs.forEach((document) {
      userRegistrationData.add(document.data() as Map<String, dynamic>);
    });

    return userRegistrationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('User Login'),
          ),
        ),
      ),
      body: Center(
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
                    height: 200,
                    width: 300,
                    child: Image.asset('assets/images/login.jpg'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Username/E-mail',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
              width: 300,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.25),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Perform user login logic
                String email = emailController.text; // Retrieve email from the text field
                String password = passwordController.text; // Retrieve password from the text field

                // Fetch user registration data from the database
                List<Map<String, dynamic>> userRegistrationData =
                    await retrieveUserRegistrationData();

                // Check if the email and password match
                bool isLoggedIn = userRegistrationData.any((userData) =>
                    userData['email'] == email &&
                    userData['password'] == password);

                if (isLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Login Failed'),
                        content: Text(
                          'Invalid email or password.',
                          style: TextStyle(color: Colors.red), // Set the text color to red
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
