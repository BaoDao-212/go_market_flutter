import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/food/logic/provider/provider.dart';

class FoodRepository {
  final FoodAPIProvider _apiProvider = FoodAPIProvider();

  FoodRepository();

  Future<FoodModel> getFoodList() async {
    print(1);
    final apiResponse = await _apiProvider.getFoodlist();
    return apiResponse;
  }

  Future<dynamic> createFood() async {
    final apiResponse = await _apiProvider.createFood();
    return apiResponse;
  }

  Future<FoodModel> addMember(String username) async {
    await _apiProvider.addMember(username);
    final Food = await _apiProvider.getFoodlist();
    return Food;
  }

  Future<FoodModel> deleteMember(String username) async {
    await _apiProvider.deleteMember(username);
    final Food = await _apiProvider.getFoodlist();
    return Food;
  }
}
