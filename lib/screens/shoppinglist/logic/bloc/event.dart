part of 'bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();

  @override
  List<Object> get props => [];
}

class ShoppingLoadedEvent extends ShoppingEvent {}

class DataMemberLoadedEvent extends ShoppingEvent {}

class DataFoodLoadedEvent extends ShoppingEvent {}

class ShoppingCreateEvent extends ShoppingEvent {
  final String name;
  final String assignToUsername;
  final String note;
  final String date;

  ShoppingCreateEvent({
    required this.name,
    required this.assignToUsername,
    required this.note,
    required this.date,
  });

  @override
  List<Object> get props => [name, assignToUsername, date, note];
}

class ShoppingMemberAddEvent extends ShoppingEvent {
  final dynamic username;

  ShoppingMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class ShoppingRemoveEvent extends ShoppingEvent {
  final int id;

  ShoppingRemoveEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class ShoppingMembersLoadEvent extends ShoppingEvent {}

class ShoppingUpdateEvent extends ShoppingEvent {
  final String name;
  final String assignToUsername;
  final String note;
  final String date;
  final int listId;
  ShoppingUpdateEvent({
    required this.name,
    required this.assignToUsername,
    required this.date,
    required this.note,
    required this.listId,
  });

  @override
  List<Object> get props => [listId, assignToUsername, name, date, note];
}
