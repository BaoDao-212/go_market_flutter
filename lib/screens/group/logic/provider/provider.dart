import 'package:shop_app/screens/group/logic/models/member.dart';
import 'package:shop_app/screens/group/logic/models/models.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class GroupAPIProvider {
  Future<GroupModel> getMemberList() async {
    try {
      final response = await api.get("/user/group");
      List<Member> members = [];
      (response.data['members'] as List<dynamic>).forEach((m) {
        final Member user = Member.fromJson(m);
        members.add(user);
      });
      final user =
          GroupModel(id: response.data['groupAdmin'], members: members);
      return user;
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
      NotificationHelper.show(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<void> addMember(String username) async {
    print(username);
    try {
      print(api.options.baseUrl);
      final response = await api.post(
        "/user/group/add",
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
        "/user/group",
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
