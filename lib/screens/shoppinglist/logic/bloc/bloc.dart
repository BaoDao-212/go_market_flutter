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

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingRepository repository = ShoppingRepository();
  FoodRepository repositoryFood = FoodRepository();

  ShoppingBloc() : super(ShoppingLoadInProgressState()) {
    on<ShoppingLoadedEvent>(_onShoppingLoad);
    on<DataFoodLoadedEvent>(_onFoodLoad);
    on<ShoppingCreateEvent>(_onShoppingCreate);
    on<ShoppingUpdateEvent>(_onShoppingUpdate);
    on<ShoppingRemoveEvent>(_onShoppingRemove);
  }

  FutureOr<void> _onShoppingLoad(
      ShoppingLoadedEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final ShoppingModel fridge = await repository.getShoppingList();
      emit.call(ShoppingLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onFoodLoad(
      DataFoodLoadedEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final FoodModel food = await repositoryFood.getFoodList();
      emit.call(FoodLoadedSuccessState(foods: food));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onShoppingCreate(
      ShoppingCreateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      print(event.foodName);
      print(event.useWithin);
      print(event.quantity);
      final fridge = await repository.createShopping(
          event.foodName, event.useWithin, event.quantity, event.note);
      emit.call(ShoppingLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onShoppingUpdate(
      ShoppingUpdateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final f = await repository.updateShopping(event.foodName, event.useWithin,
          event.quantity, event.note, event.id);
      emit.call(ShoppingLoadSuccessState(fridge: f));
    } catch (e) {
      final ShoppingModel f = await repository.getShoppingList();
      emit.call(ShoppingLoadSuccessState(fridge: f));
    }
  }

  FutureOr<void> _onShoppingRemove(
      ShoppingRemoveEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final fridge = await repository.deleteShopping(event.name);
      emit.call(ShoppingLoadSuccessState(fridge: fridge));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }
}
