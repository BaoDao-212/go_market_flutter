import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/view/components/recipe_card.dart';
import 'package:shop_app/screens/recipe/view/screen/shopping_screen.dart';

import '../../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  final dynamic recipe;

  PopularProducts({Key? key, required this.recipe}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Recipe",
            press: () {
              Navigator.pushNamed(context, RecipeScreen.routeName);
            },
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (widget.recipe as List<dynamic>).map((meal) {
              return RecipeCard(
                description: meal.description,
                foodImage: meal.foodImage,
                foodName: meal.foodName,
                htmlContent: meal.htmlContent,
                name: meal.name,
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
