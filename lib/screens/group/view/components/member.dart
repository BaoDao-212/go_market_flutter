import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String photoUrl;
  final int id;
  final VoidCallback onDelete;
  final bool
      showDeleteButton; // Add a boolean to control whether to show the delete button

  MemberCard({
    required this.name,
    required this.photoUrl,
    required this.id,
    required this.onDelete,
    this.showDeleteButton = true, // Default to true
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
              backgroundImage: NetworkImage(photoUrl),
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
                    "ID: $id",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (showDeleteButton) // Conditionally show the delete button
              IconButton(
                icon: Icon(Icons.delete,
                    color: Color.fromARGB(
                        255, 255, 17, 0)), // Set the color to red
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
