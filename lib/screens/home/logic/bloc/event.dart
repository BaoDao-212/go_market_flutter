part of 'bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadedEvent extends HomeEvent {}

class DataMemberLoadedEvent extends HomeEvent {}

class DataFoodLoadedEvent extends HomeEvent {}

class TaskCreateEvent extends HomeEvent {
  final int listId;
  final String foodName;
  final int quantity;

  TaskCreateEvent({
    required this.listId,
    required this.foodName,
    required this.quantity,
  });

  @override
  List<Object> get props => [listId, foodName, quantity];
}

class TaskUpdateEvent extends HomeEvent {
  final int taskId;
  final String foodName;
  final int quantity;

  TaskUpdateEvent({
    required this.taskId,
    required this.foodName,
    required this.quantity,
  });

  @override
  List<Object> get props => [taskId, foodName, quantity];
}

class TaskUpdateStateEvent extends HomeEvent {
  final int taskId;
  final int done;

  TaskUpdateStateEvent({
    required this.taskId,
    required this.done,
  });

  @override
  List<Object> get props => [taskId, done];
}

class HomeCreateEvent extends HomeEvent {
  final String foodName;
  final String timestamp;
  final String name;
  final String date;

  HomeCreateEvent({
    required this.name,
    required this.foodName,
    required this.timestamp,
    required this.date,
  });

  @override
  List<Object> get props => [name, timestamp, foodName, date];
}

class HomeMemberAddEvent extends HomeEvent {
  final dynamic username;

  HomeMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class HomeRemoveEvent extends HomeEvent {
  final int id;
  final String date;

  HomeRemoveEvent({
    required this.id,
    required this.date,
  });

  @override
  List<Object> get props => [id, date];
}

class TaskRemoveEvent extends HomeEvent {
  final int id;

  TaskRemoveEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class HomeMembersLoadEvent extends HomeEvent {}

class HomeUpdateEvent extends HomeEvent {
  final String foodName;
  final String timestamp;
  final String name;
  final String date;
  final int id;

  HomeUpdateEvent({
    required this.id,
    required this.name,
    required this.foodName,
    required this.timestamp,
    required this.date,
  });

  @override
  List<Object> get props => [id, name, timestamp, foodName, date];
}
