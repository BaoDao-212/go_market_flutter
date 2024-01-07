import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/meal_plan/logic/bloc/bloc.dart';
import 'package:shop_app/screens/meal_plan/logic/models/member.dart';
import 'package:shop_app/screens/meal_plan/view/components/dialog/mealplan/add.dart';
import 'package:shop_app/screens/meal_plan/view/components/dialog/mealplan/delete.dart';
import 'package:shop_app/screens/meal_plan/view/components/dialog/mealplan/update.dart';
import 'package:shop_app/screens/meal_plan/view/components/shopping_card.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class MealPlanScreen extends StatefulWidget {
  static const String routeName = "/meal_plan";

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => MealPlanBloc()
              ..add(MealPlanLoadedEvent(
                  date: DateFormat('MM/dd/yyyy').format(DateTime.now()))),
          ),
        ],
        child: MealPlanScreen(),
      );
    });
  }

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final TextEditingController _expiryDateController = TextEditingController(
      text: DateFormat('MM/dd/yyyy').format(DateTime.now()));
  DateTime _expiryDate = DateTime.now();
  String selectedCategory = 'breakfast';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Meal Plan'),
      ),
      body: BlocBuilder<MealPlanBloc, MealPlanState>(
        builder: (context, state) {
          if (state is MealPlanLoadInProgressState) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildDateTimeField(
                        'Date',
                        'Select expiry date',
                        (value) => {},
                        _expiryDate != null
                            ? DateFormat('MM/dd/yyyy').format(_expiryDate)
                            : 'Select expiry date',
                        _selectExpiryDate,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        showAddMealPlanDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        primary: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8.0),
                          Text('Add'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              ToggleButtons(
                isSelected: [
                  selectedCategory == 'breakfast',
                  selectedCategory == 'lunch',
                  selectedCategory == 'dinner',
                ],
                onPressed: (int index) {
                  setState(() {
                    selectedCategory = index == 0
                        ? 'breakfast'
                        : index == 1
                            ? 'lunch'
                            : 'dinner';
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
                      'Breakfast',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.5),
                    child: Text(
                      'Lunch',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.5),
                    child: Text(
                      'Dinner',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: () async => context.read<MealPlanBloc>().add(
                          MealPlanLoadedEvent(
                            date: DateFormat('MM/dd/yyyy').format(_expiryDate),
                          ),
                        ),
                    child: BlocBuilder<MealPlanBloc, MealPlanState>(
                      builder: (context, state) {
                        if (state is MealPlanLoadSuccessState) {
                          List<MealPlan> displayedList = [];
                          List<MealPlan> breakfast = [];
                          List<MealPlan> lunch = [];
                          List<MealPlan> dinner = [];
                          state.mealPlan.mealPlan.forEach((e) => {
                                if (e.name == 'breakfast')
                                  breakfast.add(e)
                                else if (e.name == 'lunch')
                                  lunch.add(e)
                                else if (e.name == 'dinner')
                                  dinner.add(e)
                              });
                          if (selectedCategory == 'breakfast') {
                            displayedList = breakfast;
                          } else if (selectedCategory == 'lunch') {
                            displayedList = lunch;
                          } else if (selectedCategory == 'dinner') {
                            displayedList = dinner;
                          }

                          return ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 16.0,
                            ),
                            children: displayedList.map<Widget>((f) {
                              return MealPlanCard(
                                foodImage: f.foodImage,
                                foodName: f.foodName,
                                name: f.name,
                                status: f.status,
                                timestamp: f.timestamp,
                                onDelete: () {
                                  _showDeleteMealPlanDialog(
                                      context, f.id, f.name);
                                },
                                onUpdate: () {
                                  _showUpdateMealPlanDialog(context, f);
                                },
                              );
                            }).toList(),
                          );
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

  Widget _buildCategoryButton(String label, String category) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Text(label),
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
      padding: EdgeInsets.symmetric(vertical: 4.0),
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
        controller: _expiryDateController,
      ),
    );
  }

  Future<void> _selectExpiryDate() async {
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.month - 1),
      lastDate: DateTime(currentDate.year + 1),
    );

    if (pickedDate != null && pickedDate != _expiryDate) {
      setState(() {
        _expiryDate = pickedDate;
        _expiryDateController.text =
            DateFormat('MM/dd/yyyy').format(_expiryDate);
      });
    }
    context
        .read<MealPlanBloc>()
        .add(MealPlanLoadedEvent(date: _expiryDateController.text));
  }

  showAddMealPlanDialog(BuildContext context) {
    final bloc = context.read<MealPlanBloc>();
    return showDialog(
      context: context,
      builder: (_) => AddMealPlanDialog(
        bloc: bloc,
        date: _expiryDateController.text,
      ),
    );
  }

  _showDeleteMealPlanDialog(BuildContext context, int id, String name) {
    return showDialog(
      context: context,
      builder: (_) => DeleteMealPlanDialog(
        bloc: context.read<MealPlanBloc>(),
        name: name,
        id: id,
        date: _expiryDateController.text,
      ),
    );
  }

  _showUpdateMealPlanDialog(BuildContext context, dynamic meal) {
    final bloc = context.read<MealPlanBloc>();
    return showDialog(
      context: context,
      builder: (_) => UpdateMealPlanDialog(
        bloc: bloc,
        mealPlan: meal,
        date: _expiryDateController.text,
      ),
    );
  }
}
