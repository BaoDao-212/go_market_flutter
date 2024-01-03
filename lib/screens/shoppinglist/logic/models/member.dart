import 'package:equatable/equatable.dart';

class Shopping extends Equatable {
  late final int id;
  late final String name;
  late final String username;
  late final String note;
  late final int belongsToGroupAdminId;
  late final int assignedToUserId;
  late final DateTime date;
  late final List<dynamic> tasks;

  Shopping({
    required this.id,
    required this.note,
    required this.username,
    required this.date,
    required this.name,
    required this.tasks,
  });
  Shopping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'] ?? '';
    username = json['username'] ?? '';
    assignedToUserId = json['assignedToUserId'] ?? 1;
    belongsToGroupAdminId = json['belongsToGroupAdminId'] ?? 1;
    date = DateTime.parse(json['date']);
    tasks = json['details'];
  }

  static List<Shopping> fromList(List<dynamic> list) {
    return list.map((e) => Shopping.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        note,
        date,
        name,
        assignedToUserId,
        belongsToGroupAdminId,
        tasks,
        username,
      ];
}
