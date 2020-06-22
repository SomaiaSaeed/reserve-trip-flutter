import 'package:booktrip/model/TripModel.dart';
import 'package:booktrip/view/TripView.dart';

import '../dependency_injection.dart';

abstract class TripDataResponse {
  void onLoadTripDataResponseComplete(TripModel data);
  void onLoadTripDataResponseError();
}

class TripPresenter implements TripDataResponse {
  final TripView view;
  TripRepository _tripRepository;

  TripPresenter(this.view) {
    _tripRepository = new Injector().tripRepository;
  }

  void loadTripData() {
    _tripRepository
        .loadTripData()
        .then((data) => this.onLoadTripDataResponseComplete(data))
        .catchError((onError) => this.onLoadTripDataResponseError());
  }

  @override
  void onLoadTripDataResponseComplete(TripModel data) {
    view.updateView(data);
  }

  @override
  void onLoadTripDataResponseError() {
    // TODO: implement onLoadTripDataResponseError
  }
}
