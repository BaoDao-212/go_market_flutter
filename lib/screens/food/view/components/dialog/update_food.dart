import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/food/logic/bloc/bloc.dart';
import 'package:shop_app/screens/shared/view/widgets/custom_image.dart';
import 'package:image_picker/image_picker.dart';

class UpdateFoodDialog extends StatefulWidget {
  final FoodBloc bloc;
  final dynamic oldFood;

  UpdateFoodDialog({
    Key? key,
    required this.bloc,
    required this.oldFood,
  }) : super(key: key);

  @override
  _UpdateFoodDialogState createState() => _UpdateFoodDialogState();
}

class _UpdateFoodDialogState extends State<UpdateFoodDialog> {
  late String _name;
  late String _oldName;
  late String _unitName;
  late String _categoryName;
  late String _imageFood;
  dynamic category;
  dynamic unit;
  late final XFile? photo;
  @override
  void initState() {
    super.initState();
    widget.bloc.add(DataFoodLoadedEvent());
    _oldName = widget.oldFood.name;
    _name = widget.oldFood.name;
    _unitName = widget.oldFood.unitName;
    _categoryName = widget.oldFood.categoryName;
    _imageFood = widget.oldFood.imageUrl;
    photo = null;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.oldFood.imageUrl);
    return AlertDialog(
      title: Text(
        'Update food',
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
                imageUrl: widget.oldFood.imageUrl,
                hintText: 'Tap to update a photo of food',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            _buildTextField(
                'Name', 'Enter food name', (value) => _name = value, _name),
            SizedBox(
              height: 12,
            ),
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
          onPressed: _updateFood,
          child: Text('Update'),
        ),
      ],
    );
  }

  Widget _buildUnitDropdown(List<dynamic> units) {
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
      String label, String hint, Function(String) onChanged, String _name) {
    TextEditingController _nameController = TextEditingController(text: _name);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _nameController,
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

  void _updateFood() {
    final name = _name.trim();
    final unitName = _unitName.trim();
    final categoryName = _categoryName.trim();
    if (name.isEmpty || unitName.isEmpty || categoryName.isEmpty) {
      return;
    }

    print(12);
    print(photo != null ? photo : null);
    widget.bloc.add(FoodUpdateEvent(
      name: _oldName,
      newName: name,
      unitName: unitName,
      foodCategoryName: categoryName,
      image: photo != null ? photo : null,
    ));
    Navigator.pop(context);
    widget.bloc.add(FoodLoadedEvent());
  }
}
