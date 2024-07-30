import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertbox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const MyAlertbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600]!),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          child: Text(
            "Save",
            style: TextStyle(color: Colors.greenAccent),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
        TextButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
