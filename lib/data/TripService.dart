import 'dart:convert';

import 'package:booktrip/model/TripModel.dart';
import 'package:http/http.dart' as http;

class TripService implements TripRepository {
 var httpHeader = {
  'Content-Type': 'application/json',
  };
  @override
  Future<TripModel> loadTripData() async {
    TripModel trip;
    String url = "https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      trip = parseTrip(response.body);
      return trip;
    } else {
      throw Exception("Error");
    }
  }

  TripModel parseTrip(body) {
    final parsed = json.decode(body);
    return  TripModel.fromJson(parsed);
  }
}
