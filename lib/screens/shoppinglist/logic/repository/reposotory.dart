import 'package:shop_app/screens/shoppinglist/logic/models/models.dart';
import 'package:shop_app/screens/shoppinglist/logic/provider/provider.dart';

class ShoppingRepository {
  final ShoppingAPIProvider _apiProvider = ShoppingAPIProvider();

  ShoppingRepository();

  Future<ShoppingModel> getShoppingList() async {
    final apiResponse = await _apiProvider.getShoppinglist();
    return apiResponse;
  }

  Future<dynamic> createShopping(
      String name, String assignToUsername, String note, String date) async {
    await _apiProvider.createShopping(name, assignToUsername, note, date);
    final fridges = _apiProvider.getShoppinglist();
    return fridges;
  }

  Future<dynamic> updateShopping(int id, String name, String assignToUsername,
      String note, String date) async {
    await _apiProvider.updateShopping(id, name, assignToUsername, note, date);
    final shopping = _apiProvider.getShoppinglist();
    return shopping;
  }

  Future<ShoppingModel> deleteShopping(int id) async {
    await _apiProvider.deleteShopping(id);
    final fridges = await _apiProvider.getShoppinglist();
    return fridges;
  }
}
