import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';

class GroupModel extends Equatable {
  final int id;
  final List<User> members;

  GroupModel({
    required this.id,
    required this.members,
  });

  GroupModel copyWith({
    int? id,
    List<User>? members,
  }) {
    return GroupModel(
      id: id ?? this.id,
      members: members ?? this.members,
    );
  }

  @override
  List<Object?> get props => [id, members];
}
