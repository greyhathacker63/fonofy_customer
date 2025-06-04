import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherRepairTile extends StatelessWidget {
  const OtherRepairTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: const Color(0xFFF6F6F6),
        leading:   Icon(Icons.home_repair_service_outlined),
        title:   Text("Looking for other repair service?" ,style: TextStyle(fontSize: 12),),
        trailing:  Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
