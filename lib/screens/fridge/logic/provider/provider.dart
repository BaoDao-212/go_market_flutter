import 'package:connectivity/connectivity.dart';
import 'package:shop_app/screens/fridge/logic/local_db/fridge.dart';
import 'package:shop_app/screens/fridge/logic/models/member.dart';
import 'package:shop_app/screens/fridge/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class FridgeAPIProvider {
  Future<bool> isConnectedToNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<FridgeModel> getFridgelist() async {
    if (await isConnectedToNetwork()) {
      final response = await api.get("/fridge");
      List<Fridge> fridges = [];
      (response.data['fridgeItems'] as List<dynamic>).forEach((m) {
        final Fridge fridge = Fridge.fromJson(m);
        fridges.add(fridge);
      });
      final f = FridgeModel(fridge: fridges);
      print(f);
      await DatabaseFridge.getFridges().then((localFridges) async {
        DatabaseFridge.deleteAllFridges();
        if (localFridges.isEmpty) {
          for (final fridge in fridges) {
            await DatabaseFridge.insertFridge(fridge);
          }
        }
      });
      return f;
    } else {
      final localFridges = await DatabaseFridge.getFridges();
      final f = FridgeModel(fridge: localFridges);
      return f;
    }
  }

  Future<dynamic> createFridge(
      String foodName, int useWithin, int quantity, String note) async {
    final response = await api.post(
      "/fridge",
      data: {
        'foodName': foodName,
        'useWithin': useWithin,
        'quantity': quantity,
        'note': note,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }

  Future<dynamic> updateFridge(
      String foodName, int useWithin, int quantity, String note, int id) async {
    final response = await api.put(
      "/fridge",
      data: {
        'itemId': id,
        'newFoodName': foodName,
        'newUseWithin': useWithin,
        'newQuantity': quantity,
        'newNote': note,
      },
    );
    NotificationHelper.show(
      response.data['resultMessage']['en'],
      "SUCCESS",
    );
    return response.data;
  }

  Future<void> deleteFridge(String name) async {
    print(name);
    final response = await api.delete(
      "/fridge",
      data: {
        'foodName': name,
      },
    );
    NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
    return;
  }
}
