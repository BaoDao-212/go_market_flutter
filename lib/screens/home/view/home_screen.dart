import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/core/app_export.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/home/logic/bloc/bloc.dart';
import 'package:shop_app/size_config.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc()..add(HomeLoadedEvent()),
          ),
        ],
        child: HomeScreen(),
      );
    });
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SizeConfig().init(context);
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadInProgressState) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          } else if (state is HomeLoadSuccessState) {
            return Body(
              mealPlan: state.mealPlan.mealPlan,
              recipe: state.recipe.recipe,
            );
          } else
            return Container();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
