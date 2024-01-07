import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/meal_plan/logic/bloc/bloc.dart';

class AddMealPlanDialog extends StatefulWidget {
  final MealPlanBloc bloc;
  final String date;

  AddMealPlanDialog({
    Key? key,
    required this.bloc,
    required this.date,
  }) : super(key: key);

  @override
  _AddMealPlanDialogState createState() => _AddMealPlanDialogState();
}

class _AddMealPlanDialogState extends State<AddMealPlanDialog> {
  String _name = 'breakfast';
  String _foodName = '';
  DateTime _expiryDate = DateTime.now();
  List<Food>? foods;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
    foods = [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add MealPlan',
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
                    setState(() {
                      foods = state.foods.foods;
                      _foodName = foods?[0].name as String;
                    });
                  }
                },
                bloc: widget.bloc,
                child: Container(),
              ),
              _buildFoodDropdown(
                foods?.map((f) => f.name.toString()).toList(),
              ),
              SizedBox(height: 12),
              _buildNameDropdown(),
              SizedBox(height: 12),
              _buildDateTimeField(
                'Expiry Date',
                'Select expiry date',
                (value) => {},
                _expiryDate != null
                    ? DateFormat('MM/dd/yyyy').format(_expiryDate)
                    : 'Select expiry date',
                _selectExpiryDate,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.bloc.add(MealPlanLoadedEvent(date: widget.date));
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: _addMealPlan,
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildFoodDropdown(List<String>? foods) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: foods == null || foods.isEmpty
          ? CircularProgressIndicator()
          : DropdownButtonFormField<String>(
              value: _foodName,
              onChanged: (String? newValue) {
                setState(() {
                  _foodName = newValue!;
                });
              },
              items: foods.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Food',
              ),
            ),
    );
  }

  Widget _buildNameDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _name,
        onChanged: (String? newValue) {
          setState(() {
            _name = newValue!;
          });
        },
        items: ['breakfast', 'lunch', 'dinner'].map((val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
    );
  }

  Widget _buildDateTimeField(
    String label,
    String hint,
    Function(String) onChanged,
    String value,
    VoidCallback selectDate,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: IconButton(
            onPressed: selectDate,
            icon: Icon(Icons.date_range),
          ),
        ),
        onChanged: onChanged,
        autofocus: label == 'Name',
        keyboardType: label == 'Quantity' ? TextInputType.number : null,
        controller: TextEditingController(text: value),
      ),
    );
  }

  void _addMealPlan() {
    widget.bloc.add(MealPlanCreateEvent(
      foodName: _foodName,
      name: _name,
      timestamp: DateFormat('MM/dd/yyyy').format(_expiryDate),
      date: widget.date,
    ));
    widget.bloc.add(MealPlanLoadedEvent(date: widget.date));
    Navigator.pop(context);
  }

  Future<void> _selectExpiryDate() async {
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 10),
    );

    if (pickedDate != null && pickedDate != _expiryDate) {
      setState(() {
        _expiryDate = pickedDate;
      });
    }
  }
}
