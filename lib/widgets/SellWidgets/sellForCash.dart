import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';
import '../../ViewScreen/AllBrands.dart';
import '../../model/SellModel/BrandListModel.dart';
import '../../utils/Colors.dart';

Widget sellForCash(List<BrandListModel>? brandListData) {
  return ListView(
    shrinkWrap: true,
    physics:   NeverScrollableScrollPhysics(),
    children: [
      // Title
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text("SELL FOR CASH",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 8),

      // Grid of brand logos and names
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brandListData?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final brandDetails = brandListData?[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => AllBrandsScreen());
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: ClipRect(
                      child: Image.network(
                        '$imageAllBaseUrl${brandDetails?.brandImage ?? ''}',
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image,color: ColorConstants.appBlueColor3,),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return   Center(
                              child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    brandDetails?.brandName ?? '',
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}