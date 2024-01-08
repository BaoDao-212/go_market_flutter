import 'package:shop_app/screens/recipe/logic/models/models.dart';
import 'package:shop_app/screens/recipe/logic/provider/provider.dart';

class RecipeRepository {
  final RecipeAPIProvider _apiProvider = RecipeAPIProvider();

  RecipeRepository();

  Future<RecipeModel> getRecipeList(int id) async {
    final apiResponse = await _apiProvider.getRecipelist(id);
    return apiResponse;
  }

  Future<dynamic> createRecipe(String name, String foodName, String htmlContent,
      String description) async {
    await _apiProvider.createRecipe(name, foodName, htmlContent, description);
    final fridges = await _apiProvider.getRecipelist(1);
    return fridges;
  }

  Future<RecipeModel> deleteRecipe(int id, int foodId) async {
    await _apiProvider.deleteRecipe(id);
    final fridges = await _apiProvider.getRecipelist(foodId);
    return fridges;
  }
}
