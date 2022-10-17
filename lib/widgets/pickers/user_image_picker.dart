import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File? pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(File(pickedImageFile!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        ElevatedButton.icon(
          // style: ButtonStyle(backgroundColor: Theme.of(context).colorScheme.primary),
          icon: Icon(Icons.image),
          onPressed: _pickImage,
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
