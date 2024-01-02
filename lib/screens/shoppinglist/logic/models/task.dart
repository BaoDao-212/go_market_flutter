import 'package:equatable/equatable.dart';

class Task extends Equatable {
  late final int id;
  late final String foodName;
  late final String done;
  late final int imageUrl;
  late final String type;
  late final String unitName;

  Task({
    required this.id,
    required this.done,
    required this.type,
    required this.foodName,
    required this.unitName,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodName = json['foodName'];
    done = json['done'] ?? '';
    unitName = json['unitName'] ?? '';
    type = json['type'] ?? '1';
    imageUrl = json['imageUrl'] ?? '1';
  }

  static List<Task> fromList(List<dynamic> list) {
    return list.map((e) => Task.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id, done, foodName, type, imageUrl, unitName];

  void add(Task fridge) {}
}
