import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

class Task extends Equatable {
  late final int id;
  late final String foodName;
  late final String done;
  late final int imageUrl;
  late final String type;
  late final String unitName;
  late final int quantity;

  Task({
    required this.id,
    required this.done,
    required this.type,
    required this.quantity,
    required this.foodName,
    required this.unitName,
    required this.imageUrl,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodName = json['Food.name'];
    done = json['done'] ?? 0;
    quantity = json['quantity'] ?? 1;
    unitName = json['Food.UnitOfMeasurement.unitName'] ?? '';
    type = json['Food.type'] ?? '';
    imageUrl = json['Food.imageUrl'] ?? '';
  }

  static List<Task> fromList(List<dynamic> list) {
    return list.map((e) => Task.fromJson(e)).toList();
  }

  @override
  List<Object?> get props =>
      [id, done, foodName, type, imageUrl, unitName, quantity];

  void add(Task fridge) {}
}
