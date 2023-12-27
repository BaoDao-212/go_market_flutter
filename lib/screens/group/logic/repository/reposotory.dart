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
}
