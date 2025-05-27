class WidgetsHelper {
  static String runtimeToHours(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    var firstPart = parts[0] != "0" ? "${parts[0]}h " : "";
    return '$firstPart${parts[1].padLeft(2, '0')}m' == "00m"
        ? "Unknown"
        : '$firstPart${parts[1].padLeft(2, '0')}m';
  }
}
