import 'package:flutter/material.dart';

class RightRotateButton extends StatelessWidget {
  final void Function() onTap;
  const RightRotateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Icon(
        Icons.rotate_right_outlined,
        size: 70,
        color: Colors.white,
      ),
    );
  }
}

//
