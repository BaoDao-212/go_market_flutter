// Import các thư viện cần thiết
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/notification/logic/bloc/bloc.dart';
import 'package:shop_app/screens/notification/view/components/member.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "/notification";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NotificationBloc()..add(NotificationLoadedEvent()),
          ),
        ],
        child: NotificationScreen(),
      );
    });
  }

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<RemoteMessage> notifications = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<NotificationBloc, NotificationState>(
      listenWhen: (_, curr) => curr is NotificationLoadSuccessState,
      listener: (context, state) {},
      child: BlocBuilder<AuthCubit, User?>(
        builder: (context, user) {
          if (user == null) {
            Navigator.pushNamed(
              context,
              SplashScreen.routeName,
            );
            return Container();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Notification'),
            ),
            body: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoadInProgressState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: RefreshIndicator(
                          onRefresh: () async => context
                              .read<NotificationBloc>()
                              .add(NotificationLoadedEvent()),
                          child:
                              BlocBuilder<NotificationBloc, NotificationState>(
                            builder: (context, state) {
                              if (state is NotificationLoadSuccessState) {
                                return ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 16.0),
                                  children: state.notification.map<Widget>((f) {
                                    return NotificationCard(
                                        title: f.title,
                                        body: f.body,
                                        date: f.date);
                                  }).toList(),
                                );
                              } else {
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
}
