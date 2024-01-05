import 'package:flutter/material.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart';

class UpdateStateTaskDialog extends StatefulWidget {
  final ShoppingBloc bloc;
  final dynamic task;

  UpdateStateTaskDialog({
    Key? key,
    required this.bloc,
    required this.task,
  }) : super(key: key);

  @override
  _UpdateStateTaskDialogState createState() => _UpdateStateTaskDialogState();
}

class _UpdateStateTaskDialogState extends State<UpdateStateTaskDialog> {
  int _done = 0;
  List<Food>? foods;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
    _done = widget.task['done'];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.task);
    return AlertDialog(
      title: Text(
        'Update Shopping',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_done == 0)
                Text("Confirm completion")
              else
                Text("Confirmation not completed")
            ],
          ),
        ),
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: _updateTask,
          child: Text('Update state'),
        ),
      ],
    );
  }

  void _updateTask() {
    widget.bloc.add(TaskUpdateStateEvent(
      taskId: widget.task['id'],
      done: _done == 0 ? 1 : 0,
    ));
    widget.bloc.add(ShoppingLoadedEvent());
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
