import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fonofy/pages/MyOrdersScreen/MyOrdersScreen.dart';
import 'package:get/get.dart';
import 'package:fonofy/pages/MainScreen/MainScreen.dart';
import 'package:fonofy/controllers/MobileOtpSend.dart';
import 'package:fonofy/services/token_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Initialize GetX controllers
  Get.put(OtpViewModel());

  // Start the token refresh timer
  TokenService.startTokenRefreshTimer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fonofy',
      theme: ThemeData(useMaterial3: true),
      home: MainScreen(),
      getPages: [
        GetPage(name: '/main', page: () => MainScreen()),
        GetPage(name: '/orders', page: () => MyOrdersScreen()),
        // Add other screens here
      ],
      initialRoute: '/main',
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = 
          (X509Certificate cert, String host, int port) => true;
  }
}