import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import 'package:shop_app/screens/group/logic/models/models.dart';
import 'package:shop_app/screens/group/logic/repository/reposotory.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/models.dart';
import 'package:shop_app/screens/shoppinglist/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingRepository repository = ShoppingRepository();
  GroupRepository repositoryMember = GroupRepository();
  FoodRepository repositoryFood = FoodRepository();

  ShoppingBloc() : super(ShoppingLoadInProgressState()) {
    on<ShoppingLoadedEvent>(_onShoppingLoad);
    on<DataMemberLoadedEvent>(_onMemberLoad);
    on<DataFoodLoadedEvent>(_onFoodLoad);
    on<ShoppingCreateEvent>(_onShoppingCreate);
    on<TaskCreateEvent>(_onTaskCreate);
    on<ShoppingUpdateEvent>(_onShoppingUpdate);
    on<TaskUpdateStateEvent>(_onTaskUpdateState);
    on<ShoppingRemoveEvent>(_onShoppingRemove);
    on<TaskUpdateEvent>(_onTaskUpdate);
    on<TaskRemoveEvent>(_onTaskRemove);
  }

  FutureOr<void> _onShoppingLoad(
      ShoppingLoadedEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final ShoppingModel shopping = await repository.getShoppingList();
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onMemberLoad(
      DataMemberLoadedEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final GroupModel members = await repositoryMember.getMemberList();
      emit.call(MemberLoadedSuccessState(members: members));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onFoodLoad(
      DataFoodLoadedEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final foods = await repositoryFood.getFoodList();
      emit.call(FoodLoadedSuccessState(foods: foods));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onShoppingCreate(
      ShoppingCreateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      print(0);
      final shopping = await repository.createShopping(
          event.name, event.assignToUsername, event.note, event.date);
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onTaskCreate(
      TaskCreateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final shopping = await repository.createTask(
          event.listId, event.foodName, event.quantity);
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onShoppingUpdate(
      ShoppingUpdateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final f = await repository.updateShopping(event.listId, event.name,
          event.assignToUsername, event.note, event.date);
      emit.call(ShoppingLoadSuccessState(shopping: f));
    } catch (e) {
      final ShoppingModel f = await repository.getShoppingList();
      emit.call(ShoppingLoadSuccessState(shopping: f));
    }
  }

  FutureOr<void> _onShoppingRemove(
      ShoppingRemoveEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final shopping = await repository.deleteShopping(event.id);
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onTaskRemove(
      TaskRemoveEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final shopping = await repository.deleteTask(event.id);
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onTaskUpdate(
      TaskUpdateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final shopping = await repository.updateTask(
          event.taskId, event.foodName, event.quantity);
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }

  FutureOr<void> _onTaskUpdateState(
      TaskUpdateStateEvent event, Emitter<ShoppingState> emit) async {
    emit.call(ShoppingLoadInProgressState());
    try {
      final shopping = await repository.updateTaskState(
        event.taskId,
        event.done,
      );
      emit.call(ShoppingLoadSuccessState(shopping: shopping));
    } catch (e) {
      emit.call(ShoppingLoadFailureState());
    }
  }
}
