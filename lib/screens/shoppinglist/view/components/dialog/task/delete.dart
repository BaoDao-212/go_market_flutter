import 'package:flutter/material.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart'; // Assuming the correct import for the food bloc

class DeleteTaskDialog extends StatefulWidget {
  final ShoppingBloc bloc;
  final String name;
  final int id;

  DeleteTaskDialog({
    Key? key,
    required this.bloc,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  _DeleteTaskDialogState createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task food: ${widget.name}      ",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.bloc.add(ShoppingLoadedEvent());
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteTask(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteTask() {
    widget.bloc.add(TaskRemoveEvent(id: widget.id));
    widget.bloc.add(ShoppingLoadedEvent());
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
