import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';

class FoodModel extends Equatable {
  final List<Food> foods;

  FoodModel({
    required this.foods,
  });

  FoodModel copyWith({
    List<Food>? foods, // Corrected the type here
  }) {
    return FoodModel(
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props => [foods];
}
