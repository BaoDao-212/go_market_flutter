import 'package:flutter/material.dart';
import 'package:shop_app/screens/food/logic/bloc/bloc.dart'; // Assuming the correct import for the food bloc

class DeleteFoodDialog extends StatefulWidget {
  final FoodBloc bloc;
  final String name;

  DeleteFoodDialog({
    Key? key,
    required this.bloc,
    required this.name,
  }) : super(key: key);

  @override
  _DeleteFoodDialogState createState() => _DeleteFoodDialogState();
}

class _DeleteFoodDialogState extends State<DeleteFoodDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Food'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Delete food: ${widget.name}       ",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteFood(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteFood() {
    widget.bloc.add(FoodRemoveEvent(name: widget.name));
    Navigator.pop(context);
  }
}
