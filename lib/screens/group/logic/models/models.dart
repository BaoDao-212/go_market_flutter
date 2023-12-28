import 'package:equatable/equatable.dart';
import 'package:shop_app/screens/group/logic/models/member.dart';

class GroupModel extends Equatable {
  final int id;
  final List<Member> members;

  GroupModel({
    required this.id,
    required this.members,
  });

  GroupModel copyWith({
    int? id,
    List<Member>? members,
  }) {
    return GroupModel(
      id: id ?? this.id,
      members: members ?? this.members,
    );
  }

  @override
  List<Object?> get props => [id, members];
}
