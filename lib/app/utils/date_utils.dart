import 'package:intl/intl.dart';

class DateUtils {
  static String parseDateTimeFormat(dynamic date, {format = "dd/MM/yyyy"}) {
    if (date.toString().contains("/")) {
      return date.toString();
    } else {
      if (date == null || date == "" || date is List ) {
        return "";
      } else {
        DateTime now = DateTime.now();
        if (date is String) {
          var dateTotal = getDateFormate(date);
          if(dateTotal == null){
            now = DateTime.parse(date);
          }else{
            DateTime tempDate = new DateFormat(dateTotal).parse(date);
            now = tempDate;
          }

        } else {
          now = date;
        }

        String formattedDate = DateFormat(format, "pt_BR").format(now);
        return formattedDate;
      }
    }
  }

  static DateTime convertStringToDateTime(String date) {
    if(date == null || date == "--" || date == "" || date == "-"){
      return null;
    }else{
      DateTime tempDate = new DateFormat("dd/MM/yyyy").parse(date);
      return tempDate;
    }

  }

  static int compareDateNow(String dateInit,
      {String dateEnd, bool isHours = false}) {
    final dateInitial = dateInit == "" || dateInit == null
        ? DateTime.now()
        : DateTime.parse(dateInit);
    final date2 = dateEnd == null ? DateTime.now() : DateTime.parse(dateEnd);
    final difference = isHours
        ? date2.difference(dateInitial).inHours
        : date2.difference(dateInitial).inSeconds;
    return difference;
  }

  static int compareDateNowDatime(DateTime dateInit,
      {DateTime dateEnd, bool isDays = false}) {
    final dateInitial = dateInit;

    final date2 = dateEnd;
    final difference = isDays
        ? date2.difference(dateInitial).inDays
        : date2.difference(dateInitial).inMinutes;
    return difference;
  }
}

String getDateFormate(String date) {
  if(date.contains("-")&& date.contains(":") && (!date.contains("Z"))){
    return "dd-MM-yyyy HH:mm";
  }else{
    return null;
  }
}
