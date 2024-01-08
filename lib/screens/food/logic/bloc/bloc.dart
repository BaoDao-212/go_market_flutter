import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
part 'event.dart';
part 'state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodRepository repository = FoodRepository();

  FoodBloc() : super(FoodLoadInProgressState()) {
    on<FoodLoadedEvent>(_onFoodLoad);
    on<DataFoodLoadedEvent>(_onUnitCategoryLoad);
    on<FoodCreateEvent>(_onFoodCreate);
    on<FoodUpdateEvent>(_onFoodUpdate);
    on<FoodRemoveEvent>(_onFoodRemove);
  }

  FutureOr<void> _onFoodLoad(
      FoodLoadedEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      final FoodModel food = await repository.getFoodList();
      emit.call(FoodLoadSuccessState(food: food));
    } catch (e) {
      emit.call(FoodLoadFailureState());
    }
  }

  FutureOr<void> _onUnitCategoryLoad(
      DataFoodLoadedEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      final dynamic unitfood = await repository.getUnitName();
      final dynamic categoryFood = await repository.getCategoryFood();
      emit.call(DataLoadSuccessState(unit: unitfood, category: categoryFood));
    } catch (e) {
      emit.call(FoodLoadFailureState());
    }
  }

  FutureOr<void> _onFoodCreate(
      FoodCreateEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      final foods = await repository.createFood(
          event.name, event.foodCategoryName, event.unitName, event.image);
      emit.call(FoodLoadSuccessState(food: foods));
    } catch (e) {
      emit.call(FoodLoadFailureState());
    }
  }

  FutureOr<void> _onFoodUpdate(
      FoodUpdateEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      XFile? image = event.image;
      final foods = await repository.updateFood(event.name, event.newName,
          event.foodCategoryName, event.unitName, image != null ? image : null);
      emit.call(FoodLoadSuccessState(food: foods));
    } catch (e) {
      final FoodModel food = await repository.getFoodList();
      emit.call(FoodLoadSuccessState(food: food));
    }
  }

  FutureOr<void> _onFoodRemove(
      FoodRemoveEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      final food = await repository.deleteFood(event.name);
      emit.call(FoodLoadSuccessState(food: food));
    } catch (e) {
      emit.call(FoodLoadFailureState());
    }
  }
}
