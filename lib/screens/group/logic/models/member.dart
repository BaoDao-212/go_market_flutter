import 'package:equatable/equatable.dart';

class Member extends Equatable {
  late final int id;
  late final String username;
  late final String name;
  late final String email;
  late final String photoUrl;

  Member({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'] ?? '';
    email = json['email'];
    name = json['name'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
  }

  static List<Member> fromList(List<dynamic> list) {
    return list.map((e) => Member.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [id, username, email, name, photoUrl];
}
