import 'package:shop_app/screens/shared/logic/http/api.dart';

class ProfileAPIProvider {
  Future<dynamic> getUser() async {
    try {
      final response = await api.get("/user");
      return response.data;
    } on DioError catch (e) {
      print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }
}
