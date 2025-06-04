import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../OrderThankYouScreen/OrderThankYouScreen.dart';

class PaymentScreen extends StatefulWidget {
  final String orderId;
  final double totalAmount;
  final String name;
  final String phone;


  const PaymentScreen({
    super.key,
    required this.orderId,
    required this.totalAmount,
    required this.name,
    required this.phone,
   });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

     WidgetsBinding.instance.addPostFrameCallback((_) {
      openCheckout(widget.totalAmount);
    });
  }

  void openCheckout(double totalAmount) {
    if (totalAmount <= 0) {
      Fluttertoast.showToast(msg: "Invalid payment amount");
      return;
    }

    int amountInPaise = (totalAmount * 100).toInt();

    var options = {
      'key': 'rzp_test_VGeS7Ec7McP9LF',

      'amount': amountInPaise,
      'name': widget.name,
      'description': 'Order ID: ${widget.orderId}',
      'prefill': {
        'contact': widget.phone,
        'email': 'customer@example.com',
      },
      'external': {
        'wallets': ['paytm'],

      }
    };
    try {
      setState(() => _isLoading = true);
      _razorpay.open(options);
    } catch (e) {
      debug// print('Razorpay Error: $e');
      setState(() => _isLoading = false);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() => _isLoading = false);
    Fluttertoast.showToast(
      msg: '',
      // msg: "Payment successful! Payment ID: ${response.paymentId}",
      backgroundColor: Colors.white,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OrderThankYouScreen(orderId: widget.orderId),
      ),
          (route) => false,
    );
    // print("Payments :- ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    Fluttertoast.showToast(
      msg: "Payment failed: ${response.message}",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
    Navigator.pop(context); // Return to previous screen
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isLoading = false);
    Fluttertoast.showToast(
      msg: "External wallet selected: ${response.walletName}",
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Processing Payment...")),
      body:  Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
