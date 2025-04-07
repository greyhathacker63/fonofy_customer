import 'package:flutter/material.dart';
import 'package:fonofy/LoginScreen.dart';
import 'package:fonofy/MyHttpOverride.dart';
import 'package:get/get.dart';
import 'MainScreen.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fonofy',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
