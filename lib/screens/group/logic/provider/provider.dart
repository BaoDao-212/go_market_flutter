import 'package:shop_app/screens/shared/logic/http/api.dart';

class GroupAPIProvider {
  Future<dynamic> getMemberList() async {
    try {
      final response = await api.get("/member");
      return response.data;
    } on DioError catch (e) {
      print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }
}
