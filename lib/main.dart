import 'package:flutter/material.dart';
import 'screens/squid_game_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squid Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD62598)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SquidGameApp(),
    );
  }
}
