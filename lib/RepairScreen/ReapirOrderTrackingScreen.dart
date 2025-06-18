import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Colors.dart';

class ReapirOrderTrackingScreen extends StatefulWidget {
  const ReapirOrderTrackingScreen({super.key});

  @override
  State<ReapirOrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<ReapirOrderTrackingScreen> {
  final List<TrackingStep> steps = [
    TrackingStep('Order Confirmed', true,),
    TrackingStep('Shipped', true),
    TrackingStep('Out for Delivery', false),
    TrackingStep('Delivered', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair Track Order",style: TextStyle(color: Colors.white),),
        backgroundColor: ColorConstants.appBlueColor3,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding:   EdgeInsets.only(left: 20,top: 30),
        child: Column(
          children: [...steps.map((step) => buildStatusItem(step.title, step.isCompleted)),
              SizedBox(height: 20),
            _buildHelpCard(),
          ],
        ),
      ),
    );
  }

  Widget buildStatusItem(String title, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: isCompleted
                    ? ColorConstants.appBlueColor3
                    : Colors.grey[300],
                child: isCompleted
                    ? Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),

              if (title != steps.last.title)
                Container(width: 2, height: 40, color: Colors.grey[300]),
            ],
          ),
          const SizedBox(width: 12),
          Text(title, style: GoogleFonts.poppins(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildHelpCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:  ColorConstants.appBlueColor3,
            ),
            child: const Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 18,
            ),
          ),
           SizedBox(width: 12),
            Expanded(
            child: Text("Have Some Query? Need Help?",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackingStep {
  final String title;
  final bool isCompleted;
  TrackingStep(this.title, this.isCompleted);
}
