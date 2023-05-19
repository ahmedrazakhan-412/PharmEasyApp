import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegistrationData extends StatelessWidget {
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
          child: Text('User Registration Details'),
        ),
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
                  title: Text(
                    userData['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${userData['email']}'),
                      Text('Password: ${userData['password']}'),
                      Text('Phone: ${userData['phone']}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
