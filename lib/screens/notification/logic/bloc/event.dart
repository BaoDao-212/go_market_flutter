part of 'bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationLoadedEvent extends NotificationEvent {}

class NotificationCreatedEvent extends NotificationEvent {
  final int id;
  final String title;
  final String body;
  final String date;

  NotificationCreatedEvent({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  @override
  List<Object> get props => [id, date, title, body];
}
