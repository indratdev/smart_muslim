import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_muslim/models/pray_times.dart';

class ApiConnection {
  Future<PrayTimes> getDailyTimesPray(double lat, double lon) async {
    Uri url = Uri.parse(
        // 'https://api.pray.zone/v2/times/day.json?city=$city&date=2022-02-28');
        'https://api.pray.zone/v2/times/day.json?date=2022-03-08&longitude=$lon&latitude=$lat');
    print(url);
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200 && result['status'] == "OK") {
      print(result['results']);
      return PrayTimes.fromJson(result['results']);
    } else {
      throw Exception('failed');
    }
  }
}
