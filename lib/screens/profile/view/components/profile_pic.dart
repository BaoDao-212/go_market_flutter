import 'package:flutter/material.dart';
import 'package:shop_app/screens/profile/logic/repository/repository.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String avatar = '';
  final _repository = ProfileRepository();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = await _repository.getUser();
      print(user);
      if (user != null) {
        setState(() {
          avatar = user.photoUrl ?? '';
        });
      }
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: avatar.isNotEmpty
                ? NetworkImage(avatar)
                : NetworkImage(
                    'https://example.com/placeholder.png'), // Replace with a placeholder image URL
          ),
        ],
      ),
    );
  }
}
