import 'package:shop_app/screens/group/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class GroupAPIProvider {
  Future<dynamic> getMemberList() async {
    try {
      final response = await api.get("/user/group");
      print(response.data);
      return;
      // final user = GroupModel(id: response.data, members: members);
    } on DioError catch (e) {
      print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<dynamic> createGroup() async {
    print(4);
    try {
      final response = await api.post("/user/group");
      final group = GroupModel(id: 1, members: []);
      NotificationHelper.show(response.data['resultMessage']['en'], "SUCCESS");
      return group;
    } on DioError catch (e) {
      print(e.response?.data);
      NotificationHelper.show(
          e.response?.data['resultMessage']['en'], "SUCCESS");
      rethrow;
    }
  }

  Future<void> addMember() async {
    try {
      // final response = await api.post("user/member/add",data: );
      // print(response.data);
      return;
    } on DioError catch (e) {
      // print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<void> deleteMember() async {
    try {
      // final response = await api.delete("user/member/add",data: );
      // print(response.data);
      return;
    } on DioError catch (e) {
      // print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }
}
