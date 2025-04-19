

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildUserReviewsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "User Reviews",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),

      // Summary Card
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Rating Box
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "4.7",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Stars and count
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        Icon(Icons.star_half, color: Colors.orange, size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("1108 reviews", style: TextStyle(fontSize: 14, color: Colors.black)),

                    const SizedBox(height: 12),

                    // Ratings breakdown
                    for (var rating in [
                      {"star": 5, "count": 807},
                      {"star": 4, "count": 283},
                      {"star": 3, "count": 18},
                      {"star": 2, "count": 0},
                      {"star": 1, "count": 0},
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text("${rating["star"]}", style: const TextStyle(fontSize: 12)),
                            const Icon(Icons.star, size: 14, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: (rating["count"] as int) / 1108,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text("(${rating["count"]})", style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 20),

      // Review 1
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Anshuman Mohapatra", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 28),
        ],
      ),

      // Review 2
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Good", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Nice"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Deepak", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
          const Divider(height: 28),
        ],
      ),

      // Review 3
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Good experience", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
              Icon(Icons.star, size: 16, color: Colors.orange),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Good experience"),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Text("Deepak", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(width: 6),
                  Icon(Icons.verified, size: 16, color: Colors.black54),
                ],
              ),
              Text("16/4/2025", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    ],
  );
}
