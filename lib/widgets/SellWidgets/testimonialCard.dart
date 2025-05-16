import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/model/SellModel/SellTestimonialListModel.dart';

import 'package:flutter/material.dart';


Widget testimonialCard({required SellTestimonialListModel testimonialData}) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: testimonialData.image != null && testimonialData.image!.isNotEmpty
              ? NetworkImage(testimonialData.image!)
              :  AssetImage('assets/images/placeholder.png') as ImageProvider,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 10),
        Text(
          testimonialData.description ?? "No testimonial provided",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Text(
          testimonialData.name ?? "Unknown",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),

      ],
    ),
  );
}

