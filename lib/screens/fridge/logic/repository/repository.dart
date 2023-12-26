import 'package:shop_app/screens/profile/logic/provider/provider.dart';

class ProfileRepository {
  final ProfileAPIProvider _apiProvider = ProfileAPIProvider();

  ProfileRepository();

  Future<dynamic> getUser() async {
    final apiResponse = await _apiProvider.getUser();
    return apiResponse;
  }
}
