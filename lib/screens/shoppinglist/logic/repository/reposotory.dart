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

  Future<dynamic> createTask(int listId, String foodName, int quantity) async {
    await _apiProvider.createTask(listId, foodName, quantity);
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

  Future<ShoppingModel> deleteTask(int id) async {
    await _apiProvider.deleteTask(id);
    final fridges = await _apiProvider.getShoppinglist();
    return fridges;
  }

  Future<ShoppingModel> updateTask(
      int id, String foodName, int quantity) async {
    await _apiProvider.updateTask(id, foodName, quantity);
    final fridges = await _apiProvider.getShoppinglist();
    return fridges;
  }

  Future<ShoppingModel> updateTaskState(int id, int done) async {
    await _apiProvider.updateTaskState(id, done);
    final fridges = await _apiProvider.getShoppinglist();
    return fridges;
  }
}
