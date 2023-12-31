import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/food/logic/local_db/food.dart';

class Food extends Equatable {
  late final int id;
  late final String name;
  late final String categoryName;
  late final String unitName;
  late final String imageUrl;

  Food({
    required this.id,
    required this.unitName,
    required this.categoryName,
    required this.name,
    required this.imageUrl,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['FoodCategory']['name'] ?? '';
    unitName = json['UnitOfMeasurement']['unitName'];
    name = json['name'] ?? '';
    imageUrl = json['imageUrl'] ?? '';
  }

  static List<Food> fromList(List<dynamic> list) {
    return list.map((e) => Food.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id, categoryName, unitName, name, imageUrl];
  // Future<void> saveLocally() async {
  //   await DatabaseFood.insertFood(this);
  // }

  // static Future<dynamic> getLocalFoods() async {
  //   return await DatabaseFood.getFoods();
  // }
}
