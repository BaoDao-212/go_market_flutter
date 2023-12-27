import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/group/logic/bloc/bloc.dart';
import 'package:shop_app/screens/group/view/components/member.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class GroupScreen extends StatelessWidget {
  static const String routeName = "/group";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GroupBloc(),
          ),
        ],
        child: GroupScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<GroupBloc, GroupState>(
      listenWhen: (_, curr) => curr is GroupLoadSuccessState,
      listener: (context, state) {},
      child: BlocBuilder<AuthCubit, User?>(
        builder: (context, user) {
          if (user == null) {
            Navigator.pushNamed(
              context,
              SplashScreen.routeName,
            );
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('My Group'),
              ),
              body: ListView(
                children: [
                  MemberCard(
                    name: 'John Doe',
                    photoUrl: 'https://example.com/john.jpg',
                    id: '123456',
                    onDelete: () {
                      print('Delete user');
                    },
                  ),
                  // Thêm các UserCard khác tại đây nếu cần
                ],
              ));
        },
      ),
    );
  }
}
