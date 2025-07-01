import 'package:flutter/material.dart';
import 'RGLight/splash_screen.dart';
import 'menu_screen.dart';

class SquidGameApp extends StatefulWidget {
  const SquidGameApp({super.key});

  @override
  State<SquidGameApp> createState() => _SquidGameAppState();
}

class _SquidGameAppState extends State<SquidGameApp> {
  bool _showSplash = true;

  void _onSplashComplete() {
    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash
        ? SplashScreen(onSplashComplete: _onSplashComplete)
        : const MenuScreen();
  }
}
