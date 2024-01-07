import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import 'package:shop_app/screens/group/logic/repository/reposotory.dart';
import 'package:shop_app/screens/recipe/logic/models/models.dart';
import 'package:shop_app/screens/recipe/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeRepository repository = RecipeRepository();
  GroupRepository repositoryMember = GroupRepository();
  FoodRepository repositoryFood = FoodRepository();

  RecipeBloc() : super(RecipeLoadInProgressState()) {
    on<RecipeLoadedEvent>(_onRecipeLoad);
    on<DataFoodLoadedEvent>(_onFoodLoad);
    on<RecipeCreateEvent>(_onRecipeCreate);
    on<RecipeRemoveEvent>(_onRecipeRemove);
  }

  FutureOr<void> _onRecipeLoad(
      RecipeLoadedEvent event, Emitter<RecipeState> emit) async {
    emit.call(RecipeLoadInProgressState());
    try {
      final RecipeModel recipeModel = await repository.getRecipeList(event.id);
      final foods = await repositoryFood.getFoodList();
      emit.call(RecipeLoadSuccessState(recipe: recipeModel, food: foods));
    } catch (e) {
      emit.call(RecipeLoadFailureState());
    }
  }

  FutureOr<void> _onFoodLoad(
      DataFoodLoadedEvent event, Emitter<RecipeState> emit) async {
    emit.call(RecipeLoadInProgressState());
    try {
      final foods = await repositoryFood.getFoodList();
      emit.call(FoodLoadedSuccessState(foods: foods));
    } catch (e) {
      emit.call(RecipeLoadFailureState());
    }
  }

  FutureOr<void> _onRecipeCreate(
      RecipeCreateEvent event, Emitter<RecipeState> emit) async {
    emit.call(RecipeLoadInProgressState());
    try {
      final recipe = await repository.createRecipe(
          event.foodName, event.name, event.htmlContent, event.description);
      final foods = await repositoryFood.getFoodList();
      emit.call(RecipeLoadSuccessState(recipe: recipe, food: foods));
    } catch (e) {
      emit.call(RecipeLoadFailureState());
    }
  }

  FutureOr<void> _onRecipeRemove(
      RecipeRemoveEvent event, Emitter<RecipeState> emit) async {
    emit.call(RecipeLoadInProgressState());
    try {
      final recipe = await repository.deleteRecipe(event.id, event.foodId);
      final foods = await repositoryFood.getFoodList();
      emit.call(RecipeLoadSuccessState(recipe: recipe, food: foods));
    } catch (e) {
      emit.call(RecipeLoadFailureState());
    }
  }
}
