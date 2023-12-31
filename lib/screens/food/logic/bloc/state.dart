part of 'bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodLoadInProgressState extends FoodState {}

class FoodLoadFailureState extends FoodState {}

class FoodLoadSuccessState extends DataLoadSuccessState {
  final dynamic food;

  FoodLoadSuccessState({
    this.food = const {},
  });

  @override
  List<Object> get props => [food];
}

class DataLoadSuccessState extends FoodState {
  final dynamic unit;
  final dynamic category;

  DataLoadSuccessState({
    this.unit = const {},
    this.category = const {},
  });

  @override
  List<Object> get props => [unit, category];
}

class FoodCreateInProgressState extends FoodState {}

class FoodCreateSuccessState extends FoodState {
  final dynamic createdFood;

  FoodCreateSuccessState({
    required this.createdFood,
  });

  @override
  List<Object> get props => [createdFood];
}

class FoodCreateFailureState extends FoodState {}

class FoodMemberAddInProgressState extends FoodState {}

class FoodMemberAddSuccessState extends FoodState {
  final dynamic addedMember;

  FoodMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class FoodMemberRemoveInProgressState extends FoodState {}

class FoodMemberRemoveSuccessState extends FoodState {
  final dynamic removedMember;

  FoodMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class FoodMembersLoadSuccessState extends FoodState {
  final List<dynamic> members;

  FoodMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
