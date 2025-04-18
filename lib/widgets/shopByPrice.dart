import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonofy/ViewScreen/BuyRefurbishedProductScreen.dart';

import '../model/ByScreenTableModel/ByScreenTableModel.dart';

Widget shopByPrice({List<Table6>? shopTablePrices}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("Shop By Price",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shopTablePrices?.length ?? 0,
            itemBuilder: (context, index) {
              var shopPriceDetails = shopTablePrices?[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BuyRefurbishedProductScreen(
                      url: '',
                      refNo: ''),));
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Under ₹ ${shopPriceDetails?.priceRange.toString() ?? ""}',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
