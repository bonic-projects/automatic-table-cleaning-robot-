import 'package:flutter/material.dart';

class StopButton extends StatelessWidget {
  final void Function() onTap;
  const StopButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 80,
        color: Colors.grey,
        child: const Center(
          child: Text(
            "Stop",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
        ),
      ),
    );
  }
}
