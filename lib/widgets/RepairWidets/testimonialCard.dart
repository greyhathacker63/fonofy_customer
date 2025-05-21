
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Api_Service/ImageBaseUrl/ImageAllBaseUrl.dart';

Widget testimonialCard(
    {required String name, required String image, required String text}) {
  // return SingleChildScrollView(
  //   child: Column(
  //
  //     mainAxisSize: MainAxisSize.min, // Fix added here
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(10),
  //         margin: const EdgeInsets.symmetric(horizontal: 10),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(1),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min, // Also helpful here
  //           children: [
  //             const CircleAvatar(radius: 35, backgroundColor: Colors.grey),
  //             const SizedBox(height: 10),
  //             Text(
  //               text,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(fontSize: 14, color: Colors.black54),
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               name,
  //               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               role,
  //               style: const TextStyle(fontSize: 12, color: Colors.black54),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 10),
  //     ],
  //   ),
  // );

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
        // CircleAvatar(
        //   radius: 30,
        //   backgroundColor: image.isEmpty ? Colors.grey : null,
        //   child: image.isNotEmpty
        //       ? ClipOval(
        //     child: Image.network(
        //       image,
        //       width: 60,
        //       height: 60,
        //       fit: BoxFit.cover,
        //       loadingBuilder: (context, child, loadingProgress) {
        //         if (loadingProgress == null) return child;
        //         return const Center(
        //           child: CircularProgressIndicator(strokeWidth: 2),
        //         );
        //       },
        //       errorBuilder: (context, error, stackTrace) {
        //         debugPrint('Image load error: $error');
        //         return const Icon(Icons.error, color: Colors.red, size: 30);
        //       },
        //     ),
        //   )
        //       : const Icon(Icons.person, color: Colors.white, size: 30),
        // ),
        Image.network(
          height: 55,
          width: 55,
          '$imageBrandBaseUrl${image ?? ""}',
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          },
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(text,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}