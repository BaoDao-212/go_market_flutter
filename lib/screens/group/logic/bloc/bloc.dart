import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/group/logic/models/models.dart';
import 'package:shop_app/screens/group/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupRepository repository = GroupRepository();

  GroupBloc() : super(GroupLoadInProgressState()) {
    on<GroupLoadedEvent>(_onGroupLoad);
    on<GroupCreateEvent>(_onGroupCreate);
    on<GroupMemberAddEvent>(_onGroupMemberAdd);
    on<GroupMemberRemoveEvent>(_onGroupMemberRemove);
  }

  FutureOr<void> _onGroupLoad(
      GroupLoadedEvent event, Emitter<GroupState> emit) async {
    emit.call(GroupLoadInProgressState());
    try {
      final GroupModel group = await repository.getMemberList();
      emit.call(GroupLoadSuccessState(group: group));
    } catch (e) {
      emit.call(GroupLoadFailureState());
    }
  }

  FutureOr<void> _onGroupCreate(
      GroupCreateEvent event, Emitter<GroupState> emit) async {
    emit.call(GroupCreateInProgressState());
    try {
      final group = await repository.createGroup();
      emit.call(GroupCreateSuccessState(createdGroup: group));
    } catch (e) {
      emit.call(GroupCreateFailureState());
    }
  }

  FutureOr<void> _onGroupMemberAdd(
      GroupMemberAddEvent event, Emitter<GroupState> emit) async {
    emit.call(GroupLoadInProgressState());
    try {
      final group = await repository.addMember(event.username);
      emit.call(GroupLoadSuccessState(group: group));
    } catch (e) {
      emit.call(GroupLoadFailureState());
    }
  }

  FutureOr<void> _onGroupMemberRemove(
      GroupMemberRemoveEvent event, Emitter<GroupState> emit) async {
    emit.call(GroupLoadInProgressState());
    try {
      final group = await repository.deleteMember(event.username);
      emit.call(GroupLoadSuccessState(group: group));
    } catch (e) {
      emit.call(GroupLoadFailureState());
    }
  }
}
