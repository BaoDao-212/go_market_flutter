part of 'bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationLoadInProgressState extends NotificationState {}

class NotificationLoadFailureState extends NotificationState {}

class NotificationLoadSuccessState extends NotificationState {
  final dynamic notification;

  NotificationLoadSuccessState({
    this.notification = const {},
  });

  @override
  List<Object> get props => [notification];
}
