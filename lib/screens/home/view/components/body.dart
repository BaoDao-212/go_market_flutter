import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/view/components/special_offers.dart';

import '../../../../size_config.dart';
import 'categories.dart';
import 'home_header.dart';
import 'popular_product.dart';

class Body extends StatelessWidget {
  final dynamic recipe;
  final dynamic mealPlan;

  const Body({
    Key? key,
    required this.recipe,
    required this.mealPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(30)),
            SpecialOffers(mealPlan: mealPlan),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(
              recipe: recipe,
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
