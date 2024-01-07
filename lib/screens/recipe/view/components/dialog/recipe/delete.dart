import 'package:flutter/material.dart';
import 'package:shop_app/screens/recipe/logic/bloc/bloc.dart';

class DeleteRecipeDialog extends StatefulWidget {
  final RecipeBloc bloc;
  final String name;
  final int id;
  final int foodId;

  DeleteRecipeDialog({
    Key? key,
    required this.bloc,
    required this.name,
    required this.id,
    required this.foodId,
  }) : super(key: key);

  @override
  _DeleteRecipeDialogState createState() => _DeleteRecipeDialogState();
}

class _DeleteRecipeDialogState extends State<DeleteRecipeDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete recipe'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recipe: ${widget.name}      ",
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.bloc.add(RecipeLoadedEvent(id: widget.foodId));
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteRecipe(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteRecipe() {
    widget.bloc.add(RecipeRemoveEvent(id: widget.id, foodId: widget.foodId));
    widget.bloc.add(RecipeLoadedEvent(id: widget.foodId));
    Navigator.pop(context);
  }
}
