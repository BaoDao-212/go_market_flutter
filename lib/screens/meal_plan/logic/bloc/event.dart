part of 'bloc.dart';

abstract class MealPlanEvent extends Equatable {
  const MealPlanEvent();

  @override
  List<Object> get props => [];
}

class MealPlanLoadedEvent extends MealPlanEvent {
  final String date;

  MealPlanLoadedEvent({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}

class DataMemberLoadedEvent extends MealPlanEvent {}

class DataFoodLoadedEvent extends MealPlanEvent {}

class TaskCreateEvent extends MealPlanEvent {
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

class TaskUpdateEvent extends MealPlanEvent {
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

class TaskUpdateStateEvent extends MealPlanEvent {
  final int taskId;
  final int done;

  TaskUpdateStateEvent({
    required this.taskId,
    required this.done,
  });

  @override
  List<Object> get props => [taskId, done];
}

class MealPlanCreateEvent extends MealPlanEvent {
  final String foodName;
  final String timestamp;
  final String name;
  final String date;

  MealPlanCreateEvent({
    required this.name,
    required this.foodName,
    required this.timestamp,
    required this.date,
  });

  @override
  List<Object> get props => [name, timestamp, foodName, date];
}

class MealPlanMemberAddEvent extends MealPlanEvent {
  final dynamic username;

  MealPlanMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class MealPlanRemoveEvent extends MealPlanEvent {
  final int id;
  final String date;

  MealPlanRemoveEvent({
    required this.id,
    required this.date,
  });

  @override
  List<Object> get props => [id, date];
}

class TaskRemoveEvent extends MealPlanEvent {
  final int id;

  TaskRemoveEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class MealPlanMembersLoadEvent extends MealPlanEvent {}

class MealPlanUpdateEvent extends MealPlanEvent {
  final String foodName;
  final String timestamp;
  final String name;
  final String date;
  final int id;

  MealPlanUpdateEvent({
    required this.id,
    required this.name,
    required this.foodName,
    required this.timestamp,
    required this.date,
  });

  @override
  List<Object> get props => [id, name, timestamp, foodName, date];
}
