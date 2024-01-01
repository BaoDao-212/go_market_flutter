import 'package:equatable/equatable.dart';

class Fridge extends Equatable {
  late final int id;
  late final String name;
  late final String note;
  late final int quantity;
  late final String type;
  late final String imageUrl;
  late final DateTime expiredDate;
  late final DateTime startDate;

  Fridge({
    required this.id,
    required this.note,
    required this.type,
    required this.quantity,
    required this.expiredDate,
    required this.startDate,
    required this.name,
    required this.imageUrl,
  });
  Fridge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Food']['name'] ?? '';
    note = json['note'] ?? '';
    quantity = json['quantity'] ?? 1;
    type = json['Food']['type'] ?? '';
    imageUrl = json['Food']['imageUrl'] ?? '';
    expiredDate = DateTime.parse(json['expiredDate']);
    startDate = DateTime.parse(json['startDate']);
  }

  static List<Fridge> fromList(List<dynamic> list) {
    return list.map((e) => Fridge.fromJson(e)).toList();
  }

  @override
  List<Object?> get props =>
      [id, note, quantity, startDate, expiredDate, name, imageUrl];

  void add(Fridge fridge) {}
  // Future<void> saveLocally() async {
  //   await DatabaseFood.insertFood(this);
  // }

  // static Future<dynamic> getLocalFoods() async {
  //   return await DatabaseFood.getFoods();
  // }
}
