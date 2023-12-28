part of 'bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FoodLoadedEvent extends FoodEvent {}

class FoodCreateEvent extends FoodEvent {
  final String food;

  FoodCreateEvent({
    required this.food,
  });

  @override
  List<Object> get props => [food];
}

class FoodMemberAddEvent extends FoodEvent {
  final dynamic username;

  FoodMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class FoodMemberRemoveEvent extends FoodEvent {
  final dynamic username;

  FoodMemberRemoveEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class FoodMembersLoadEvent extends FoodEvent {}

class FoodUpdateEvent extends FoodEvent {
  final String updatedFoodName;

  FoodUpdateEvent({
    required this.updatedFoodName,
  });

  @override
  List<Object> get props => [updatedFoodName];
}


