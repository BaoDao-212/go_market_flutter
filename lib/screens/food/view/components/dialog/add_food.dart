import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/bloc/bloc.dart';
import 'package:shop_app/screens/shared/view/widgets/custom_image.dart';
import 'package:image_picker/image_picker.dart';

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
  dynamic category;
  dynamic unit;
  late final XFile? photo;

  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add Food',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            BlocListener(
              listenWhen: (prev, curr) => prev != curr,
              listener: (context, state) {
                if (state is DataLoadSuccessState) {
                  setState(() {
                    category = state.category;
                    unit = state.unit;
                  });
                }
              },
              bloc: widget.bloc,
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: SquareImagePicker(
                onImageChanged: _handleImageChanged,
                imageUrl: '',
                hintText: 'Tap to add a photo of food',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            _buildTextField(
                'Name', 'Enter food name', (value) => _name = value),
            SizedBox(height: 12),
            if (unit != null)
              _buildUnitDropdown(unit.map((unit) => unit['unitName']).toList()),
            SizedBox(height: 12),
            if (category != null)
              _buildCategoryDropdown(
                  category.map((unit) => unit['name']).toList()),
          ]),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.bloc.add(FoodLoadedEvent());
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: _addFood,
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildUnitDropdown(List<dynamic> units) {
    _unitName = "${units[0]}";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _unitName,
        onChanged: (String? newValue) {
          setState(() {
            _unitName = newValue!;
          });
        },
        items: units.map((val) {
          return DropdownMenuItem(
            value: "${val}",
            child: Text("${val}"),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Food unit',
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(List<dynamic> categories) {
    _categoryName = "${categories[0]}";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _categoryName,
        onChanged: (String? newValue) {
          setState(() {
            _categoryName = newValue!;
          });
        },
        items: categories.map((val) {
          return DropdownMenuItem(
            value: "${val}",
            child: Text("${val}"),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Food category',
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, Function(String) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
        onChanged: onChanged,
        autofocus: label == 'Name', // Autofocus on the name field
      ),
    );
  }

  void _handleImageChanged(dynamic image) {
    setState(() {
      photo = image;
      print(photo);
    });
  }

  void _addFood() {
    final name = _name.trim();
    final unitName = _unitName.trim();
    final categoryName = _categoryName.trim();
    if (name.isEmpty || unitName.isEmpty || categoryName.isEmpty) {
      return;
    }

    widget.bloc.add(FoodCreateEvent(
      name: name,
      unitName: unitName,
      foodCategoryName: categoryName,
      image: photo!,
    ));
    Navigator.pop(context);
    widget.bloc.add(FoodLoadedEvent());
  }
}
