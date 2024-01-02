import 'package:flutter/material.dart';
import 'package:shop_app/screens/fridge/logic/bloc/bloc.dart'; // Assuming the correct import for the food bloc

class DeleteFridgeDialog extends StatefulWidget {
  final FridgeBloc bloc;
  final String name;

  DeleteFridgeDialog({
    Key? key,
    required this.bloc,
    required this.name,
  }) : super(key: key);

  @override
  _DeleteFridgeDialogState createState() => _DeleteFridgeDialogState();
}

class _DeleteFridgeDialogState extends State<DeleteFridgeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Fridge'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Fridge is removed from the refrigerator: ${widget.name}",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.bloc.add(FridgeLoadedEvent());
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteFridge(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteFridge() {
    widget.bloc.add(FridgeRemoveEvent(name: widget.name));
    widget.bloc.add(FridgeLoadedEvent());
    Navigator.pop(context);
  }
}
