// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SnackBarComponent {
  void _show(BuildContext context, String message, IconData icon, Color color,
      {Color background = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: background,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 17, color: Colors.black54),
              ),
            ),
            /* InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, color: Colors.black54),
              ),
            ), */
          ],
        ),
      ),
    );
  }

  showError(BuildContext context, String message) =>
      _show(context, message, Icons.warning_amber_rounded, Colors.red);
  showWarning(BuildContext context, String message) =>
      _show(context, message, Icons.warning_amber_rounded, Colors.yellow);
  showSuccess(BuildContext context, String message) =>
      _show(context, message, Icons.check_circle_outline, Colors.green,
          background: Colors.green[100]!);
}
