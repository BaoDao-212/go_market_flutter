import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/notification/logic/models/member.dart';

class NotificationModel extends Equatable {
  final List<Notification> notification;

  NotificationModel({
    required this.notification,
  });

  NotificationModel copyWith({
    List<Notification>? notification,
  }) {
    return NotificationModel(
      notification: notification ?? this.notification,
    );
  }

  @override
  List<Object?> get props => [notification];
}
