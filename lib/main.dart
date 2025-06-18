import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HandDocApp());
}

class HandDocApp extends StatelessWidget {
  const HandDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandDoc AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}