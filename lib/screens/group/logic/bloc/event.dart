part of 'bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GroupLoadedEvent extends GroupEvent {}

class GroupCreateEvent extends GroupEvent {
  final String groupName;

  GroupCreateEvent({
    required this.groupName,
  });

  @override
  List<Object> get props => [groupName];
}

class GroupMemberAddEvent extends GroupEvent {
  final dynamic username;

  GroupMemberAddEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class GroupMemberRemoveEvent extends GroupEvent {
  final dynamic username;

  GroupMemberRemoveEvent({
    required this.username,
  });

  @override
  List<Object> get props => [username];
}

class GroupMembersLoadEvent extends GroupEvent {}

class GroupUpdateEvent extends GroupEvent {
  final String updatedGroupName;

  GroupUpdateEvent({
    required this.updatedGroupName,
  });

  @override
  List<Object> get props => [updatedGroupName];
}


