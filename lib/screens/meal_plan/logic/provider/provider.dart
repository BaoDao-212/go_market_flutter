import 'package:connectivity/connectivity.dart';
import 'package:shop_app/screens/meal_plan/logic/local_db/shopping.dart';
import 'package:shop_app/screens/meal_plan/logic/models/member.dart';
import 'package:shop_app/screens/meal_plan/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class MealPlanAPIProvider {
  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<dynamic> getMealPlanlist(String date) async {
    print(await isConnectedToNetwork());
    if (await isConnectedToNetwork()) {
      final response = await api.get("/meal?date=${date}");
      print(response.data);
      List<MealPlan> mealPlans = [];
      (response.data['plans'] as List<dynamic>).forEach((m) {
        final MealPlan mealPlan = MealPlan.fromJson(m);
        mealPlans.add(mealPlan);
      });
      final f = MealPlanModel(mealPlan: mealPlans);
      await DatabaseMealPlan.getMealPlans().then((localMealPlans) async {
        print(localMealPlans);
        // DatabaseMealPlan.deleteAllMealPlans();
        if (localMealPlans.isEmpty) {
          for (final mealPlan in localMealPlans) {
            await DatabaseMealPlan.insertMealPlan(mealPlan);
          }
        }
      });
      final localMealPlans = await DatabaseMealPlan.getMealPlans();
      print(localMealPlans.length);
      return f;
    } else {
      final localMealPlans = await DatabaseMealPlan.getMealPlans();
      print(localMealPlans);
      final f = MealPlanModel(mealPlan: localMealPlans);
      return f;
    }
  }

  Future<dynamic> createMealPlan(
      String foodName, String timestamp, String name) async {
    final response = await api.post(
      "/meal",
      data: {
        'name': name,
        'timestamp': timestamp,
        'foodName': foodName,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<dynamic> updateMealPlan(
      int id, String name, String foodName, String timestamp) async {
    print({
      'planId': id,
      'newName': name,
      'newFoodName': foodName,
      'newTimeStamp': timestamp,
    });
    final response = await api.put(
      "/meal",
      data: {
        'planId': id,
        'newName': name,
        'newFoodName': foodName,
        'newTimestamp': timestamp,
      },
    );
    NotificationHelper.show(
      response.data['resultMessage']['en'],
      "SUCCESS",
    );
    return response.data;
  }

  Future<void> deleteMealPlan(int id) async {
    final response = await api.delete(
      "/meal",
      data: {
        'planId': id,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }
}
