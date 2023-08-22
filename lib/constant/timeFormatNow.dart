import 'package:intl/intl.dart';

class TimeFormatNow {
  String dateFormatGAY(DateTime dateTime) {
    String date = DateFormat.MMMEd().format(dateTime);
    return date;
  }
   String dateFormatGunAY(dateTime) {
    String date = DateFormat.Md().format(dateTime);
    return date;
  }

     String dateFormatGunAyYil(dateTime) {
    String date = DateFormat.yMd().format(dateTime);
    return date;
  }
    int hesaplaEvetProgres(DateTime dateTime) {
    String dateNow = dateFormatGunAY(dateTime);
    List dateNow2 = dateNow.split("/");
    int ay = int.parse(dateNow2[0]);
    int gun = int.parse(dateNow2[1]);
    int countDay = (ay * 30) + gun + (ay / 2).toInt();
    return countDay;
  }
    String EventTime(DateTime dateTime) {
    int nowTotalDay = hesaplaEvetProgres(DateTime.now());
    int startTotalEventDay = hesaplaEvetProgres(dateTime);
    int currentEvetTime = nowTotalDay - startTotalEventDay + 1;
    return currentEvetTime.toString();

    }
}
