import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/group/logic/bloc/bloc.dart';

class AddMemberDialog extends StatefulWidget {
  final GroupBloc bloc;

  AddMemberDialog({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _AddMemberDialogState createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  String _username = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener(
            listenWhen: (prev, curr) =>
                prev != curr && curr == GroupMemberAddInProgressState,
            listener: (context, state) {
              Navigator.pop(context);
            },
            bloc: widget.bloc,
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onChanged: (value) => setState(() => _username = value),
              autofocus: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // Change the button color
          ),
          onPressed: () => _join(),
          child: Text('Add'), // Change the button text
        ),
      ],
    );
  }

  _join() {
    final username = _username.trim();

    if (username.isEmpty) {
      return;
    }

    widget.bloc.add(GroupMemberAddEvent(username: username));
    Navigator.pop(context);
  }
}
