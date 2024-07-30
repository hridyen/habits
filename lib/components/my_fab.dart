import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green.shade400,
      onPressed: onPressed,
      child: Icon(
        CupertinoIcons.add,
        color: Colors.white,
        size: 28,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
    );
  }
}
