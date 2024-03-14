import 'package:flutter/material.dart';

class LeftRotateButton extends StatelessWidget {
  final void Function() onTap;
  const LeftRotateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Icon(
        Icons.rotate_left_outlined,
        size: 70,
        color: Colors.white,
      ),
    );
  }
}
