import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/group/logic/repository/reposotory.dart';
import '/core/app_export.dart';
part 'event.dart';
part 'state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupRepository repository = GroupRepository();

  GroupBloc() : super(GroupLoadInProgressState()) {
    on<GroupLoadedEvent>(_onGroupLoaded);
  }

  FutureOr<void> _onGroupLoaded(
    GroupLoadedEvent event,
    Emitter<GroupState> emit,
  ) async {
    emit.call(GroupLoadInProgressState());
    try {
      final user = await repository.getMemberList();

      emit.call(GroupLoadSuccessState(
        user: user,
      ));
    } catch (e) {
      emit.call(GroupLoadFailureState());
    }
  }
}
