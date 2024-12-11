import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context, {
  required String content,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
      ),
    );
}
