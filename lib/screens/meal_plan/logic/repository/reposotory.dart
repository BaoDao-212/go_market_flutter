import 'package:shop_app/screens/meal_plan/logic/models/models.dart';
import 'package:shop_app/screens/meal_plan/logic/provider/provider.dart';

class MealPlanRepository {
  final MealPlanAPIProvider _apiProvider = MealPlanAPIProvider();

  MealPlanRepository();

  Future<MealPlanModel> getMealPlanList(String date) async {
    final apiResponse = await _apiProvider.getMealPlanlist(date);
    return apiResponse;
  }

  Future<dynamic> createMealPlan(
      String foodName, String timestamp, String name, String date) async {
    await _apiProvider.createMealPlan(foodName, timestamp, name);
    final fridges = await _apiProvider.getMealPlanlist(date);
    return fridges;
  }

  Future<dynamic> updateMealPlan(int id, String name, String foodName,
      String timestamp, String date) async {
    await _apiProvider.updateMealPlan(id, name, foodName, timestamp);
    final meal = await _apiProvider.getMealPlanlist(date);
    return meal;
  }

  Future<MealPlanModel> deleteMealPlan(int id, String date) async {
    await _apiProvider.deleteMealPlan(id);
    final fridges = await _apiProvider.getMealPlanlist(date);
    return fridges;
  }
}
