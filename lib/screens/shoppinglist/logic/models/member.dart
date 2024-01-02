import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/shoppinglist/logic/models/task.dart';

class Shopping extends Equatable {
  late final int id;
  late final String name;
  late final String note;
  late final int belongsToGroupAdminId;
  late final int assignedToUserId;
  late final String type;
  late final DateTime date;
  late final List<Task> tasks;

  Shopping({
    required this.id,
    required this.note,
    required this.type,
    required this.date,
    required this.name,
    required this.tasks,
  });
  Shopping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'] ?? '';
    assignedToUserId = json['assignedToUserId'] ?? 1;
    belongsToGroupAdminId = json['belongsToGroupAdminId'] ?? 1;
    date = DateTime.parse(json['date']);
    tasks = json['details'];
  }

  static List<Shopping> fromList(List<dynamic> list) {
    return list.map((e) => Shopping.fromJson(e)).toList();
  }

  @override
  List<Object?> get props =>
      [id, note, date, name, assignedToUserId, belongsToGroupAdminId, tasks];
}
