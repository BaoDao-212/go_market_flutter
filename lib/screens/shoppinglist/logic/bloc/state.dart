part of 'bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();

  @override
  List<Object> get props => [];
}

class ShoppingLoadInProgressState extends ShoppingState {}

class ShoppingLoadFailureState extends ShoppingState {}

class ShoppingLoadSuccessState extends ShoppingState {
  final dynamic fridge;

  ShoppingLoadSuccessState({
    this.fridge = const {},
  });

  @override
  List<Object> get props => [fridge];
}

class FoodLoadedSuccessState extends ShoppingState {
  final dynamic foods;

  FoodLoadedSuccessState({
    this.foods = const {},
  });

  @override
  List<Object> get props => [foods];
}

class ShoppingCreateInProgressState extends ShoppingState {}

class ShoppingCreateSuccessState extends ShoppingState {
  final dynamic createdShopping;

  ShoppingCreateSuccessState({
    required this.createdShopping,
  });

  @override
  List<Object> get props => [createdShopping];
}

class ShoppingCreateFailureState extends ShoppingState {}

class ShoppingMemberAddInProgressState extends ShoppingState {}

class ShoppingMemberAddSuccessState extends ShoppingState {
  final dynamic addedMember;

  ShoppingMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class ShoppingMemberRemoveInProgressState extends ShoppingState {}

class ShoppingMemberRemoveSuccessState extends ShoppingState {
  final dynamic removedMember;

  ShoppingMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class ShoppingMembersLoadSuccessState extends ShoppingState {
  final List<dynamic> members;

  ShoppingMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
