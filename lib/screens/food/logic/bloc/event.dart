part of 'bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FoodLoadedEvent extends FoodEvent {}

class DataFoodLoadedEvent extends FoodEvent {}

class FoodCreateEvent extends FoodEvent {
  final String name;
  final XFile image;
  final String unitName;
  final String foodCategoryName;

  FoodCreateEvent({
    required this.name,
    required this.image,
    required this.unitName,
    required this.foodCategoryName,
  });

  @override
  List<Object> get props => [name, image, unitName, foodCategoryName];
}

class FoodMemberAddEvent extends FoodEvent {
  final dynamic username;

  FoodMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class FoodRemoveEvent extends FoodEvent {
  final String name;

  FoodRemoveEvent({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class FoodMembersLoadEvent extends FoodEvent {}

class FoodUpdateEvent extends FoodEvent {
  final String name;
  final String newName;
  final XFile? image;
  final String unitName;
  final String foodCategoryName;

  FoodUpdateEvent({
    required this.name,
    required this.newName,
    this.image,
    required this.unitName,
    required this.foodCategoryName,
  });

  @override
  List<Object> get props {
    return [name, newName, image, unitName, foodCategoryName] as List<Object>;
  }
}
