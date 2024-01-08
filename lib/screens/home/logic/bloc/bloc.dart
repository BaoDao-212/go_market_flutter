import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/meal_plan/logic/models/models.dart';
import 'package:shop_app/screens/meal_plan/logic/repository/reposotory.dart';
import 'package:shop_app/screens/recipe/logic/models/models.dart';
import 'package:shop_app/screens/recipe/logic/repository/reposotory.dart';
part 'event.dart';
part 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  MealPlanRepository repository = MealPlanRepository();
  RecipeRepository repositoryR = RecipeRepository();

  HomeBloc() : super(HomeLoadInProgressState()) {
    on<HomeLoadedEvent>(_onHomeLoad);
  }

  FutureOr<void> _onHomeLoad(
      HomeLoadedEvent event, Emitter<HomeState> emit) async {
    emit.call(HomeLoadInProgressState());
    try {
      final MealPlanModel mealPlanModel = await repository
          .getMealPlanList(DateFormat('MM/dd/yyyy').format(DateTime.now()));
      final RecipeModel recipeModel = await repositoryR.getRecipeList(1);
      emit.call(
          HomeLoadSuccessState(mealPlan: mealPlanModel, recipe: recipeModel));
    } catch (e) {
      emit.call(HomeLoadFailureState());
    }
  }
}
