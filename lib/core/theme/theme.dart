import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border({
    Color? color,
  }) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? AppPallete.borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(
        color: AppPallete.gradient2,
      ),
    ),
  );
}
