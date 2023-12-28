import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String category;
  final String unitName;
  final VoidCallback onDelete;
  final bool showDeleteButton;

  FoodCard({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.unitName,
    required this.onDelete,
    this.showDeleteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 30.0,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Category: $category",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "Unit: $unitName",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (showDeleteButton)
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 255, 17, 0),
                ),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
