import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../RepairScreen/CancelRepairOrderScreen.dart';
import '../../RepairScreen/ReapirOrderTrackingScreen.dart';
import '../../RepairScreen/RescheduleOrderRepairScreen.dart';
import '../../utils/Colors.dart';

class RepairPriceAndScheduleWidget  extends StatelessWidget {
  const RepairPriceAndScheduleWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding:   EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Summary',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Divider(thickness: 1, color: Colors.grey[300]),
                const SizedBox(height: 6),
                _buildPriceRow('BATTERY', '₹2,999'),
                _buildDashedLine(),
                _buildPriceRow('SCREEN', '₹10,999'),
                _buildDashedLine(),
                _buildPriceRow('Total Amount', '₹13,998', isBold: true),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Arrival time of executive',
                  style: GoogleFonts.poppins(
                      color: ColorConstants.appBlueColor3,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Thu 5 Jun, 2025 10:00 AM - 03:00 PM',
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                const SizedBox(height: 10),
                Text(
                  'Address:',
                  style: GoogleFonts.poppins(
                      color: ColorConstants.appBlueColor3,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                  SizedBox(height: 4),
                Text(
                  'F-294, Sector 63 , Noida, Uttar Pradesh, 201301',
                  style: GoogleFonts.poppins(fontSize: 12,),
                ),
                  SizedBox(height: 12),
                Text(
                  'Contact Number:',
                  style: GoogleFonts.poppins(
                      color: ColorConstants.appBlueColor3,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                  SizedBox(height: 4),
                Text(
                  '9554346561',
                  style: GoogleFonts.poppins(fontSize: 13, ),
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.appBlueColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CancelRepairOrderScreen(),));
                        },
                        child: Text(
                          'CANCEL',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: 13),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.appBlueColor3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context) => RescheduleOrderRepairScreen(),) );
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ReapirOrderTrackingScreen(),) );
                        },
                        child: Text('Tracking',
                          style: GoogleFonts.poppins(
                            color: Colors.white,fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 6).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
                (_) => Container(
              width: 3,
              height: 1,
              color: Colors.grey[400],
            ),
          ),
        );
      },
    );
  }
}