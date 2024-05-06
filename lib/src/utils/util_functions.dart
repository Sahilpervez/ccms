import 'package:intl/intl.dart';

class UtilFunctions {
  static String formattedDate(DateTime date,{String monthFormat = "MMMM"}) {
    String suffix = 'th';
    final int digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = <String>['st', 'nd', 'rd'][digit - 1];
    }
    return DateFormat("d'$suffix' $monthFormat, yyyy").format(date); // 'Sun, Jun 30th'
  }
}
