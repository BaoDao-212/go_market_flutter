import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomCardDialog extends StatelessWidget {
  final String title;
  final String name;
  final String description;
  final String htmlContent;

  CustomCardDialog({
    required this.title,
    required this.name,
    required this.description,
    required this.htmlContent,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name: $name",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Description: $description",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            if (htmlContent.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(data: htmlContent),
              ),
          ],
        ),
      ),
    );
  }
}
