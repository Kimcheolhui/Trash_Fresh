import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Colors.green,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.green),
    ),
  );
}
