DateTime? dateTime;

String formatUnixDateTimeToString(int timestamp) {
  dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String d = dateTime!.day.toString();
  String m = dateTime!.month.toString();
  String y = dateTime!.year.toString();

  String H = dateTime!.hour.toString();
  String M = dateTime!.minute.toString();

  return "$d/$m/$y - $H:$M";
}

String formatUnixDateToString(int timestamp) {
  dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String d = (dateTime!.day < 10 ? "0" : "") + dateTime!.day.toString();
  String m = (dateTime!.month < 10 ? "0" : "") + dateTime!.month.toString();
  String y = dateTime!.year.toString();

  return "$d/$m/$y";
}

String toCapitalCase(String s) {
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

String toCapitalCaseSentence(String s) {
  return s.split(" ").map((e) => toCapitalCase(e)).join(" ");
}
