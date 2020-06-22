//DI
import 'package:booktrip/data/TripService.dart';
import 'package:booktrip/model/TripModel.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TripRepository get tripRepository {
    return new TripService();
  }
}
