import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/recipe/logic/bloc/bloc.dart';
import 'package:shop_app/screens/recipe/view/components/dialog/recipe/delete.dart';
import 'package:shop_app/screens/recipe/view/components/shopping_card.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';

class RecipeScreen extends StatefulWidget {
  static const String routeName = "/recipe";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => RecipeBloc()..add(RecipeLoadedEvent(id: 1)),
          ),
        ],
        child: RecipeScreen(),
      );
    });
  }

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String selectedCategory = 'recipe';
  int foodID = 0;
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodNameIDController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController htmlContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoadInProgressState) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          }

          return Column(
            children: [
              ToggleButtons(
                isSelected: [
                  selectedCategory == 'recipe',
                  selectedCategory == 'create',
                ],
                onPressed: (int index) {
                  setState(() {
                    selectedCategory = index == 0 ? 'recipe' : 'create';
                  });
                },
                borderRadius: BorderRadius.circular(16.0),
                borderColor: Colors.grey,
                selectedBorderColor: kPrimaryColor,
                color: Colors.grey,
                selectedColor: Colors.white,
                fillColor: kPrimaryColor,
                borderWidth: 1.5,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.5),
                    child: Text(
                      'Recipe',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.5),
                    child: Text(
                      'Create',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: () async => context.read<RecipeBloc>().add(
                          RecipeLoadedEvent(
                            id: int.parse(foodNameIDController.text),
                          ),
                        ),
                    child: BlocBuilder<RecipeBloc, RecipeState>(
                      builder: (context, state) {
                        if (state is RecipeLoadSuccessState) {
                          foodNameController.text = state.food.foods[0].name;
                          if (foodID == 0)
                            foodNameIDController.text =
                                state.food.foods[0].name;
                          if (selectedCategory == 'recipe')
                            return ListView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 16.0,
                                ),
                                children: [
                                  _buildFoodIDNameDropdown(state.food.foods),
                                  ...state.recipe.recipe.map<Widget>((f) {
                                    return RecipeCard(
                                      foodImage: f.foodImage,
                                      foodName: f.foodName,
                                      name: f.name,
                                      htmlContent: f.htmlContent,
                                      description: f.description,
                                      onDelete: () {
                                        _showDeleteRecipeDialog(
                                            context, f.id, f.name);
                                      },
                                    );
                                  }).toList(),
                                ]);
                          else
                            return _buildCreateForm(state.food.foods);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCreateForm(List<Food> foods) {
    return Form(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          MainTextField(
            label: "Name",
            hintText: "Please enter recipe food",
            controller: nameController,
            defaultField: true,
          ),
          SizedBox(
            height: 12,
          ),
          MainTextField(
            label: "Description",
            hintText: "Please enter recipe desciption",
            controller: descriptionController,
            defaultField: true,
          ),
          SizedBox(
            height: 12,
          ),
          _buildFoodDropdown(foods?.map((f) => f.name.toString()).toList()),
          SizedBox(
            height: 12,
          ),
          MainTextField(
            label: "Recipe",
            hintText: "Please enter recipe",
            controller: htmlContentController,
            defaultField: true,
            messageField: true,
          ),
          SizedBox(
            height: 12,
          ),
          IconTextButton(
            text: "Create",
            onPressed: () => _addRecipeDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodDropdown(List<String>? foods) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: foods == null || foods.isEmpty
          ? CircularProgressIndicator()
          : DropdownButtonFormField<String>(
              value: foodNameController.text,
              onChanged: (String? newValue) async {
                setState(() {
                  foodNameController.text = newValue!;
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

  Widget _buildFoodIDNameDropdown(List<Food>? foods) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: foods == null || foods.isEmpty
          ? CircularProgressIndicator()
          : DropdownButtonFormField<String>(
              value: foodNameIDController.text,
              onChanged: (String? newValue) {
                setState(() {
                  foodNameIDController.text = newValue!;
                });
                foodID = foods
                    .firstWhere(
                        (food) => food.name == foodNameIDController.text)
                    .id;
                context.read<RecipeBloc>().add(RecipeLoadedEvent(id: foodID));
              },
              items: foods.map((f) => f.name.toString()).toList().map((val) {
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

  _addRecipeDialog(BuildContext context) {
    final bloc = context.read<RecipeBloc>();
    print(htmlContentController.text);
    bloc.add(RecipeCreateEvent(
        foodName: foodNameController.text,
        name: nameController.text,
        description: descriptionController.text,
        htmlContent:
            "<p>${htmlContentController.text.replaceAll('\n', '<br>')}</p>"));
    foodNameController.text = '';
    nameController.text = '';
    descriptionController.text = '';
    htmlContentController.text = '';
  }

  _showDeleteRecipeDialog(BuildContext context, int id, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteRecipeDialog(
        bloc: context.read<RecipeBloc>(),
        name: name,
        id: id,
        foodId: foodID,
      ),
    );
  }
}
