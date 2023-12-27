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
  final dynamic member;

  GroupMemberAddEvent({
    required this.member,
  });

  @override
  List<Object> get props => [member];
}

class GroupMemberRemoveEvent extends GroupEvent {
  final dynamic member;

  GroupMemberRemoveEvent({
    required this.member,
  });

  @override
  List<Object> get props => [member];
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

class GroupDeleteEvent extends GroupEvent {}

// Add more events as needed based on your application requirements.
