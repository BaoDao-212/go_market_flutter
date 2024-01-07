part of 'bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeLoadedEvent extends RecipeEvent {
  final int id;

  RecipeLoadedEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class DataMemberLoadedEvent extends RecipeEvent {}

class DataFoodLoadedEvent extends RecipeEvent {}

class TaskUpdateEvent extends RecipeEvent {
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

class TaskUpdateStateEvent extends RecipeEvent {
  final int taskId;
  final int done;

  TaskUpdateStateEvent({
    required this.taskId,
    required this.done,
  });

  @override
  List<Object> get props => [taskId, done];
}

class RecipeCreateEvent extends RecipeEvent {
  final String foodName;
  final String htmlContent;
  final String name;
  final String description;

  RecipeCreateEvent({
    required this.name,
    required this.foodName,
    required this.htmlContent,
    required this.description,
  });

  @override
  List<Object> get props => [name, htmlContent, foodName, description];
}

class RecipeMemberAddEvent extends RecipeEvent {
  final dynamic username;

  RecipeMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class RecipeRemoveEvent extends RecipeEvent {
  final int id;
  final int foodId;

  RecipeRemoveEvent({
    required this.id,
    required this.foodId,
  });

  @override
  List<Object> get props => [id, foodId];
}

class TaskRemoveEvent extends RecipeEvent {
  final int id;

  TaskRemoveEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class RecipeMembersLoadEvent extends RecipeEvent {}

class RecipeUpdateEvent extends RecipeEvent {
  final String foodName;
  final String timestamp;
  final String name;
  final String date;
  final int id;

  RecipeUpdateEvent({
    required this.id,
    required this.name,
    required this.foodName,
    required this.timestamp,
    required this.date,
  });

  @override
  List<Object> get props => [id, name, timestamp, foodName, date];
}
