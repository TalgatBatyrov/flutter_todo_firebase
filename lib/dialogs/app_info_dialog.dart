import 'package:flutter/material.dart';

Future<void> showAppInfo(BuildContext context, String text) {
  return showDialog<void>(
    useRootNavigator: false,
    context: context,
    builder: (_) {
      return AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void showAppWarningSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(46.0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
