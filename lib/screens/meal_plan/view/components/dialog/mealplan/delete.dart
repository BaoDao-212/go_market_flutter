import 'package:flutter/material.dart';
import 'package:shop_app/screens/meal_plan/logic/bloc/bloc.dart';

class DeleteMealPlanDialog extends StatefulWidget {
  final MealPlanBloc bloc;
  final String name;
  final String date;
  final int id;

  DeleteMealPlanDialog({
    Key? key,
    required this.bloc,
    required this.name,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  _DeleteMealPlanDialogState createState() => _DeleteMealPlanDialogState();
}

class _DeleteMealPlanDialogState extends State<DeleteMealPlanDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Meal Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meal Plan: ${widget.name}      ",
          ),
          Text(
            "Date: ${widget.date}      ",
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.bloc.add(MealPlanLoadedEvent(date: widget.date));
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _deleteMealPlan(),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  _deleteMealPlan() {
    widget.bloc.add(MealPlanRemoveEvent(id: widget.id, date: widget.date));
    widget.bloc.add(MealPlanLoadedEvent(date: widget.date));
    Navigator.pop(context);
  }
}
