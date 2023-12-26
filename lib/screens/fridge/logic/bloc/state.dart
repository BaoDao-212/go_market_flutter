part of 'bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupLoadInProgressState extends GroupState {}

class GroupLoadFailureState extends GroupState {}

class GroupLoadSuccessState extends GroupState {
  final dynamic user;

  GroupLoadSuccessState({
    this.user = const {},
  });

  @override
  List<Object> get props => user;
}
