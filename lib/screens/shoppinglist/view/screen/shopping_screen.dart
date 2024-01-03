import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart';
import 'package:shop_app/screens/shoppinglist/view/components/dialog/add.dart';
import 'package:shop_app/screens/shoppinglist/view/components/dialog/delete.dart';
import 'package:shop_app/screens/shoppinglist/view/components/dialog/update.dart';
import 'package:shop_app/screens/shoppinglist/view/components/shopping_card.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class ShoppingScreen extends StatelessWidget {
  static const String routeName = "/shoppping";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ShoppingBloc()..add(ShoppingLoadedEvent()),
          ),
        ],
        child: ShoppingScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ShoppingBloc, ShoppingState>(
      listenWhen: (_, curr) => curr is ShoppingLoadSuccessState,
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
              title: Text('My Shopping'),
            ),
            body: BlocBuilder<ShoppingBloc, ShoppingState>(
              builder: (context, state) {
                if (state is ShoppingLoadInProgressState) {
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
                              showAddShoppingDialog(context);
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
                          onRefresh: () async => context
                              .read<ShoppingBloc>()
                              .add(ShoppingLoadedEvent()),
                          child: BlocBuilder<ShoppingBloc, ShoppingState>(
                            builder: (context, state) {
                              if (state is ShoppingLoadSuccessState) {
                                print(state.shopping.shopping);
                                return ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 16.0),
                                  children:
                                      state.shopping.shopping.map<Widget>((f) {
                                    return ShoppingCard(
                                      name: f.name,
                                      date: f.date,
                                      tasks: f.tasks,
                                      note: f.note,
                                      onDelete: () {
                                        _showDeleteShoppingDialog(
                                            context, f?.id, f?.name ?? '');
                                      },
                                      onUpdate: () {
                                        _showUpdateShoppingDialog(context, f);
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

  showAddShoppingDialog(BuildContext context) {
    final bloc = context.read<ShoppingBloc>();
    return showDialog(
      context: context,
      builder: (_) => AddShoppingDialog(
        bloc: bloc,
      ),
    );
  }

  _showDeleteShoppingDialog(BuildContext context, int id, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteShoppingDialog(
        bloc: context.read<ShoppingBloc>(),
        name: name,
        id: id,
      ),
    );
  }

  _showUpdateShoppingDialog(BuildContext context, dynamic shoppping) {
    final bloc = context.read<ShoppingBloc>();
    return showDialog(
      context: context,
      builder: (_) => UpdateShoppingDialog(
        bloc: bloc,
        shoppingItem: shoppping,
      ),
    );
  }
}
