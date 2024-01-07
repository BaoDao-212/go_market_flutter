part of 'bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeLoadInProgressState extends RecipeState {}

class RecipeLoadFailureState extends RecipeState {}

class RecipeLoadSuccessState extends RecipeState {
  final dynamic recipe;
  final dynamic food;

  RecipeLoadSuccessState({
    this.recipe = const {},
    this.food = const {},
  });

  @override
  List<Object> get props => [recipe, food];
}

class MemberLoadedSuccessState extends RecipeState {
  final dynamic members;

  MemberLoadedSuccessState({
    this.members = const {},
  });

  @override
  List<Object> get props => [members];
}

class FoodLoadedSuccessState extends RecipeState {
  final dynamic foods;

  FoodLoadedSuccessState({
    this.foods = const {},
  });

  @override
  List<Object> get props => [foods];
}

class RecipeCreateInProgressState extends RecipeState {}

class RecipeCreateSuccessState extends RecipeState {
  final dynamic createdRecipe;

  RecipeCreateSuccessState({
    required this.createdRecipe,
  });

  @override
  List<Object> get props => [createdRecipe];
}

class RecipeCreateFailureState extends RecipeState {}

class RecipeMemberAddInProgressState extends RecipeState {}

class RecipeMemberAddSuccessState extends RecipeState {
  final dynamic addedMember;

  RecipeMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class RecipeMemberRemoveInProgressState extends RecipeState {}

class RecipeMemberRemoveSuccessState extends RecipeState {
  final dynamic removedMember;

  RecipeMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class RecipeStateMembersLoadSuccessState extends RecipeState {
  final List<dynamic> members;

  RecipeStateMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
