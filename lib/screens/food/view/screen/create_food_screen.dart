import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/group/logic/bloc/bloc.dart';
import 'package:shop_app/screens/group/view/screen/group.screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class CreateGroupPage extends StatelessWidget {
  static const String routeName = "/group/create";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GroupBloc(),
          ),
        ],
        child: CreateGroupPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<GroupBloc, GroupState>(
      listenWhen: (_, curr) => curr is GroupCreateSuccessState,
      listener: (context, state) {
        Navigator.pushNamed(context, GroupScreen.routeName);
      },
      child: BlocBuilder<AuthCubit, User?>(
        builder: (context, user) {
          if (user == null) {
            Navigator.pushNamed(
              context,
              SplashScreen.routeName,
            );
          } else {
            if (user.groupId != 0) {
              Navigator.pushNamed(context, GroupScreen.routeName);
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Create Group'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  _createGroup(context);
                },
                child: Text('Create Group'),
              ),
            ),
          );
        },
      ),
    );
  }

  void _createGroup(BuildContext context) {
    BlocProvider.of<GroupBloc>(context).add(GroupCreateEvent(groupName: ''));
  }
}
