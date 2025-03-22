import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MainScreen.dart';

void main() {
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
      //   initialRoute: '/', // Default route
      //   routes: {
      //     '/': (context) => const DeviceDetailScreen2(),
      //     '/main': (context) => const MainScreen(),
      //     '/register': (context) => const RegisterScreen(),
      //     '/email-login': (context) => const EmailLoginScreen(), // Added email login route
      //     '/deviceDetails': (context) => const DeviceDetailsScreen(),
      //   },
    );
  }
}
