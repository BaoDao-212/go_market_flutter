import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/bloc/bloc.dart'; // Assuming the correct import for the food bloc

class AddFoodDialog extends StatefulWidget {
  final FoodBloc bloc;

  AddFoodDialog({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _AddFoodDialogState createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  String _name = '';
  String _unitName = '';
  String _categoryName = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Food'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener(
            listenWhen: (prev, curr) =>
                prev != curr, // Assuming the correct state for food addition
            listener: (context, state) {
              Navigator.pop(context);
            },
            bloc: widget.bloc,
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onChanged: (value) => setState(() => _name = value),
              autofocus: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Unit Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onChanged: (value) => setState(() => _unitName = value),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onChanged: (value) => setState(() => _categoryName = value),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              onChanged: (value) => setState(() => _imageUrl = value),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // Change the button color
          ),
          onPressed: () => _addFood(),
          child: Text('Add'), // Change the button text
        ),
      ],
    );
  }

  _addFood() {
    final name = _name.trim();
    final unitName = _unitName.trim();
    final categoryName = _categoryName.trim();
    final imageUrl = _imageUrl.trim();

    if (name.isEmpty ||
        unitName.isEmpty ||
        categoryName.isEmpty ||
        imageUrl.isEmpty) {
      return;
    }

    // widget.bloc.add(FoodAddEvent(
    //   name: name,
    //   unitName: unitName,
    //   categoryName: categoryName,
    //   imageUrl: imageUrl,
    // ));
    Navigator.pop(context);
  }
}
