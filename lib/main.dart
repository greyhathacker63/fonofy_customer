import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:fonofy/LoginScreen.dart';
import 'package:fonofy/MainScreen.dart';
import 'package:fonofy/BuyScreen/BuyScreen.dart';
import 'package:fonofy/ViewModel/MobileOtpSend.dart'; // ✅ Import your ViewModel

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OtpViewModel()), // ✅ Add Provider
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/buy', page: () => const BuyScreen()),
      ],
    );
  }
}
