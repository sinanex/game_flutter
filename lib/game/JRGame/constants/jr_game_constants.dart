import 'package:flutter/material.dart';

class JRGameConstants {
  // Player constants
  static const double playerSpeed = 16.0;
  static const double jumpHeight = 60.0;
  static const double playerStartY = 750.0;
  static const double playerWidth = 50.0;
  static const double playerHeight = 40.0;
  static const double playerCollisionWidth = 36.0; // 18 on each side

  // Rope constants
  static const double ropeY = 350.0;
  static const double ropeWidth = 10.0;
  static const double ropeHeight = 600.0;
  static const double ropeSwingRadius = 60.0;
  static const double ropeTopStart = 140.0;

  // Game timing
  static const int gameTimeLimit = 30;
  static const int legAnimationIntervalMs = 200;
  static const int moveStopDelayMs = 100;
  static const int deathDelaySeconds = 2;

  // Animation durations
  static const int jumpAnimationMs = 1000;
  static const int ropeAnimationMs = 10000;
  static const int confettiDurationSeconds = 3;

  // Screen positions
  static const double topPlatformY = 100.0;
  static const double bottomPlatformY = 130.0; // from bottom
  static const double platformWidth = 160.0;
  static const double platformHeight = 40.0;
  static const double railwayWidth = 60.0;
  static const double topReachY = 120.0;
  static const double maxPlayerY = 800.0;
  static const double minPlayerY = 100.0;

  // UI constants
  static const double controlButtonSmall = 80.0;
  static const double controlButtonLarge = 100.0;
  static const double topUIMargin = 50.0;
  static const double bottomControlsMargin = 50.0;

  // Colors
  static const Color primaryRed = Colors.red;
  static const Color primaryBlue = Colors.blue;
  static const Color primaryOrange = Colors.orange;
  static const Color backgroundBlack = Colors.black;
  static const Color textWhite = Colors.white;
  static const Color winnerGreen = Colors.green;

  // Asset paths
  static const String backgroundSprite =
      'assets/sprites/background_sprite_jr.png';
  static const String boyDollTop = 'assets/sprites/boy_doll_top.png';
  static const String dollBottom = 'assets/sprites/doll_forward.png';
  static const String deadPlayer = 'assets/sprites/dead_player.png';
  static const String leftLegPlayer = 'assets/sprites/left_leg_player.png';
  static const String rightLegPlayer = 'assets/sprites/right_leg_player.png';

  // Game physics
  static const double jumpSafetyOffset = -10.0;
  static const double ropeCollisionBuffer = 18.0;

  // Font
  static const String gameFont = 'Courier';

  // Confetti colors
  static const List<Color> confettiColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
}
