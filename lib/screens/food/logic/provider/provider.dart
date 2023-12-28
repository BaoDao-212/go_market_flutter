import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class FoodAPIProvider {
  Future<FoodModel> getFoodlist() async {
    try {
      final response = await api.get("/food");
      List<Food> foods = [];
      (response.data['foods'] as List<dynamic>).forEach((m) {
        final Food food = Food.fromJson(m);
        foods.add(food);
      });
      final f = FoodModel(foods: foods);
      return f;
    } on DioError catch (e) {
      print(e.response?.data);
      NotificationHelper.show(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<dynamic> createFood() async {
    try {
      final response = await api.post("/food");
      NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
      return;
    } on DioError catch (e) {
      print(e.response?.data);
      NotificationHelper.show(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<void> addMember(String username) async {
    print(username);
    try {
      print(api.options.baseUrl);
      final response = await api.post(
        "/user/Food/add",
        data: {
          'username': username,
        },
      );
      print(1);
      NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
      print(response.data);

      return;
    } on DioError catch (e) {
      print(e.response?.data);
      NotificationHelper.show(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<void> deleteMember(String username) async {
    try {
      final response = await api.delete(
        "/user/Food",
        data: {
          'username': username,
        },
      );
      NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
      return;
    } on DioError catch (e) {
      print(e.response?.data);
      NotificationHelper.show(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }
}
