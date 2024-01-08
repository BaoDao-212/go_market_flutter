import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  late final int id;
  late final String body;
  late final String title;
  late final String date;

  Notification({
    required this.id,
    required this.title,
    required this.date,
    required this.body,
  });

  @override
  List<Object?> get props => [id, body, date, title];

  void add(Notification fridge) {}
  // Future<void> saveLocally() async {
  //   await DatabaseFood.insertFood(this);
  // }

  // static Future<dynamic> getLocalFoods() async {
  //   return await DatabaseFood.getFoods();
  // }
}
