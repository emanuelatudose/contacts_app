import 'dart:io';
import 'package:flutter/material.dart';
import 'icon_avatar_widget.dart';

class EditableAvatarWidget extends StatelessWidget {
  const EditableAvatarWidget({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Image.file(
            imageFile,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(2.0),
              color: Colors.white,
              child: const IconAvatarWidget(
                padding: EdgeInsets.all(6.0),
                iconData: Icons.add_a_photo,
                iconSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
