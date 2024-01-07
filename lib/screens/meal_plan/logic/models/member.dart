import 'package:equatable/equatable.dart';

class MealPlan extends Equatable {
  late final int id;
  late final String timestamp;
  late final String name;
  late final String status;
  late final String foodName;
  late final String foodImage;

  MealPlan({
    required this.id,
    required this.name,
    required this.timestamp,
    required this.status,
    required this.foodName,
    required this.foodImage,
  });
  MealPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timestamp = json['timestamp'];
    status = json['status'];
    foodName = json['Food']['name'];
    foodImage = json['Food']['imageUrl'];
  }

  static List<MealPlan> fromList(List<dynamic> list) {
    return list.map((e) => MealPlan.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id, name, timestamp, status, foodName, foodImage];
}
