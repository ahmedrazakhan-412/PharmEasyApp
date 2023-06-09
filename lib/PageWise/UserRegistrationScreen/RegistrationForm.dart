import 'package:flutter/material.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';
import 'InputDecoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'InputDecoration.dart' show buildInputDecoration;


class RegistrationForm extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}
class _FormPageState extends State<RegistrationForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

Future<void> storeUserRegistrationData() async {
  // Get the collection reference
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('EazyMed');

  // Create a new document with the user registration data and current date/time
  await usersCollection.add({
    'name': nameController.text,
    'email': emailController.text,
    'phone': phoneController.text,
    'password': passwordController.text,
    'confirm password': confirmPasswordController.text,
    'date': DateTime.now().toString(),
  });
}
  void _showCongratulatoryDialog(String? name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Congratulations!\n$name',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Registration Successful.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('User Registration'),
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
        child: Container(
          width: 400,
          height: 800,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.person, "Full Name"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                       onSaved: (String? value) {
  nameController.text = value ?? '';
},

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.email, "Email"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                       onSaved: (String? value) {
  emailController.text = value ?? '';
},

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: buildInputDecoration(Icons.phone, "Phone No"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone no ';
                          }
                          return null;
                        },
                       onSaved: (String? value) {
  phoneController.text = value ?? '';
},

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.lock, "Password"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.lock, "Confirm Password"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          if (passwordController.text != value) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState?.validate() ?? false) {
                            _formkey.currentState?.save();
                            print("Successful");
                            storeUserRegistrationData(); // Store user data in the database
                            _showCongratulatoryDialog(nameController.text);
                          } else {
                            print("Unsuccessful");
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
