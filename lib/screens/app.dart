import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/logic/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:shop_app/screens/home/home_screen.dart';

final GlobalKey<NavigatorState> applicationKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InitProviders(
      child: MaterialApp(
        navigatorKey: applicationKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: appRouter.onGenerateRoute,
        theme: AppTheme.lightTheme(context),
      ),
    );
  }
}

class _InitProviders extends StatelessWidget {
  final Widget child;

  const _InitProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: BlocListener<AuthCubit, User?>(
          listenWhen: (prev, curr) => prev != null && curr == null,
          listener: (context, user) {
            final route = ModalRoute.of(context)?.settings.name;

            if (user == null && route != HomeScreen.routeName) {
              Navigator.pushNamedAndRemoveUntil(
                applicationKey.currentContext as BuildContext,
                HomeScreen.routeName,
                (route) => false,
              );
            }
          },
          child: child,
        ),
      ),
    );
  }
}
