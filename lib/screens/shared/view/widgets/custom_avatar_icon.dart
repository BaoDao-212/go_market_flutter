import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWithCameraIcon extends StatefulWidget {
  final String imageUrl;
  final Function(dynamic imagePath) onImageChanged;

  AvatarWithCameraIcon({required this.imageUrl, required this.onImageChanged});

  @override
  _AvatarWithCameraIconState createState() => _AvatarWithCameraIconState();
}

class _AvatarWithCameraIconState extends State<AvatarWithCameraIcon> {
  XFile? _newImageUrl;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newImageUrl = pickedFile;
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
                    _newImageUrl = photo;
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

  void _updateImage(photo) {
    widget.onImageChanged(photo);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showImagePickerOptions();
      },
      child: Stack(
        children: [
          _newImageUrl == null || _newImageUrl!.path == null
              ? CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(widget.imageUrl),
                )
              : ClipOval(
                  child: Container(
                    width: 120, // Bán kính * 2
                    height: 120, // Bán kính * 2
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.file(
                      File(_newImageUrl!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 221, 193, 193),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () {
                  _showImagePickerOptions();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
