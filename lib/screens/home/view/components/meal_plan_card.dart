import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

class MealPlanCard extends StatefulWidget {
  final String timestamp;
  final String name;
  final String status;
  final String foodName;
  final String foodImage;
  final double width;
  final double aspectRatio;

  MealPlanCard({
    required this.name,
    required this.timestamp,
    required this.status,
    required this.foodName,
    required this.foodImage,
    this.width = 335,
    this.aspectRatio = 0.67,
  });

  @override
  _MealPlanCardState createState() => _MealPlanCardState();
}

class _MealPlanCardState extends State<MealPlanCard> {
  bool isEditMode = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(8),
          bottom: getProportionateScreenWidth(2)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isEditMode = !isEditMode;
            print(isEditMode);
          });
        },
        child: isEditMode ? buildEditModeCard() : buildNormalModeCard(),
      ),
    );
  }

  Widget buildNormalModeCard() {
    return SizedBox(
      width: getProportionateScreenWidth(widget.width),
      height: getProportionateScreenWidth(widget.width * widget.aspectRatio),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Image.network(
              widget.foodImage,
              fit: BoxFit.fill,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF343434).withOpacity(0.4),
                    Color(0xFF343434).withOpacity(0.15),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15.0),
                vertical: getProportionateScreenWidth(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.foodName}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenWidth(5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditModeCard() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        width: getProportionateScreenWidth(widget.width),
        height: getProportionateScreenWidth(widget.width * widget.aspectRatio),
        child: Row(
          children: [
            Container(
              width: 140,
              height: getProportionateScreenWidth(
                  widget.width * widget.aspectRatio),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.foodImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomLeft: Radius.circular(24.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Food name:${widget.foodName}',
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Name: ${widget.name}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Date: ${widget.timestamp}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
