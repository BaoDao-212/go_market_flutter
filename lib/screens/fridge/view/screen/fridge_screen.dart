import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/fridge/logic/bloc/bloc.dart';
import 'package:shop_app/screens/fridge/view/components/dialog/add.dart';
import 'package:shop_app/screens/fridge/view/components/dialog/delete.dart';
import 'package:shop_app/screens/fridge/view/components/dialog/update.dart';
import 'package:shop_app/screens/fridge/view/components/member.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class FridgeScreen extends StatelessWidget {
  static const String routeName = "/fridge";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FridgeBloc()..add(FridgeLoadedEvent()),
          ),
        ],
        child: FridgeScreen(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<FridgeBloc, FridgeState>(
      listenWhen: (_, curr) => curr is FridgeLoadSuccessState,
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
              title: Text('My Fridge'),
            ),
            body: BlocBuilder<FridgeBloc, FridgeState>(
              builder: (context, state) {
                if (state is FridgeLoadInProgressState) {
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
                              showAddFridgeDialog(context);
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
                              .read<FridgeBloc>()
                              .add(FridgeLoadedEvent()),
                          child: BlocBuilder<FridgeBloc, FridgeState>(
                            builder: (context, state) {
                              if (state is FridgeLoadSuccessState) {
                                print(state.fridge);
                                return ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 16.0),
                                  children:
                                      state.fridge.fridge.map<Widget>((f) {
                                    return FridgeCard(
                                      name: f.name,
                                      expiredDate: f.expiredDate,
                                      startDate: f.startDate,
                                      type: f.type,
                                      imageUrl: f.imageUrl,
                                      note: f.note,
                                      quantity: f.quantity,
                                      onDelete: () {
                                        _showDeleteFridgeDialog(
                                            context, f?.id, f?.name ?? '');
                                      },
                                      onUpdate: () {
                                        _showUpdateFridgeDialog(context, f);
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

  showAddFridgeDialog(BuildContext context) {
    final bloc = context.read<FridgeBloc>();
    return showDialog(
      context: context,
      builder: (_) => AddFridgeDialog(
        bloc: bloc,
      ),
    );
  }

  _showDeleteFridgeDialog(BuildContext context, int id, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteFridgeDialog(
        bloc: context.read<FridgeBloc>(),
        name: name,
      ),
    );
  }

  _showUpdateFridgeDialog(BuildContext context, dynamic fridge) {
    final bloc = context.read<FridgeBloc>();
    return showDialog(
      context: context,
      builder: (_) => UpdateFridgeDialog(
        bloc: bloc,
        fridgeItem: fridge,
      ),
    );
  }
}
