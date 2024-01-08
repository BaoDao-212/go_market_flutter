import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/food/logic/models/member.dart';
import 'package:shop_app/screens/food/view/screen/foods_screen.dart';
import 'package:shop_app/screens/meal_plan/view/screen/shopping_screen.dart';
import 'package:shop_app/screens/recipe/view/screen/shopping_screen.dart';
import 'package:shop_app/screens/shoppinglist/view/screen/shopping_screen.dart';

import '../../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Meal plan",
        "route": MealPlanScreen.routeName
      },
      {
        "icon": "assets/icons/Bill Icon.svg",
        "text": "Recipe",
        "route": RecipeScreen.routeName
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "Shopping",
        "route": ShoppingScreen.routeName
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Food",
        "route": FoodScreen.routeName
      },
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              Navigator.pushNamed(context, categories[index]["route"]);
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(65),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(65),
              width: getProportionateScreenWidth(65),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
