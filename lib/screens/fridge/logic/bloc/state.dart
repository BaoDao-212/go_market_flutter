part of 'bloc.dart';

abstract class FridgeState extends Equatable {
  const FridgeState();

  @override
  List<Object> get props => [];
}

class FridgeLoadInProgressState extends FridgeState {}

class FridgeLoadFailureState extends FridgeState {}

class FridgeLoadSuccessState extends FridgeState {
  final dynamic fridge;

  FridgeLoadSuccessState({
    this.fridge = const {},
  });

  @override
  List<Object> get props => [fridge];
}

class FoodLoadedSuccessState extends FridgeState {
  final dynamic foods;

  FoodLoadedSuccessState({
    this.foods = const {},
  });

  @override
  List<Object> get props => [foods];
}

class FridgeCreateInProgressState extends FridgeState {}

class FridgeCreateSuccessState extends FridgeState {
  final dynamic createdFridge;

  FridgeCreateSuccessState({
    required this.createdFridge,
  });

  @override
  List<Object> get props => [createdFridge];
}

class FridgeCreateFailureState extends FridgeState {}

class FridgeMemberAddInProgressState extends FridgeState {}

class FridgeMemberAddSuccessState extends FridgeState {
  final dynamic addedMember;

  FridgeMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class FridgeMemberRemoveInProgressState extends FridgeState {}

class FridgeMemberRemoveSuccessState extends FridgeState {
  final dynamic removedMember;

  FridgeMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class FridgeMembersLoadSuccessState extends FridgeState {
  final List<dynamic> members;

  FridgeMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
