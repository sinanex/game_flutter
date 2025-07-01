import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final VoidCallback onSplashComplete;

  const SplashScreen({super.key, required this.onSplashComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashSequence();
  }

  void _startSplashSequence() async {
    // Wait for some time to show the animation
    await Future.delayed(const Duration(seconds: 7));

    // Navigate to game
    widget.onSplashComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFED1A76),
        child: Center(
          child: SizedBox(
            width: 300,
            height: 200,
            child: Lottie.asset(
              'assets/lotties/splash.json',
              fit: BoxFit.contain,
              repeat: true,
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}
