part of 'bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoadInProgressState extends HomeState {}

class HomeLoadFailureState extends HomeState {}

class HomeLoadSuccessState extends HomeState {
  final dynamic mealPlan;
  final dynamic recipe;

  HomeLoadSuccessState({
    this.mealPlan = const {},
    this.recipe = const {},
  });

  @override
  List<Object> get props => [mealPlan, recipe];
}
