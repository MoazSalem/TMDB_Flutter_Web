import 'package:flutter/material.dart';

class WidgetsHelper {
  static String runtimeToHours(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    var firstPart = parts[0] != "0" ? "${parts[0]}h " : "";
    return '$firstPart${parts[1].padLeft(2, '0')}m' == "00m"
        ? "Unknown"
        : '$firstPart${parts[1].padLeft(2, '0')}m';
  }

  static Color progressColor({required double rating}) {
    return rating <= 25
        ? Colors.red
        : rating > 25 && rating <= 50
        ? Colors.red.shade300
        : rating > 50 && rating < 70
        ? Colors.yellow
        : Colors.greenAccent;
  }

  static int crossAxisCount({required currentWidth}) {
    int count = currentWidth ~/ 250;
    switch (count) {
      case 1:
        return count = 2;
      case 3:
        return count = 4;
      case > 5:
        return count = 5;
      case 0:
        return count = 1;
      default:
        return count;
    }
  }
}
