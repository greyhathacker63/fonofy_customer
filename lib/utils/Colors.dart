import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
class ColorConstants {


  static Color appGreyColor = hexToColor('#D9D9D9');
  static Color appBlueColor = hexToColor('#EAF5FB');
  static Color appBlueColor2 = hexToColor('#19628B');
  static Color appBlueColor3 = hexToColor('#5892B1');
  static Color appBlueColor4 = hexToColor('#C3DDFF');
  static Color lightColor = hexToColor('#DCFBFF');
  static Color greenColor = hexToColor('#B6FFB8');
  static Color appBlueColor5 = hexToColor('#5892B0');
  static Color appGreyColor2 = hexToColor('#F5F5F5');
}

// Color getColorFromName(String colorName) {
//   switch (colorName.toLowerCase()) {
//     case 'red':
//       return Colors.red;
//     case 'blue':
//       return Colors.blue;
//     case 'green':
//       return Colors.green;
//     case 'black':
//       return Colors.black;
//     case 'white':
//       return Colors.white;
//     case 'grey':
//     case 'gray':
//       return Colors.grey;
//     case 'yellow':
//       return Colors.yellow;
//     case 'pink':
//       return Colors.pink;
//     case 'purple':
//       return Colors.purple;
//     case 'orange':
//       return Colors.orange;
//     case 'teal':
//       return Colors.teal;
//     case 'brown':
//       return Colors.brown;
//     default:
//       return Colors.grey; // fallback color
//   }
// }


Color getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'grey':
    case 'gray':
      return Colors.grey;
    case 'yellow':
      return Colors.yellow;
    case 'pink':
      return Colors.pink;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'teal':
      return Colors.teal;
    case 'brown':
      return Colors.brown;
    case 'amber':
      return Colors.amber;
    case 'cyan':
      return Colors.cyan;
    case 'lime':
      return Colors.lime;
    case 'indigo':
      return Colors.indigo;
    case 'deeporange':
    case 'deep orange':
      return Colors.deepOrange;
    case 'deeppurple':
    case 'deep purple':
      return Colors.deepPurple;
    case 'lightblue':
    case 'light blue':
      return Colors.lightBlue;
    case 'lightgreen':
    case 'light green':
      return Colors.lightGreen;
    case 'bluegrey':
    case 'blue grey':
    case 'bluegray':
    case 'blue gray':
      return Colors.blueGrey;
    default:
      return Colors.grey;
  }
}

