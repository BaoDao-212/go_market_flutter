import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/constants.dart';
import 'package:http_parser/http_parser.dart';

class ProfileAPIProvider {
  Future<dynamic> getUser() async {
    try {
      final response = await api.get("${environments.api}/user");
      final user = User.fromJson(response.data);
      print(response.data);
      return user;
    } on DioError catch (e) {
      print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<dynamic> updateProfileWithFile(
      XFile? imageFile, String username) async {
    try {
      String fileName = imageFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "username": username,
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType('image', 'jpg'),
        ),
      });
      final response = await api.put("${environments.api}/user",
          data: formData, options: Options(contentType: 'image/jpg'));
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.data);
      // _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }
}
