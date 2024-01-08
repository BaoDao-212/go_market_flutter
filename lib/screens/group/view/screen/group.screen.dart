import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/group/logic/bloc/bloc.dart';
import 'package:shop_app/screens/group/view/components/dialog/add_member.dart';
import 'package:shop_app/screens/group/view/components/dialog/delete_member.dart';
import 'package:shop_app/screens/group/view/components/member.dart';
import 'package:shop_app/screens/home/view/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class GroupScreen extends StatelessWidget {
  static const String routeName = "/group";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GroupBloc()..add(GroupLoadedEvent()),
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
            return Container(); // Return an empty container if user is null
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Group'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
            ),
            body: BlocBuilder<GroupBloc, GroupState>(
              builder: (context, state) {
                if (state is GroupLoadInProgressState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 24.0),
                        child: SizedBox(
                          width: 100.0,
                          child: ElevatedButton(
                            onPressed: () {
                              showAddMemberDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 4,
                              primary: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 8.0),
                                Text('Add'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              context.read<GroupBloc>().add(GroupLoadedEvent()),
                          child: BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                              if (state is GroupLoadSuccessState) {
                                return ListView(
                                  children: (state.group.members
                                      .map<Widget>((member) {
                                    return MemberCard(
                                      name: member?.name,
                                      photoUrl: member?.photoUrl,
                                      id: member?.id,
                                      showDeleteButton:
                                          !(member.id == state.group.id),
                                      onDelete: () {
                                        print(member.name);
                                        print(member?.username);
                                        _showDeleteMemberDialog(context,
                                            member?.username, member?.name);
                                      },
                                    );
                                  })).toList(),
                                );
                              } else {
                                // Handle other states if needed
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  showAddMemberDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AddMemberDialog(bloc: context.read<GroupBloc>()),
    );
  }

  _showDeleteMemberDialog(BuildContext context, String username, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteMemberDialog(
        bloc: context.read<GroupBloc>(),
        name: name,
        username: username,
      ),
    );
  }
}
