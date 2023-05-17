import 'package:medicalstore/api/JsonToDart.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api extends StatelessWidget {
  const Api({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Center(
  child:   Column(
  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: (){
          fetchData();
          }, child: const Text('Fetch Data')),

    ],
      ),
)
  );
  }
}
// var response;
var dio = Dio();


Future<List<Welcome>> fetchData() async {
  List<Welcome>? data;

    var response = await dio.get('https://reqres.in/api/users?page=2');
    if(response.statusCode == 200){
      data = (response.data['data'] as List).map((model) => Welcome.fromJson(model)).toList();
    }
    return data!;
}