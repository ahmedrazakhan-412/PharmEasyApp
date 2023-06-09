import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalstore/Login/UserProvider.dart';
import 'package:provider/provider.dart';

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
    // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login.jpg"),
            fit:BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('User Login',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                width: 300,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',hintStyle: TextStyle(color: Colors.white),

                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    prefixIcon: Icon(Icons.person,color: Colors.white54),
                    enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,
                            width: 1.25,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color:Colors.white )),
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
                    hintText: 'Password',hintStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    prefixIcon: Icon(Icons.lock,color: Colors.white54),
                    enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,
                            width: 1.25,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color:Colors.white )),
                  ),
                  obscureText: true,style: TextStyle(color: Colors.white), ),
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
  String username = userRegistrationData
          .firstWhere((userData) =>
            userData['email'] == email && userData['password'] == password)
          ['name'];

  String loginTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Provider.of<UserProvider>(context, listen: false).setUserName(username);
  // ignore: use_build_context_synchronously
  Provider.of<UserProvider>(context, listen: false).setLoginTime(loginTime);

  Navigator.push(
    context,
    MaterialPageRoute(
          builder: (context) => DashboardScreen(),
    ),
  );
}

 else {
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
      ),
    );
  }
}
