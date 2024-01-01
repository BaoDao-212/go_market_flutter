import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import 'package:shop_app/screens/fridge/logic/models/models.dart';
import 'package:shop_app/screens/fridge/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class FridgeBloc extends Bloc<FridgeEvent, FridgeState> {
  FridgeRepository repository = FridgeRepository();
  FoodRepository repositoryFood = FoodRepository();

  FridgeBloc() : super(FridgeLoadInProgressState()) {
    on<FridgeLoadedEvent>(_onFridgeLoad);
    on<DataFoodLoadedEvent>(_onFoodLoad);
    on<FridgeCreateEvent>(_onFridgeCreate);
    on<FridgeUpdateEvent>(_onFridgeUpdate);
    on<FridgeRemoveEvent>(_onFridgeRemove);
  }

  FutureOr<void> _onFridgeLoad(
      FridgeLoadedEvent event, Emitter<FridgeState> emit) async {
    emit.call(FridgeLoadInProgressState());
    try {
      final FridgeModel fridge = await repository.getFridgeList();
      emit.call(FridgeLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(FridgeLoadFailureState());
    }
  }

  FutureOr<void> _onFoodLoad(
      DataFoodLoadedEvent event, Emitter<FridgeState> emit) async {
    emit.call(FridgeLoadInProgressState());
    try {
      final FoodModel food = await repositoryFood.getFoodList();
      emit.call(FoodLoadedSuccessState(foods: food));
    } catch (e) {
      emit.call(FridgeLoadFailureState());
    }
  }

  FutureOr<void> _onFridgeCreate(
      FridgeCreateEvent event, Emitter<FridgeState> emit) async {
    emit.call(FridgeLoadInProgressState());
    try {
      print(event.foodName);
      print(event.useWithin);
      print(event.quantity);
      final fridge = await repository.createFridge(
          event.foodName, event.useWithin, event.quantity, event.note);
      emit.call(FridgeLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(FridgeLoadFailureState());
    }
  }

  FutureOr<void> _onFridgeUpdate(
      FridgeUpdateEvent event, Emitter<FridgeState> emit) async {
    emit.call(FridgeLoadInProgressState());
    try {
      final f = await repository.updateFridge(event.foodName, event.useWithin,
          event.quantity, event.note, event.id);
      emit.call(FridgeLoadSuccessState(fridge: f));
    } catch (e) {
      final FridgeModel f = await repository.getFridgeList();
      emit.call(FridgeLoadSuccessState(fridge: f));
    }
  }

  FutureOr<void> _onFridgeRemove(
      FridgeRemoveEvent event, Emitter<FridgeState> emit) async {
    emit.call(FridgeLoadInProgressState());
    try {
      final fridge = await repository.deleteFridge(event.name);
      emit.call(FridgeLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(FridgeLoadFailureState());
    }
  }
}
