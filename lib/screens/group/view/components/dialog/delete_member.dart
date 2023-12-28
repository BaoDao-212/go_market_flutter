import 'package:flutter/material.dart';
import 'package:shop_app/screens/group/logic/bloc/bloc.dart';

class DeleteMemberDialog extends StatefulWidget {
  final GroupBloc bloc;
  final String username;
  final String name;

  DeleteMemberDialog({
    Key? key,
    required this.bloc,
    required this.username,
    required this.name,
  }) : super(key: key);

  @override
  _DeleteMemberDialogState createState() => _DeleteMemberDialogState();
}

class _DeleteMemberDialogState extends State<DeleteMemberDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.username);
    return AlertDialog(
      title: Text('Delete member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Delete member: ${widget.name}",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteMember(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteMember() {
    widget.bloc.add(GroupMemberRemoveEvent(username: widget.username));
    Navigator.pop(
        context); // Close the dialog after initiating the delete action
  }
}
