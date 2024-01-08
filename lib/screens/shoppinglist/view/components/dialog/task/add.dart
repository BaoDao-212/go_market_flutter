import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart';

class AddTaskDialog extends StatefulWidget {
  final ShoppingBloc bloc;
  final int listId;

  AddTaskDialog({
    Key? key,
    required this.bloc,
    required this.listId,
  }) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String _foodName = '';
  int _quantity = 0;
  int _listId = 0;
  List<Food>? foods;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
    _listId = widget.listId;
    _foodName = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Task',
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
                      _foodName = state.foods.foods[0].name;
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
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: _addShopping,
          child: Text('Add'),
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

  void _addShopping() {
    print(_foodName);
    widget.bloc.add(TaskCreateEvent(
      foodName: _foodName,
      listId: _listId,
      quantity: _quantity,
    ));
    widget.bloc.add(ShoppingLoadedEvent());
    Navigator.pop(context);
  }
}
