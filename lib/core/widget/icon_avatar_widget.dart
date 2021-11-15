import 'package:flutter/material.dart';

class IconAvatarWidget extends StatelessWidget {
  final double? avatarWidth;
  final double? avatarHeight;
  final IconData iconData;
  final double iconSize;
  final EdgeInsetsGeometry? padding;

  const IconAvatarWidget({
    Key? key,
    this.avatarWidth,
    this.avatarHeight,
    required this.iconData,
    required this.iconSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: padding,
        width: avatarWidth,
        height: avatarHeight,
        color: Colors.teal,
        child: Icon(
          iconData,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
