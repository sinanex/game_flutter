import 'package:flutter/material.dart';
import 'dart:math';
import '../../game/JRGame/constants/jr_game_constants.dart';
import '../../game/JRGame/models/jr_game_state.dart';

class JRGameUI extends StatelessWidget {
  final JRGameState gameState;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final VoidCallback onJump;

  const JRGameUI({
    super.key,
    required this.gameState,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onJump,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Top UI
        _buildTopUI(),

        // Game Area
        _buildGameArea(context, screenWidth),

        // Controls
        _buildControls(),
      ],
    );
  }

  Widget _buildTopUI() {
    return Positioned(
      top: JRGameConstants.topUIMargin,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: JRGameConstants.backgroundBlack.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'TIME: ${gameState.gameTimeLeft}',
              style: const TextStyle(
                color: JRGameConstants.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'Courier',
                letterSpacing: 1.5,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: JRGameConstants.primaryOrange.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'JUMP ROPE',
              style: TextStyle(
                color: JRGameConstants.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'Courier',
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameArea(BuildContext context, double screenWidth) {
    return Stack(
      children: [
        // Railway tracks (vertical)
        _buildRailwayTracks(screenWidth),

        // Top platform with boy doll
        _buildTopPlatform(screenWidth),

        // Bottom platform with girl doll
        _buildBottomPlatform(screenWidth),

        // Rope
        _buildRope(screenWidth),

        // Player
        _buildPlayer(screenWidth),
      ],
    );
  }

  Widget _buildRailwayTracks(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - JRGameConstants.railwayWidth / 2,
      top: JRGameConstants.topReachY,
      bottom: 150,
      child: Container(
        width: JRGameConstants.railwayWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[400]!, Colors.brown[600]!],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPlatform(double screenWidth) {
    return Positioned(
      top: JRGameConstants.topPlatformY,
      left: screenWidth / 2 - JRGameConstants.platformWidth / 2,
      child: Container(
        width: JRGameConstants.platformWidth,
        height: JRGameConstants.platformHeight,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(JRGameConstants.boyDollTop, width: 50, height: 35),
        ),
      ),
    );
  }

  Widget _buildBottomPlatform(double screenWidth) {
    return Positioned(
      bottom: JRGameConstants.bottomPlatformY,
      left: screenWidth / 2 - JRGameConstants.platformWidth / 2,
      child: Container(
        width: JRGameConstants.platformWidth,
        height: JRGameConstants.platformHeight,
        decoration: BoxDecoration(
          color: Colors.brown[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(JRGameConstants.dollBottom, width: 50, height: 35),
        ),
      ),
    );
  }

  Widget _buildRope(double screenWidth) {
    return Positioned(
      left:
          screenWidth / 2 -
          JRGameConstants.ropeWidth / 2 +
          sin(gameState.ropeRotation) * JRGameConstants.ropeSwingRadius,
      top: JRGameConstants.ropeTopStart,
      child: Container(
        width: JRGameConstants.ropeWidth,
        height: JRGameConstants.ropeHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown[700]!,
              Colors.brown[900]!,
              Colors.brown[700]!,
            ],
          ),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: JRGameConstants.backgroundBlack.withValues(alpha: 0.5),
              blurRadius: 4,
              offset: const Offset(3, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer(double screenWidth) {
    return Positioned(
      left: screenWidth / 2 - JRGameConstants.playerWidth / 2,
      top: gameState.playerY + gameState.playerJumpOffset,
      child: SizedBox(
        width: JRGameConstants.playerWidth,
        height: JRGameConstants.playerHeight,
        child:
            gameState.isPlayerDead
                ? Image.asset(
                  JRGameConstants.deadPlayer,
                  width: JRGameConstants.playerWidth,
                  height: JRGameConstants.playerHeight,
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      gameState.showLeftLeg
                          ? JRGameConstants.leftLegPlayer
                          : JRGameConstants.rightLegPlayer,
                      width: 30,
                      height: 40,
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: JRGameConstants.bottomControlsMargin,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Move down
          _buildControlButton(
            onTap: onMoveDown,
            icon: Icons.arrow_downward,
            color: JRGameConstants.primaryBlue,
            size: JRGameConstants.controlButtonSmall,
          ),

          // Jump
          _buildControlButton(
            onTap: onJump,
            icon: Icons.keyboard_arrow_up,
            color: JRGameConstants.primaryOrange,
            size: JRGameConstants.controlButtonLarge,
            iconSize: 50,
          ),

          // Move up
          _buildControlButton(
            onTap: onMoveUp,
            icon: Icons.arrow_upward,
            color: JRGameConstants.primaryBlue,
            size: JRGameConstants.controlButtonSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required double size,
    double iconSize = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: JRGameConstants.textWhite, size: iconSize),
      ),
    );
  }
}
