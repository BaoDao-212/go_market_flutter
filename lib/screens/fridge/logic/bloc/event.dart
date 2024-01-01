part of 'bloc.dart';

abstract class FridgeEvent extends Equatable {
  const FridgeEvent();

  @override
  List<Object> get props => [];
}

class FridgeLoadedEvent extends FridgeEvent {}

class DataFoodLoadedEvent extends FridgeEvent {}

class FridgeCreateEvent extends FridgeEvent {
  final String foodName;
  final int useWithin;
  final String note;
  final int quantity;

  FridgeCreateEvent({
    required this.foodName,
    required this.useWithin,
    required this.quantity,
    required this.note,
  });

  @override
  List<Object> get props => [foodName, quantity, useWithin, note];
}

class FridgeMemberAddEvent extends FridgeEvent {
  final dynamic username;

  FridgeMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class FridgeRemoveEvent extends FridgeEvent {
  final String name;

  FridgeRemoveEvent({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class FridgeMembersLoadEvent extends FridgeEvent {}

class FridgeUpdateEvent extends FridgeEvent {
  final String foodName;
  final int useWithin;
  final String note;
  final int quantity;
  final int id;
  FridgeUpdateEvent({
    required this.foodName,
    required this.useWithin,
    required this.quantity,
    required this.note,
    required this.id,
  });

  @override
  List<Object> get props => [id, foodName, quantity, useWithin, note];
}
