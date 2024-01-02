import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/fridge/logic/bloc/bloc.dart';

class AddFridgeDialog extends StatefulWidget {
  final FridgeBloc bloc;

  AddFridgeDialog({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _AddFridgeDialogState createState() => _AddFridgeDialogState();
}

class _AddFridgeDialogState extends State<AddFridgeDialog> {
  String _foodName = '';
  String _note = '';
  int _quantity = 0;
  DateTime _expiryDate = DateTime.now();
  List<Food>? foods;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Fridge',
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
              if (foods != null)
                _buildFoodDropdown(
                    foods!.map((f) => f.name.toString()).toList()),
              SizedBox(height: 12),
              _buildTextField(
                  'Quantity',
                  'Enter food quantity',
                  (value) => _quantity = int.parse(value),
                  _quantity.toString()),
              _buildDateTimeField(
                'Expiry Date',
                'Select expiry date',
                (value) => {}, // Không cần sử dụng onChanged
                _expiryDate != null
                    ? DateFormat('dd/MM/yyyy').format(_expiryDate)
                    : 'Select expiry date',
                _selectExpiryDate,
              ),
              _buildTextField('Note', 'Enter food note',
                  (value) => _note = value, _note.toString()),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.bloc.add(FridgeLoadedEvent());
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: _addFridge,
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildFoodDropdown(List<String> foods) {
    _foodName = foods[0];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
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

  void _addFridge() {
    DateTime now = DateTime.now();
    DateTime midnightToday = DateTime(now.year, now.month, now.day, 0, 0, 0);
    Duration difference = _expiryDate.difference(midnightToday);
    int minutesDifference = difference.inMinutes;
    widget.bloc.add(FridgeCreateEvent(
        foodName: _foodName,
        quantity: _quantity,
        useWithin: minutesDifference,
        note: _note));
    widget.bloc.add(FridgeLoadedEvent());
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
