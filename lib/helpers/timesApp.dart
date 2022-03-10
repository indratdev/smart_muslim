import 'package:intl/intl.dart';
import 'package:smart_muslim/models/datetimes_pray.dart';

class TimesApp {
  String currentTime = "Na:Na";
  String nextTime = "Na:Na";

  // benerin yang disini

  String checkTimeFirst(List<String> listWaktu, String waktuSekarang) {
    String result = "";
    int target = int.parse(waktuSekarang.replaceAll(":", ""));

    for (var value in listWaktu) {
      var data = int.parse(value.replaceAll(":", ""));
      if (data > target) {
//        print("data ini lebih tingggi $data");
        result = data.toString();
        break;
      }
    }
    return result;
  }

  // void getCurrentTime() {
  //   var time = DateFormat("HH:mm").format(DateTime.now());
  //   var time2 =
  //       DateFormat("HH:mm").format(DateTime.now().add(Duration(minutes: 60)));
  //   print('times : $time');
  //   print('times : $time2');

  //   // var ttime = time.split(':');
  //   // var ttime2 = time2.split(':');

  //   // var totalSeconds1 = parseInt(ttime[0] * 3600 + ttime[1] * 60 + ttime[0]);
  //   // var totalSeconds2 = parseInt(ttime2[0] * 3600 + ttime2[1] * 60 + ttime2[0]);
  // }

  // // compareTime(str1, str2){
  // compareTime() {
  //   // var str1 = DateFormat("HH:mm").format(DateTime.now());
  //   // var str2 =
  //   //     DateFormat("HH:mm").format(DateTime.now().add(Duration(minutes: 60)));

  //   // str1.replaceAll(":", "");
  //   // print(str1.replaceAll(":", ""));

  //   Times datetime;

  //   // print(datetime);
  // }
}
