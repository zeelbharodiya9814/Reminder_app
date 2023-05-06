import 'package:flutter/material.dart';
import 'package:pr_reminder_app/views/screens/homepage.dart';






void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => HomePage(),
      },
    ),
  );
}