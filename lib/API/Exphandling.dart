import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:medicalstore/API/JsonToDart.dart';

import '../Dashboard/DashboardScreen.dart';

class ExpHandling extends StatelessWidget {
  ExpHandling({Key? key}) : super(key: key);

  final dio = Dio();

  Future<List<Welcome>> fetchData() async {
    List<Welcome> data = [];

    try {
      var response = await dio.get('https://reqres.in/api/users?page=2');
      if (response.statusCode == 200) {
        data = (response.data['data'] as List)
            .map((model) => Welcome.fromJson(model))
            .toList();
      }
    } catch (error) {
      debugPrint('API Error: $error');
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
        centerTitle: true,
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
      body: FutureBuilder<List<Welcome>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occurred: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var person = snapshot.data![index];
                return ListTile(
                  onTap: () {
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
                                CircleAvatar(
                                  backgroundImage: NetworkImage(person.avatar),
                                  radius: 80,
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  person.firstName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  person.lastName,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  person.email,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'ID: ${person.id}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.avatar),
                    radius: 50,
                  ),
                  title: Text(
                    person.firstName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.lastName,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        person.email,
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'ID: ${person.id}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
