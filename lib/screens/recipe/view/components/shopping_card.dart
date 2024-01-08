import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shop_app/screens/recipe/view/components/dialog/recipe/detail.dart';
import 'package:shop_app/size_config.dart';

class RecipeCard extends StatefulWidget {
  final String htmlContent;
  final String name;
  final String description;
  final String foodName;
  final String foodImage;
  final VoidCallback onDelete;
  final double width;
  final double aspectRatio;

  RecipeCard({
    required this.name,
    required this.htmlContent,
    required this.description,
    required this.foodName,
    required this.foodImage,
    required this.onDelete,
    this.width = 335,
    this.aspectRatio = 0.65,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isEditMode = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(2),
          bottom: getProportionateScreenWidth(8)),
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
                    "${widget.name}",
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
              width: 100,
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
                      'Recipe name:${widget.name}',
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Description: ${widget.description.length > 50 ? widget.description.substring(0, 50) + '...' : widget.description}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.info,
                              color: Color.fromARGB(255, 0, 4, 255)),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomCardDialog(
                                  title: "Recipe details",
                                  name: widget.name,
                                  description: widget.description,
                                  htmlContent: widget.htmlContent,
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: widget.onDelete,
                        ),
                      ],
                    ),
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
