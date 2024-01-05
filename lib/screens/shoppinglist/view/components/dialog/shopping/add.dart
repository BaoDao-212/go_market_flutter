import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/group/logic/models/member.dart';
import 'package:shop_app/screens/shoppinglist/logic/bloc/bloc.dart';

class AddShoppingDialog extends StatefulWidget {
  final ShoppingBloc bloc;

  AddShoppingDialog({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _AddShoppingDialogState createState() => _AddShoppingDialogState();
}

class _AddShoppingDialogState extends State<AddShoppingDialog> {
  String _name = '';
  String _note = '';
  String _assignToUsername = '';
  DateTime _expiryDate = DateTime.now();
  List<Member>? members;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataMemberLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Shopping',
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
                  if (state is MemberLoadedSuccessState) {
                    print(state.members.members);
                    setState(() {
                      members = state.members.members;
                    });
                  }
                },
                bloc: widget.bloc,
                child: Container(),
              ),
              _buildMemberDropdown(
                members?.map((f) => f.username.toString()).toList(),
              ),
              SizedBox(height: 12),
              _buildTextField('Name', 'Enter shopping name',
                  (value) => _name = value, _name.toString()),
              SizedBox(height: 12),
              _buildDateTimeField(
                'Expiry Date',
                'Select expiry date',
                (value) => {},
                _expiryDate != null
                    ? DateFormat('dd/MM/yyyy').format(_expiryDate)
                    : 'Select expiry date',
                _selectExpiryDate,
              ),
              _buildTextField('Note', 'Enter member note',
                  (value) => _note = value, _note.toString()),
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

  Widget _buildMemberDropdown(List<String>? members) {
    String _assignToUsername = members?.isNotEmpty == true ? members![0] : '';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: members == null || members.isEmpty
          ? CircularProgressIndicator()
          : DropdownButtonFormField<String>(
              value: _assignToUsername,
              onChanged: (String? newValue) {
                setState(() {
                  _assignToUsername = newValue!;
                });
              },
              items: members.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(val),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Member',
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

  void _addShopping() {
    widget.bloc.add(ShoppingCreateEvent(
        date: _expiryDate.toString(),
        assignToUsername: _assignToUsername,
        name: _name,
        note: _note));
    widget.bloc.add(ShoppingLoadedEvent());
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
