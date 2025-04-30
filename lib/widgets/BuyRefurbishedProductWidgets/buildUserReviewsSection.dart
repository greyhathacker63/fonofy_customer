import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/ProductDetailsModel/ProductDetailsModel.dart';
import '../../model/ProductDetailsModel/ProductRatingModel.dart';
import '../../model/ProductDetailsModel/ProductReviewModel.dart';

Widget buildUserReviewsSection(ProductDetailsModel product, List<ProductReviewModel> reviews) {
  final ratingData = ProductRatingModel();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("User Reviews",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${product.avgReview?.toString() ?? '0.0'}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        final rate = product.avgRate ?? 0.0;

                        if (index < rate.floor()) {
                          return const Icon(Icons.star, color: Colors.orange, size: 18);
                        } else if (index == rate.floor() && rate % 1 >= 0.5) {
                          return const Icon(Icons.star_half, color: Colors.orange, size: 18);
                        } else {
                          return const Icon(Icons.star_border, color: Colors.orange, size: 18);
                        }
                      }),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "${product.reviewCount ?? 0} reviews",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),

                    const SizedBox(height: 12),

                    Builder(builder: (context) {
                      int totalRatings = (ratingData.rating1 ?? 0) +
                          (ratingData.rating2 ?? 0) +
                          (ratingData.rating3 ?? 0) +
                          (ratingData.rating4 ?? 0) +
                          (ratingData.rating5 ?? 0);

                      final ratingList = [
                        {"star": 5, "count": ratingData.rating5 ?? 0},
                        {"star": 4, "count": ratingData.rating4 ?? 0},
                        {"star": 3, "count": ratingData.rating3 ?? 0},
                        {"star": 2, "count": ratingData.rating2 ?? 0},
                        {"star": 1, "count": ratingData.rating1 ?? 0},
                      ];

                      return Column(
                        children: ratingList.map((rating) {
                          final double value = totalRatings > 0
                              ? (rating["count"] as int) / totalRatings
                              : 0;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text("${rating["star"]}",
                                    style: const TextStyle(fontSize: 12)),
                                const Icon(Icons.star, size: 14, color: Colors.grey),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                    minHeight: 6,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text("(${rating["count"]})",
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: 20),
      ListView.builder(
        shrinkWrap: true,
        physics:  NeverScrollableScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final reviewDetails = reviews[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (index) {
                  final rate = product.avgRate ?? 0.0;
                  if (index < rate.floor()) {
                    return const Icon(Icons.star, color: Colors.orange, size: 18);
                  } else if (index == rate.floor() && rate % 1 >= 0.5) {
                    return const Icon(Icons.star_half, color: Colors.orange, size: 18);
                  } else {
                    return const Icon(Icons.star_border, color: Colors.orange, size: 18);
                  }
                }),
              ),

              const SizedBox(height: 8),
              Text(reviewDetails.description.toString(),
                style: TextStyle(fontSize: 12),),
              SizedBox(height: 6,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        reviewDetails.firstName ?? '',
                        style:
                        const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.verified,
                          size: 14, color: Colors.black54),
                    ],
                  ),
                  Text(
                    reviewDetails.createdDate ?? '',
                    style:  TextStyle(color: Colors.grey,fontSize: 13),
                  ),
                ],
              ),
            ],
          );
        },
      )
    ],
  );
}
