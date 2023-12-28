part of 'bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupLoadInProgressState extends GroupState {}

class GroupLoadFailureState extends GroupState {}

class GroupLoadSuccessState extends GroupState {
  final dynamic group;

  GroupLoadSuccessState({
    this.group = const {},
  });

  @override
  List<Object> get props => [group];
}

class GroupCreateInProgressState extends GroupState {}

class GroupCreateSuccessState extends GroupState {
  final dynamic createdGroup;

  GroupCreateSuccessState({
    required this.createdGroup,
  });

  @override
  List<Object> get props => [createdGroup];
}

class GroupCreateFailureState extends GroupState {}

class GroupMemberAddInProgressState extends GroupState {}

class GroupMemberAddSuccessState extends GroupState {
  final dynamic addedMember;

  GroupMemberAddSuccessState({
    required this.addedMember,
  });

  @override
  List<Object> get props => [addedMember];
}

class GroupMemberRemoveInProgressState extends GroupState {}

class GroupMemberRemoveSuccessState extends GroupState {
  final dynamic removedMember;

  GroupMemberRemoveSuccessState({
    required this.removedMember,
  });

  @override
  List<Object> get props => [removedMember];
}

class GroupMembersLoadSuccessState extends GroupState {
  final List<dynamic> members;

  GroupMembersLoadSuccessState({
    required this.members,
  });

  @override
  List<Object> get props => [members];
}
