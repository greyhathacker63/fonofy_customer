import 'package:flutter/material.dart';

import '../utils/Colors.dart';

class CancelRepairOrderScreen extends StatefulWidget {
  @override
  _CancelRepairOrderScreenState createState() => _CancelRepairOrderScreenState();
}

class _CancelRepairOrderScreenState extends State<CancelRepairOrderScreen> {

  String? selectedReason;
  TextEditingController otherReasonController = TextEditingController();

  final List<String> reasons = [
    'Delay in service',
    'Changed my mind',
    'Duplicate order',
    'Price too high',
    'Want to Sell the device',
    'Want to buy the device',
  ];

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Green title bar with "Cancel"
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: ColorConstants.appBlueColor3, // green color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Content section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Do you really want to cancel?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Color(0xFF3DD598)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'NO',
                              style: TextStyle(
                                color: Color(0xFF3DD598),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Handle confirmed cancellation
                              print('Cancelled with reason: $selectedReason');
                              print('Other reason: ${otherReasonController.text}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3DD598),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'YES',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Reason for cancellation",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
        
                  SizedBox(height: 18),
        
                Text(
                  "Please tell us the reason",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
        
                  SizedBox(height: 4),
        
                Column(
                  children: reasons.map((reason) {
                    return RadioListTile<String>(
                      value: reason,
                      groupValue: selectedReason,
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      contentPadding: EdgeInsets.zero,
                      title: Text(reason, style: TextStyle(fontSize: 14)),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      activeColor: ColorConstants.appBlueColor3,
                    );
                  }).toList(),
                ),
        
                 Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 20),
                  child: TextField(
                    controller: otherReasonController,
                    decoration: InputDecoration(
                      hintText: "Tell us what we missed!",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
        
                 SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showCancelDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appBlueColor3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text("CONFIRM",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}