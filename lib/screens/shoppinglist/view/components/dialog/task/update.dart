import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart';

class UpdateTaskDialog extends StatefulWidget {
  final ShoppingBloc bloc;
  final dynamic task;

  UpdateTaskDialog({
    Key? key,
    required this.bloc,
    required this.task,
  }) : super(key: key);

  @override
  _UpdateTaskDialogState createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  String _foodName = '';
  int _quantity = 0;
  List<Food>? foods;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
    _foodName = widget.task['Food.name'];
    _quantity = widget.task['quantity'];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.task);
    return AlertDialog(
      title: Text(
        'Update Task',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener(
                listenWhen: (prev, curr) => prev != curr,
                listener: (context, state) {
                  if (state is FoodLoadedSuccessState) {
                    print(state.foods.foods);
                    setState(() {
                      foods = state.foods.foods;
                    });
                  }
                },
                bloc: widget.bloc,
                child: Container(),
              ),
              foods == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        _buildFoodDropdown(
                          foods?.map((f) => f.name.toString()).toList(),
                        ),
                        SizedBox(height: 12),
                        _buildTextField(
                          'Quantity',
                          'Enter food quantity',
                          (value) => _quantity = int.parse(value),
                          _quantity.toString(),
                        ),
                      ],
                    )
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
          child: Text('Update'),
        ),
      ],
    );
  }

  Widget _buildFoodDropdown(List<String>? foods) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _foodName,
        onChanged: (String? newValue) {
          setState(() {
            _foodName = newValue!;
          });
        },
        items: foods?.map((val) {
          return DropdownMenuItem(
            value: val,
            child: SizedBox(
              width: 100.0,
              child: Text(val),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Food',
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, Function(String) onChanged, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        onChanged: onChanged,
        autofocus: label == 'Name', // Autofocus on the name field
        keyboardType: label == 'Quantity' ? TextInputType.number : null,
        controller: TextEditingController(text: value),
      ),
    );
  }

  void _updateTask() {
    if (_foodName == widget.task['Food.name']) _foodName = '';
    widget.bloc.add(TaskUpdateEvent(
      foodName: _foodName,
      taskId: widget.task['id'],
      quantity: _quantity,
    ));
    widget.bloc.add(ShoppingLoadedEvent());
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
