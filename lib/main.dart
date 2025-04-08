import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fonofy/AccountsScreen.dart';
import 'package:fonofy/LoginScreen.dart';
 import 'package:get/get.dart';
 import 'package:fonofy/MainScreen.dart';
import 'package:provider/provider.dart';

 import 'address_screen5.dart'; // ✅ Import your ViewModel

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => OtpViewModel()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Fonofy',
//       theme: ThemeData(
//         useMaterial3: true,
//       ),
//       initialRoute: '/',
//       getPages: [
//         // GetPage(name: '/', page: () => LoginScreen()),
//         GetPage(name: '/main', page: () => const MainScreen()),
//         GetPage(name: '/buy', page: () => const BuyScreen()),
//         // GetPage(name: '/',page: () => AddressScreen5()),
//         // GetPage(name: '/',page: () => AccountDetailsScreen(phoneNumber: '',)),
//       ],
//     );
//   }
// }

import 'package:fonofy/ViewModel/MobileOtpSend.dart';

import 'otp_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => OtpViewModel()),
      ],
      child: const MyApp(),
    ),
  );
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
     //home: OtpScreen(otp: '', number: '1234567890',),
      home: MainScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}