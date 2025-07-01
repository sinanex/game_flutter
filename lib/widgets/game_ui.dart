import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../constants/text_styles.dart';
import '../models/game_state.dart';

class GameUI extends StatelessWidget {
  final GameState gameState;

  const GameUI({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Guards on top corners
        _buildGuards(),

        // Light indicator
        // _buildLightIndicator(context),

        // Game stats
        _buildGameStats(context),
      ],
    );
  }

  Widget _buildGuards() {
    return Stack(
      children: [
        // Left guard
        Positioned(
          top: 50,
          left: 20,
          child: Image.asset(
            'assets/sprites/guard.png',
            width: GameConstants.guardSize,
            height: GameConstants.guardSize + 20,
          ),
        ),
        // Right guard
        Positioned(
          top: 50,
          right: 20,
          child: Image.asset(
            'assets/sprites/guard.png',
            width: GameConstants.guardSize,
            height: GameConstants.guardSize + 20,
          ),
        ),
      ],
    );
  }

  Widget _buildGameStats(BuildContext context) {
    if (!gameState.isGameStarted) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 60,
      left: MediaQuery.of(context).size.width / 2 - 100,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              'TIME: ${gameState.remainingTime}s',
              style: GameTextStyles.gameTimer,
            ),
            // Text(
            //   'PROGRESS: ${gameState.progressPercentage}%',
            //   style: GameTextStyles.gameProgress,
            // ),
          ],
        ),
      ),
    );
  }
}
