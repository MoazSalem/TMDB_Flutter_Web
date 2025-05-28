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
}
