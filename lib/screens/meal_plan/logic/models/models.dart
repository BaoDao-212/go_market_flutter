import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/meal_plan/logic/models/member.dart';

class MealPlanModel extends Equatable {
  final List<MealPlan> mealPlan;

  MealPlanModel({
    required this.mealPlan,
  });

  MealPlanModel copyWith({
    List<MealPlan>? mealPlan,
  }) {
    return MealPlanModel(
      mealPlan: mealPlan ?? this.mealPlan,
    );
  }

  @override
  List<Object?> get props => [mealPlan];
}
