import 'package:shop_app/screens/fridge/logic/models/models.dart';
import 'package:shop_app/screens/fridge/logic/provider/provider.dart';

class FridgeRepository {
  final FridgeAPIProvider _apiProvider = FridgeAPIProvider();

  FridgeRepository();

  Future<FridgeModel> getFridgeList() async {
    print(1);
    final apiResponse = await _apiProvider.getFridgelist();
    return apiResponse;
  }

  Future<dynamic> createFridge(
      String foodName, int useWithin, int quanlity, String note) async {
    await _apiProvider.createFridge(foodName, useWithin, quanlity, note);
    final fridges = _apiProvider.getFridgelist();
    return fridges;
  }

  Future<dynamic> updateFridge( String foodName, int useWithin, int quanlity, String note,int id) async {
    await _apiProvider.updateFridge(
       foodName, useWithin, quanlity, note,id);
    final food = _apiProvider.getFridgelist();
    return food;
  }

  Future<FridgeModel> deleteFridge(String name) async {
    await _apiProvider.deleteFridge(name);
    final fridges = await _apiProvider.getFridgelist();
    return fridges;
  }
}
