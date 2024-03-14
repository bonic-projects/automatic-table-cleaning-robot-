import 'package:flutter/material.dart';

class LeftwardTriangle extends StatelessWidget {
  final void Function() onTap;
  const LeftwardTriangle({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Stack(
        children: [
          ClipPath(
            clipper: _Triangle(),
            child: Container(
              color: Colors.white,
              width: 100,
              height: 100,
              child: const Center(
                child: Icon(
                  Icons.keyboard_double_arrow_left_outlined,
                  size: 60,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Triangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
