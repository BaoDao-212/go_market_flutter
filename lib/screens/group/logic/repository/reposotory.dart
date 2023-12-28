import 'package:shop_app/screens/group/logic/models/models.dart';
import 'package:shop_app/screens/group/logic/provider/provider.dart';

class GroupRepository {
  final GroupAPIProvider _apiProvider = GroupAPIProvider();

  GroupRepository();

  Future<dynamic> getMemberList() async {
    final apiResponse = await _apiProvider.getMemberList();
    return apiResponse;
  }

  Future<dynamic> createGroup() async {
    final apiResponse = await _apiProvider.createGroup();
    return apiResponse;
  }

  Future<GroupModel> addMember(String username) async {
     await _apiProvider.addMember(username);
    final group = await _apiProvider.getMemberList();
    return group;
  }

  Future<GroupModel> deleteMember(String username) async {
   await _apiProvider.deleteMember(username);
    final group = await _apiProvider.getMemberList();
    return group;
  }
}
