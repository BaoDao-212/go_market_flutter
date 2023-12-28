import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/models/models.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodRepository repository = FoodRepository();

  FoodBloc() : super(FoodLoadInProgressState()) {
    on<FoodLoadedEvent>(_onFoodLoad);
    // on<FoodCreateEvent>(_onFoodCreate);
    // on<FoodMemberAddEvent>(_onFoodMemberAdd);
    // on<FoodMemberRemoveEvent>(_onFoodMemberRemove);
  }

  FutureOr<void> _onFoodLoad(
      FoodLoadedEvent event, Emitter<FoodState> emit) async {
    emit.call(FoodLoadInProgressState());
    try {
      print(1);
      final FoodModel food = await repository.getFoodList();
      print(1);
      emit.call(FoodLoadSuccessState(food: food));
    } catch (e) {
      emit.call(FoodLoadFailureState());
    }
  }

  // FutureOr<void> _onFoodCreate(
  //     FoodCreateEvent event, Emitter<FoodState> emit) async {
  //   emit.call(FoodCreateInProgressState());
  //   try {
  //     final Food = await repository.createFood();
  //     emit.call(FoodCreateSuccessState(createdFood: Food));
  //   } catch (e) {
  //     emit.call(FoodCreateFailureState());
  //   }
  // }

  // FutureOr<void> _onFoodMemberAdd(
  //     FoodMemberAddEvent event, Emitter<FoodState> emit) async {
  //   emit.call(FoodLoadInProgressState());
  //   try {
  //     final Food = await repository.addMember(event.username);
  //     emit.call(FoodLoadSuccessState(Food: Food));
  //   } catch (e) {
  //     emit.call(FoodLoadFailureState());
  //   }
  // }

  // FutureOr<void> _onFoodMemberRemove(
  //     FoodMemberRemoveEvent event, Emitter<FoodState> emit) async {
  //   emit.call(FoodLoadInProgressState());
  //   try {
  //     final Food = await repository.deleteMember(event.username);
  //     emit.call(FoodLoadSuccessState(Food: Food));
  //   } catch (e) {
  //     emit.call(FoodLoadFailureState());
  //   }
  // }
}
