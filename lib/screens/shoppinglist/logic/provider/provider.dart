import 'package:connectivity/connectivity.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';
import 'package:shop_app/screens/shoppinglist/logic/local_db/shopping.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/member.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/models.dart';

class ShoppingAPIProvider {
  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<dynamic> getShoppinglist() async {
    print(await isConnectedToNetwork());
    if (await isConnectedToNetwork()) {
      final response = await api.get("/shopping/task");
      List<Shopping> shoppings = [];
      (response.data['list'] as List<dynamic>).forEach((m) {
        final Shopping shopping = Shopping.fromJson(m);
        shoppings.add(shopping);
      });
      final f = ShoppingModel(shopping: shoppings);
      await DatabaseShopping.getShoppings().then((localShoppings) async {
        print(localShoppings);
        // DatabaseShopping.deleteAllShoppings();
        if (localShoppings.isEmpty) {
          for (final shopping in localShoppings) {
            await DatabaseShopping.insertShopping(shopping);
          }
        }
      });
      final localShoppings = await DatabaseShopping.getShoppings();
      print(localShoppings.length);
      return f;
    } else {
      print(123);
      final localShoppings = await DatabaseShopping.getShoppings();
      print(localShoppings);
      final f = ShoppingModel(shopping: localShoppings);
      return f;
    }
  }

  Future<dynamic> createTask(int listId, String foodName, int quantity) async {
    print({"foodName": foodName, "quantity": quantity});
    final response = await api.post(
      "/shopping/task",
      data: {
        "listId": listId,
        "tasks": [
          {"foodName": foodName, "quantity": quantity}
        ]
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<dynamic> createShopping(
      String name, String assignToUsername, String note, String date) async {
    final response = await api.post(
      "/shopping",
      data: {
        'name': name,
        'assignToUsername': assignToUsername,
        'note': note,
        'date': date,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<dynamic> updateShopping(int id, String name, String assignToUsername,
      String note, String date) async {
    final response = await api.put(
      "/shopping",
      data: {
        'listId': id,
        'newName': name,
        'newAssignToUsername': assignToUsername,
        'newDate': date,
        'newNote': note,
      },
    );
    NotificationHelper.show(
      response.data['resultMessage']['en'],
      "SUCCESS",
    );
    return response.data;
  }

  Future<void> deleteShopping(int id) async {
    final response = await api.delete(
      "/shopping",
      data: {
        'listId': id,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<void> deleteTask(int id) async {
    final response = await api.delete(
      "/shopping/task",
      data: {
        'taskId': id,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<void> updateTask(
      int taskId, String newFoodName, int newQuantity) async {
    var data;
    if (newFoodName == '')
      data = {
        'taskId': taskId,
        'newQuantity': newQuantity,
      };
    else
      data = {
        'taskId': taskId,
        'newFoodName': newFoodName,
        'newQuantity': newQuantity,
      };
    final response = await api.put(
      "/shopping/task",
      data: data,
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<void> updateTaskState(int taskId, int newDone) async {
    final response = await api.put(
      "/shopping/task/mark",
      data: {
        'taskId': taskId,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }
}
