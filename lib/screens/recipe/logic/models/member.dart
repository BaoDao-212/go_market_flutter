import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  late final int id;
  late final String description;
  late final String name;
  late final String htmlContent;
  late final String foodName;
  late final String foodImage;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.htmlContent,
    required this.foodName,
    required this.foodImage,
  });
  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    htmlContent = json['htmlContent'];
    foodName = json['Food']['name'];
    foodImage = json['Food']['imageUrl'];
  }

  static List<Recipe> fromList(List<dynamic> list) {
    return list.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  List<Object?> get props =>
      [id, name, description, htmlContent, foodName, foodImage];
}
