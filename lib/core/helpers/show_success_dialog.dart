import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 10),
            Text("Success", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(message, textAlign: TextAlign.center),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(color: Colors.green)),
          ),
        ],
      );
    },
  );
}
