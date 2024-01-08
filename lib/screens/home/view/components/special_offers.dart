import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/view/components/meal_plan_card.dart';
import 'package:shop_app/screens/meal_plan/view/screen/shopping_screen.dart';

import '../../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key? key,
    required this.mealPlan,
  }) : super(key: key);

  final dynamic mealPlan;

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mealPlan);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Meal plan",
            press: () {
              Navigator.pushNamed(context, MealPlanScreen.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (widget.mealPlan as List<dynamic>).map((meal) {
              return MealPlanCard(
                foodImage: meal.foodImage,
                foodName: meal.foodName,
                name: meal.name,
                status: meal.status,
                timestamp: meal.timestamp,
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
