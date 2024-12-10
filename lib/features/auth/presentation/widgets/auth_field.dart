import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String hintText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "$hintText is missing!";
        }

        return null;
      },
    );
  }
}
