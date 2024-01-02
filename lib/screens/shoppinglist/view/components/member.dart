import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FridgeCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String note;
  final String type;
  final int quantity;
  final DateTime expiredDate;
  final DateTime startDate;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  FridgeCard({
    required this.imageUrl,
    required this.name,
    required this.note,
    required this.type,
    required this.quantity,
    required this.expiredDate,
    required this.startDate,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth * 1.5;

    return Card(
      margin: EdgeInsets.only(bottom: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: cardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Container(
                width: double.infinity,
                height: cardHeight * 0.45,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.update, color: Colors.green),
                            onPressed: onUpdate,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Type: $type',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Quantity: $quantity',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Start Date: ${DateFormat('HH:mm dd/MM/yyyy').format(startDate)}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Expired Date: ${DateFormat('HH:mm dd/MM/yyyy').format(expiredDate)}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Note: $note',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
