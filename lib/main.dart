import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/Orders/MyOrders.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:fonofy/MainScreen.dart';
import 'package:fonofy/ViewModel/MobileOtpSend.dart';
import 'package:fonofy/services/token_service.dart'; // make sure this file exists

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  // Start the token refresh timer
  TokenService.startTokenRefreshTimer();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OtpViewModel()),
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
      theme: ThemeData(useMaterial3: true),
      home:  MainScreen(),
       getPages: [
        GetPage(name: '/main', page: () => const MainScreen()),
        // Add other screens here
      ],
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
