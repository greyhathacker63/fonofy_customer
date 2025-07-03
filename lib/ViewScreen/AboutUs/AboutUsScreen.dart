import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late final WebViewController controller;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int p) {
            setState(() {
              progress = p / 100;
            });
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {
            debugPrint("WebView Error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
  return NavigationDecision.navigate;
}

        ),
        )
      ..loadRequest(Uri.parse('http://demo.fonofy.in/about'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          if (progress < 1.0)
            LinearProgressIndicator(
              value: progress,
              color: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
