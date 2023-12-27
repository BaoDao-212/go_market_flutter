import 'package:equatable/equatable.dart';

class User extends Equatable implements Comparable {
  late final int id;
  late final String username;
  late final String name;
  late final String email;
  late final int groupId;
  late final String photoUrl;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.groupId,
    required this.photoUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    id = user['id'];
    username = user['username'] ?? '';
    email = user['email'];
    name = user['name'] ?? '';
    groupId = user['belongsToGroupAdminId'] ?? 0;
    photoUrl = user['photoUrl'] ?? '';
  }

  static List<User> fromList(List<dynamic> list) {
    return list.map((e) => User.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id, username, email, name, photoUrl, groupId];

  @override
  int compareTo(other) {
    throw UnimplementedError();
  }
}
