import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import 'package:shop_app/screens/group/logic/repository/reposotory.dart';
import 'package:shop_app/screens/meal_plan/logic/models/models.dart';
import 'package:shop_app/screens/meal_plan/logic/repository/reposotory.dart';
part 'event.dart';
part 'state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  MealPlanRepository repository = MealPlanRepository();
  GroupRepository repositoryMember = GroupRepository();
  FoodRepository repositoryFood = FoodRepository();

  MealPlanBloc() : super(MealPlanLoadInProgressState()) {
    on<MealPlanLoadedEvent>(_onMealPlanLoad);
    on<DataFoodLoadedEvent>(_onFoodLoad);
    on<MealPlanCreateEvent>(_onMealPlanCreate);
    on<MealPlanUpdateEvent>(_onMealPlanUpdate);
    on<MealPlanRemoveEvent>(_onMealPlanRemove);
  }

  FutureOr<void> _onMealPlanLoad(
      MealPlanLoadedEvent event, Emitter<MealPlanState> emit) async {
    emit.call(MealPlanLoadInProgressState());
    try {
      final MealPlanModel mealPlanModel =
          await repository.getMealPlanList(event.date);
      emit.call(MealPlanLoadSuccessState(mealPlan: mealPlanModel));
    } catch (e) {
      emit.call(MealPlanLoadFailureState());
    }
  }

  FutureOr<void> _onFoodLoad(
      DataFoodLoadedEvent event, Emitter<MealPlanState> emit) async {
    emit.call(MealPlanLoadInProgressState());
    try {
      final foods = await repositoryFood.getFoodList();
      emit.call(FoodLoadedSuccessState(foods: foods));
    } catch (e) {
      emit.call(MealPlanLoadFailureState());
    }
  }

  FutureOr<void> _onMealPlanCreate(
      MealPlanCreateEvent event, Emitter<MealPlanState> emit) async {
    emit.call(MealPlanLoadInProgressState());
    try {
      final mealPlan = await repository.createMealPlan(
          event.foodName, event.timestamp, event.name, event.date);
      emit.call(MealPlanLoadSuccessState(mealPlan: mealPlan));
    } catch (e) {
      emit.call(MealPlanLoadFailureState());
    }
  }

  FutureOr<void> _onMealPlanUpdate(
      MealPlanUpdateEvent event, Emitter<MealPlanState> emit) async {
    emit.call(MealPlanLoadInProgressState());
    try {
      final f = await repository.updateMealPlan(
          event.id, event.name, event.foodName, event.timestamp, event.date);
      emit.call(MealPlanLoadSuccessState(mealPlan: f));
    } catch (e) {
      final MealPlanModel f = await repository.getMealPlanList(event.date);
      emit.call(MealPlanLoadSuccessState(mealPlan: f));
    }
  }

  FutureOr<void> _onMealPlanRemove(
      MealPlanRemoveEvent event, Emitter<MealPlanState> emit) async {
    emit.call(MealPlanLoadInProgressState());
    try {
      final mealPlan = await repository.deleteMealPlan(event.id, event.date);
      emit.call(MealPlanLoadSuccessState(mealPlan: mealPlan));
    } catch (e) {
      emit.call(MealPlanLoadFailureState());
    }
  }
}
