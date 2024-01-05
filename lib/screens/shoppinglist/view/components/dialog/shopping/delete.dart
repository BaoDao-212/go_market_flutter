import 'package:flutter/material.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart'; // Assuming the correct import for the food bloc

class DeleteShoppingDialog extends StatefulWidget {
  final ShoppingBloc bloc;
  final String name;
  final int id;

  DeleteShoppingDialog({
    Key? key,
    required this.bloc,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  _DeleteShoppingDialogState createState() => _DeleteShoppingDialogState();
}

class _DeleteShoppingDialogState extends State<DeleteShoppingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Shopping'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shopping: ${widget.name}      ",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.bloc.add(ShoppingLoadedEvent());
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteShopping(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteShopping() {
    widget.bloc.add(ShoppingRemoveEvent(id: widget.id));
    widget.bloc.add(ShoppingLoadedEvent());
    Navigator.pop(context);
  }
}
