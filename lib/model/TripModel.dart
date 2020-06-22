import 'package:booktrip/model/ReserveTypesModel.dart';

class TripModel {
  int id;
  String title;
  List<dynamic> img;
  int price;
  String interest;
  String date;
  String address;
  String trainerName;
  String trainerImg;
  String trainerInfo;
  String occasionDetail;
  String latitude;
  String longitude;
  bool isLiked;
  bool isSold;
  bool isPrivateEvent;
  bool hiddenCashPayment;
  int specialForm;
  String questionnaire;
  String questExplanation;
  List<ReserveTypesModel> reservTypes;

  TripModel(
      {this.id,
      this.title,
      this.img,
      this.price,
      this.interest,
      this.date,
      this.address,
      this.trainerName,
      this.trainerImg,
      this.trainerInfo,
      this.occasionDetail,
      this.latitude,
      this.longitude,
      this.isLiked,
      this.isSold,
      this.isPrivateEvent,
      this.hiddenCashPayment,
      this.specialForm,
      this.questionnaire,
      this.questExplanation,
      this.reservTypes});

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json["id"],
      title: json["title"],
      img: json["img"],
      price: json["price"],
      interest: json["interest"],
      date: json["date"],
      address: json["address"],
      trainerName: json["trainerName"],
      trainerImg: json["trainerImg"],
      trainerInfo: json["trainerInfo"],
      occasionDetail: json["occasionDetail"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isLiked: json["isLiked"],
      isSold: json["isSold"],
      isPrivateEvent: json["isPrivateEvent"],
      hiddenCashPayment: json["hiddenCashPayment"],
      specialForm: json["specialForm"],
      questionnaire: json["questionnaire"],
      questExplanation: json["questExplanation"],
      reservTypes: (json["reservTypes"] != null)
          ? json["reservTypes"]
              .map<ReserveTypesModel>(
                  (json) => ReserveTypesModel.fromJson(json))
              .toList()
          : null,
    );
  }
}

abstract class TripRepository {
  Future<TripModel> loadTripData();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
