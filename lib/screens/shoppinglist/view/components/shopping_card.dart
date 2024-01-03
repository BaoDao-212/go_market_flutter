import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCard extends StatefulWidget {
  final String name;
  final String note;
  final dynamic tasks;
  final DateTime date;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  ShoppingCard({
    required this.name,
    required this.note,
    required this.date,
    required this.tasks,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  bool isExpanded = false;

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
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.update, color: Colors.green),
                              onPressed: widget.onUpdate,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: widget.onDelete,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Note: ${widget.note}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(widget.date)}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded) ...[
              TaskListWidget(tasks: widget.tasks),
            ],
          ],
        ),
      ),
    );
  }
}

class TaskListWidget extends StatelessWidget {
  final dynamic tasks;

  TaskListWidget({required this.tasks});

  @override
  Widget build(BuildContext context) {
    // Customize this part based on your task representation
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var task in tasks)
            Container(
              margin: EdgeInsets.only(bottom: 8.0, left: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: task['done'] == 1 ? Colors.green : Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Stack(
                children: [
                  ListTile(
                    leading: Image.network(
                      task['Food.imageUrl'],
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      task['Food.name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Quantity: ${task['quantity']} ${task['Food.UnitOfMeasurement.unitName']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: task['done'] == 1 ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(1.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        task['done'] == 1 ? 'DONE' : 'TO DO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}