import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/repository/reposotory.dart';
import 'package:shop_app/screens/notification/logic/repository/reposotory.dart';
part 'event.dart';
part 'state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository repository = NotificationRepository();
  FoodRepository repositoryFood = FoodRepository();

  NotificationBloc() : super(NotificationLoadInProgressState()) {
    on<NotificationLoadedEvent>(_onNotificationLoad);
  }

  FutureOr<void> _onNotificationLoad(
      NotificationLoadedEvent event, Emitter<NotificationState> emit) async {
    emit.call(NotificationLoadInProgressState());
    try {
      final dynamic notification = await repository.getNotificationList();
      emit.call(NotificationLoadSuccessState(notification: notification));
    } catch (e) {
      emit.call(NotificationLoadFailureState());
    }
  }

  FutureOr<void> _onNotificationCreate(
      NotificationCreatedEvent event, Emitter<NotificationState> emit) async {
    emit.call(NotificationLoadInProgressState());
    try {
      final dynamic notification = await repository.getNotificationList();
      emit.call(NotificationLoadSuccessState(notification: notification));
    } catch (e) {
      emit.call(NotificationLoadFailureState());
    }
  }
}
