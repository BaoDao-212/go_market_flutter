import 'package:flutter/material.dart';
import 'package:shop_app/screens/app.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/profile/logic/provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileRepository {
  final ProfileAPIProvider _apiProvider = ProfileAPIProvider();

  ProfileRepository();

  Future<dynamic> getUser() async {
    final apiResponse = await _apiProvider.getUser();
    return apiResponse;
  }

  Future<dynamic> updateProfileWithFile(
      XFile imageFile, String username) async {
    await _apiProvider.updateProfileWithFile(imageFile, username);
    return 1;
  }
}
