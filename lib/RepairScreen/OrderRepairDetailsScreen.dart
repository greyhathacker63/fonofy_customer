import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Colors.dart';
import '../widgets/RepairWidets/RepairPriceAndScheduleWidget.dart';

class OrderRepairDetailsScreen extends StatelessWidget {
  const OrderRepairDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:   EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
                child: Padding(
                  padding:   EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Repair : -',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorConstants.appBlueColor3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text('Service No : #CSPATOI726107',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),

                        SizedBox(height: 20),
                      _buildDashedLine(),
                        SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vivo X70 Pro',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Color: Cosmic Black',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/images/phone.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text(
                        'Booked Repair Services:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text('BATTERY', style: TextStyle(color: Colors.grey[600])),
                      Text('SCREEN', style: TextStyle(color: Colors.grey[600])),

                        SizedBox(height: 8),

                      RichText(
                        text: TextSpan(
                          text: 'Repair Cost : ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: '₹13,998',
                              style: TextStyle(
                                color: ColorConstants.appBlueColor3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),
                      _buildDashedLine(),



                     ],
                  ),
                ),

              ),

                SizedBox(height: 20),
              RepairPriceAndScheduleWidget(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = (constraints.maxWidth / 6).floor();
        return Wrap(
          spacing: 3,
          children: List.generate(
            count,
                (index) => Container(width: 3, height: 1, color: Colors.grey[400]),
          ),
        );
      },
    );
  }
}
