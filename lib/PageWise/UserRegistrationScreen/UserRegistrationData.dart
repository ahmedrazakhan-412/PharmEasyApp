import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicalstore/Dashboard/DashboardScreen.dart';

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
void _showUserInfoDialog(BuildContext context, Map<String, dynamic> userData) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Details',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildUserDetailRow('Name', userData['name'], isBold: true),
              _buildUserDetailRow('Date', userData['date'], isBold: false),
              _buildUserDetailRow('Email', userData['email'], isBold: false),
              _buildUserDetailRow('Phone', userData['phone'], isBold: false),
              _buildUserDetailRow('Password', userData['password'], isBold: false),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
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

Widget _buildUserDetailRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('User Registration Details'),
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
                // Sort user registration data based on the date in ascending order
                userRegistrationData.sort((a, b) => a['date'].compareTo(b['date']));

                // Display user registration data
                Map<String, dynamic> userData = userRegistrationData[index];
                final seriesNumber = index + 1;

                return ListTile(
                  onTap: () {
                    _showUserInfoDialog(context, userData);
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal[600],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$seriesNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
