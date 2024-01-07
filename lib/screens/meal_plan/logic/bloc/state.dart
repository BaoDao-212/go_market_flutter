part of 'bloc.dart';

abstract class MealPlanState extends Equatable {
  const MealPlanState();

  @override
  List<Object> get props => [];
}

class MealPlanLoadInProgressState extends MealPlanState {}

class MealPlanLoadFailureState extends MealPlanState {}

class MealPlanLoadSuccessState extends MealPlanState {
  final dynamic mealPlan;

  MealPlanLoadSuccessState({
    this.mealPlan = const {},
  });

  @override
  List<Object> get props => [mealPlan];
}

class MemberLoadedSuccessState extends MealPlanState {
  final dynamic members;

  MemberLoadedSuccessState({
    this.members = const {},
  });

  @override
  List<Object> get props => [members];
}

class FoodLoadedSuccessState extends MealPlanState {
  final dynamic foods;

  FoodLoadedSuccessState({
    this.foods = const {},
  });

  @override
  List<Object> get props => [foods];
}

class MealPlanCreateInProgressState extends MealPlanState {}

class MealPlanCreateSuccessState extends MealPlanState {
  final dynamic createdMealPlan;

  MealPlanCreateSuccessState({
    required this.createdMealPlan,
  });

  @override
  List<Object> get props => [createdMealPlan];
}

class MealPlanCreateFailureState extends MealPlanState {}

class MealPlanMemberAddInProgressState extends MealPlanState {}

class MealPlanMemberAddSuccessState extends MealPlanState {
  final dynamic addedMember;

  MealPlanMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class MealPlanMemberRemoveInProgressState extends MealPlanState {}

class MealPlanMemberRemoveSuccessState extends MealPlanState {
  final dynamic removedMember;

  MealPlanMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class MealPlanStateMembersLoadSuccessState extends MealPlanState {
  final List<dynamic> members;

  MealPlanStateMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
