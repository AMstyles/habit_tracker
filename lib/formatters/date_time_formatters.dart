import 'package:intl/intl.dart';

class TimeHelper{

  static String format(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String getPartOfDay() {
    final dateTime = DateTime.now();
    final hour = dateTime.hour;
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Afternoon';
    } else if (hour >= 18 && hour < 24) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }
}