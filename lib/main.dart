import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plot_frontend/auth/login.dart';

void main() {
  runApp(GetMaterialApp(home:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Plot',
      theme: ThemeData(
        fontFamily:"Product Sans",
      
        primarySwatch: Colors.blue,
      ),
      home: Login()
    );
  }
}

