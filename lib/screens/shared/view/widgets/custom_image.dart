import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashedBorderDecoration extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DashedBorderBoxPainter();
  }
}

class _DashedBorderBoxPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double dashWidth = 5.0;
    final double dashSpace = 5.0;
    double startY = offset.dy;

    while (startY < offset.dy + configuration.size!.height) {
      canvas.drawLine(
        Offset(offset.dx, startY),
        Offset(offset.dx, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;

  DashedBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 193, 191, 191),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: DecoratedBox(
          position: DecorationPosition.background,
          decoration: DashedBorderDecoration(),
          child: Container(
            color: Colors.white, // Background color for the dashed border
            child: child,
          ),
        ),
      ),
    );
  }
}

class SquareImagePicker extends StatefulWidget {
  final String? imageUrl;
  final Function(XFile imageFile) onImageChanged;
  final String hintText;

  SquareImagePicker({
    required this.onImageChanged,
    this.imageUrl,
    required this.hintText,
  });

  @override
  _SquareImagePickerState createState() => _SquareImagePickerState();
}

class _SquareImagePickerState extends State<SquareImagePicker> {
  XFile? _newImageFile;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newImageFile = XFile(pickedFile.path);
      });
      _updateImage(pickedFile);
    }
  }

  Future<void> _showImagePickerOptions() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose image from gallery'),
              onTap: () async {
                await _getImage();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Capture new image'),
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? photo =
                    await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  setState(() {
                    _newImageFile = photo;
                  });
                  _updateImage(photo);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateImage(XFile image) {
    widget.onImageChanged(image);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showImagePickerOptions();
      },
      child: DashedBorder(
        child: Stack(
          children: [
            if (widget.imageUrl != '' && _newImageFile == null)
              Stack(
                children: [
                  Image.network(
                    widget.imageUrl!,
                    height: 210,
                    width: 260,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Icon(Icons.camera_alt, color: Colors.grey),
                  ),
                ],
              )
            else if (_newImageFile == null)
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        widget.hintText,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              Image.file(
                File(_newImageFile!.path),
                height: 210,
                width: 260,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
