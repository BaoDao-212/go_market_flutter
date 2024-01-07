import 'package:connectivity/connectivity.dart';
import 'package:shop_app/screens/recipe/logic/local_db/shopping.dart';
import 'package:shop_app/screens/recipe/logic/models/member.dart';
import 'package:shop_app/screens/recipe/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class RecipeAPIProvider {
  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<dynamic> getRecipelist(int id) async {
    print(await isConnectedToNetwork());
    if (await isConnectedToNetwork()) {
      final response = await api.get("/recipe?foodId=${id}");
      List<Recipe> recipes = [];
      print(response.data);
      (response.data['recipes'] as List<dynamic>).forEach((m) {
        final Recipe recipe = Recipe.fromJson(m);
        recipes.add(recipe);
      });
      final f = RecipeModel(recipe: recipes);
      // await DatabaseRecipe.getRecipes().then((localRecipes) async {
      //   print(localRecipes);
      //   // DatabaseRecipe.deleteAllRecipes();
      //   if (localRecipes.isEmpty) {
      //     for (final recipe in localRecipes) {
      //       await DatabaseRecipe.insertRecipe(recipe);
      //     }
      //   }
      // });
      // final localRecipes = await DatabaseRecipe.getRecipes();
      // print(localRecipes.length);
      return f;
    } else {
      final localRecipes = await DatabaseRecipe.getRecipes();
      print(localRecipes);
      final f = RecipeModel(recipe: localRecipes);
      return f;
    }
  }

  Future<dynamic> createRecipe(String foodName, String description,
      String htmlContent, String name) async {
    final response = await api.post(
      "/recipe",
      data: {
        'name': name,
        'description': description,
        'htmlContent': htmlContent,
        'foodName': foodName,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<void> deleteRecipe(int id) async {
    final response = await api.delete(
      "/recipe",
      data: {
        'recipeId': id,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }
}
