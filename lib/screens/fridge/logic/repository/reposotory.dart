import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/food/logic/provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class FoodRepository {
  final FoodAPIProvider _apiProvider = FoodAPIProvider();

  FoodRepository();

  Future<FoodModel> getFoodList() async {
    print(1);
    final apiResponse = await _apiProvider.getFoodlist();
    return apiResponse;
  }

  Future<dynamic> getUnitName() async {
    final apiResponse = await _apiProvider.getUnitName();
    return apiResponse;
  }

  Future<dynamic> getCategoryFood() async {
    final apiResponse = await _apiProvider.getCategoryFood();
    return apiResponse;
  }

  Future<dynamic> createFood(String name, String foodCategoryName,
      String unitName, XFile image) async {
    await _apiProvider.createFood(name, foodCategoryName, unitName, image);
    final food = _apiProvider.getFoodlist();
    return food;
  }

  Future<dynamic> updateFood(String name, String newName,
      String foodCategoryName, String unitName, dynamic image) async {
    await _apiProvider.updateFood(
        name, newName, foodCategoryName, unitName, image);
    final food = _apiProvider.getFoodlist();
    return food;
  }

  Future<FoodModel> deleteFood(String name) async {
    await _apiProvider.deleteFood(name);
    final foods = await _apiProvider.getFoodlist();
    return foods;
  }
}
