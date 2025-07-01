import 'package:flutter/material.dart';

class GameTextStyles {
  // Main title style
  static const TextStyle mainTitle = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    fontFamily: 'Courier',
    letterSpacing: 2.0,
    shadows: [
      Shadow(offset: Offset(3, 3), blurRadius: 6, color: Colors.black),
      Shadow(offset: Offset(-1, -1), blurRadius: 2, color: Colors.red),
    ],
  );

  // Instructions text
  static const TextStyle instructions = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontFamily: 'Courier',
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    shadows: [Shadow(offset: Offset(2, 2), blurRadius: 4, color: Colors.black)],
  );

  // Game over styles
  static const TextStyle eliminated = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w900,
    color: Colors.red,
    fontFamily: 'Courier',
    letterSpacing: 3.0,
    shadows: [Shadow(offset: Offset(4, 4), blurRadius: 8, color: Colors.black)],
  );

  static const TextStyle winner = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w900,
    color: Colors.green,
    fontFamily: 'Courier',
    letterSpacing: 3.0,
    shadows: [
      Shadow(offset: Offset(4, 4), blurRadius: 8, color: Colors.black),
      Shadow(offset: Offset(-1, -1), blurRadius: 2, color: Colors.yellow),
    ],
  );

  // Game UI styles
  static const TextStyle gameTimer = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w900,
    fontFamily: 'Courier',
    letterSpacing: 1.5,
  );

  static const TextStyle gameProgress = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Courier',
    letterSpacing: 1.0,
  );

  // Button styles
  static const TextStyle button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontFamily: 'Courier',
    letterSpacing: 2.0,
    color: Colors.white,
  );

  static const TextStyle moveButton = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    fontFamily: 'Courier',
    letterSpacing: 2.0,
    color: Colors.white,
    shadows: [Shadow(offset: Offset(2, 2), blurRadius: 4, color: Colors.black)],
  );

  // Subtitle styles
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontFamily: 'Courier',
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  // Finish line style
  static const TextStyle finishLine = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontFamily: 'Courier',
    fontSize: 12,
    letterSpacing: 1.0,
  );
}
