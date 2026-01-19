import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MediTriageApp());
}

class MediTriageApp extends StatelessWidget {
  const MediTriageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediTriage',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const WelcomeScreen(),
    );
  }
}