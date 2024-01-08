import 'package:connectivity/connectivity.dart';
import 'package:shop_app/screens/food/logic/local_db/food.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class FoodAPIProvider {
  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<FoodModel> getFoodlist() async {
    if (await isConnectedToNetwork()) {
      final response = await api.get("/food");
      List<Food> foods = [];
      print(response.data);
      (response.data['foods'] as List<dynamic>).forEach((m) {
        final Food food = Food.fromJson(m);
        foods.add(food);
      });
      final f = FoodModel(foods: foods);
      await DatabaseFood.getFoods().then((localFoods) async {
        DatabaseFood.deleteAllFoods();
        if (localFoods.isEmpty) {
          for (final food in foods) {
            await DatabaseFood.insertFood(food);
          }
        }
      });
      return f;
    } else {
      final localFoods = await DatabaseFood.getFoods();
      final f = FoodModel(foods: localFoods);
      return f;
    }
  }

  Future<dynamic> getUnitName() async {
    final response = await api.get("/food/unit");
    return response.data['units'];
  }

  Future<dynamic> getCategoryFood() async {
    final response = await api.get("/food/category");
    return response.data['categories'];
  }

  Future<dynamic> createFood(String name, String foodCategoryName,
      String unitName, XFile image) async {
    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": name,
      "foodCategoryName": foodCategoryName,
      "unitName": unitName,
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        contentType: MediaType('image', 'jpg'),
      ),
    });
    final response = await api.post("/food",
        data: formData, options: Options(contentType: 'image/jpg'));
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<dynamic> updateFood(String name, String newName,
      String foodCategoryName, String unitName, dynamic image) async {
    FormData formData;
    if (image == null) {
      formData = FormData.fromMap({
        "name": name,
        "newCategory": foodCategoryName,
        "newUnit": unitName,
        "newName": newName,
      });
    } else {
      String fileName = image.path.split('/').last;
      formData = FormData.fromMap({
        "name": name,
        "newCategory": foodCategoryName,
        "newUnit": unitName,
        "newName": newName,
        "image": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'jpg'),
        ),
      });
    }
    final response = await api.put(
      "/food",
      data: formData,
      options: Options(contentType: 'image/jpg'),
    );
    NotificationHelper.show(
      response.data['resultMessage']['en'],
      "SUCCESS",
    );
    return response.data;
  }

  Future<void> deleteFood(String name) async {
    final response = await api.delete(
      "/food",
      data: {
        'name': name,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }
}
