import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/food/logic/bloc/bloc.dart';
import 'package:shop_app/screens/food/view/components/dialog/add_food.dart';
import 'package:shop_app/screens/food/view/components/dialog/delete_food.dart';
import 'package:shop_app/screens/food/view/components/dialog/update_food.dart';
import 'package:shop_app/screens/food/view/components/member.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class FoodScreen extends StatelessWidget {
  static const String routeName = "/food";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FoodBloc()..add(FoodLoadedEvent()),
          ),
        ],
        child: FoodScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<FoodBloc, FoodState>(
      listenWhen: (_, curr) => curr is FoodLoadSuccessState,
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
              title: Text('My Food'),
            ),
            body: BlocBuilder<FoodBloc, FoodState>(
              builder: (context, state) {
                if (state is FoodLoadInProgressState) {
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
                              showAddFoodDialog(context);
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
                              context.read<FoodBloc>().add(FoodLoadedEvent()),
                          child: BlocBuilder<FoodBloc, FoodState>(
                            builder: (context, state) {
                              if (state is FoodLoadSuccessState) {
                                return ListView(
                                  children: state.food.foods.map<Widget>((f) {
                                    return FoodCard(
                                      name: f?.name ?? '',
                                      imageUrl: f?.imageUrl ?? '',
                                      category: f?.categoryName ?? '',
                                      unitName: f?.unitName ?? '',
                                      onDelete: () {
                                        _showDeleteFoodDialog(
                                            context, f?.id, f?.name ?? '');
                                      },
                                      onUpdate: () {
                                        _showUpdateFoodDialog(context, f);
                                      },
                                    );
                                  }).toList(),
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

  showAddFoodDialog(BuildContext context) {
    final bloc = context.read<FoodBloc>();
    return showDialog(
      context: context,
      builder: (_) => AddFoodDialog(
        bloc: bloc,
      ),
    );
  }

  _showDeleteFoodDialog(BuildContext context, int id, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteFoodDialog(
        bloc: context.read<FoodBloc>(),
        name: name,
      ),
    );
  }

  _showUpdateFoodDialog(BuildContext context, dynamic food) {
    final bloc = context.read<FoodBloc>();
    return showDialog(
      context: context,
      builder: (_) => UpdateFoodDialog(
        bloc: bloc,
        oldFood: food,
      ),
    );
  }
}
