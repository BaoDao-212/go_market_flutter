import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/view/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/profile/logic/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/app_export.dart';
import 'package:shop_app/screens/profile/view/components/profile_screen.dart';
import 'package:shop_app/screens/shared/view/widgets/custom_avatar_icon.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/alert_dialog_widget.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileScreen extends StatefulWidget {
  static const String routeName = '/my_account'; // Add routeName
  static route() => MaterialPageRoute(builder: (_) => MyProfileScreen());

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyProfileScreen> {
  final _repository = ProfileRepository();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _avatarController = TextEditingController();
  late final XFile? photo;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = await _repository.getUser();
      print(user);
      setState(() {
        if (user != null) {
          _usernameController.text = user.username;
          _emailController.text = user.email ?? '';
          _nameController.text = user.name ?? '';
          _avatarController.text = user.photoUrl ?? '';
        }
      });
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, User?>(
      builder: (context, user) {
        if (user == null) {
          Navigator.pushNamed(
            context,
            SplashScreen.routeName,
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text('Update Profile'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ),
            body: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarWithCameraIcon(
                            imageUrl: _avatarController.text,
                            onImageChanged: (dynamic imagePath) {
                              photo = imagePath;
                            },
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          MainTextField(
                            label: 'Full name',
                            hintText: 'Please enter your full name',
                            controller: _nameController,
                            usernameField: true,
                            readOnly: true,
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          MainTextField(
                            label: 'Username',
                            hintText: 'Please enter your username',
                            controller: _usernameController,
                            usernameField: true,
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          MainTextField(
                            label: 'Email',
                            hintText: 'Please enter your email',
                            controller: _emailController,
                            emailField: true,
                            readOnly: true,
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          IconTextButton(
                            text: 'Update profile',
                            onPressed: () async {
                              await _update();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()),
                              );
                            },
                          )
                        ],
                      ))
                ]));
      },
    );
  }

  _update() async {
    setState(() {
      _loading = true;
    });

    try {
      await _repository.updateProfileWithFile(photo!, _usernameController.text);

      await showDialog(
        context: context,
        builder: (_) => AlertDialogWidget(
          title: 'Good job!',
          description: 'Your profile was sucessfully updated!',
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
