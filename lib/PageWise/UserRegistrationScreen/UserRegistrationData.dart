
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserRegistrationData extends StatelessWidget {

  Future<List<Map<String, dynamic>>> retrieveUserRegistrationData() async {
  // Get the collection reference
  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  // Query the collection and retrieve documents
  QuerySnapshot querySnapshot = await usersCollection.get();

  // Extract data from documents
  List<Map<String, dynamic>> userRegistrationData = querySnapshot.docs
      .map((document) => document.data() as Map<String, dynamic>)
      .toList();

  return userRegistrationData;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Registration Data'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: retrieveUserRegistrationData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No user registration data found.'));
          } else {
            // Data is available, display it in a ListView
            List<Map<String, dynamic>> userRegistrationData = snapshot.data!;
            return ListView.builder(
              itemCount: userRegistrationData.length,
              itemBuilder: (context, index) {
                // Display user registration data
                Map<String, dynamic> userData = userRegistrationData[index];
                return ListTile(
                  title: Text(userData['name']),
                  subtitle: Text(userData['email']),
                  // Add more fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
