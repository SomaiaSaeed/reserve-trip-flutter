class ReserveTypesModel {
  int id;
  String name;
  int count;
  int price;
  ReserveTypesModel({this.id, this.name, this.count, this.price});

  factory ReserveTypesModel.fromJson(Map<String, dynamic> json) {
    return ReserveTypesModel(
      id: json["id"],
      name: json["name"],
      count: json["count"],
      price: json["price"],
    );
  }
}
