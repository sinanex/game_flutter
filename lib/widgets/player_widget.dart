import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../models/game_state.dart';

class PlayerWidget extends StatelessWidget {
  final GameState gameState;

  const PlayerWidget({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    if (gameState.isPlayerDead) {
      return _buildDeadPlayer(context);
    }
    return _buildAlivePlayer(context);
  }

  Widget _buildAlivePlayer(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playerBottom =
        screenHeight - (100 + (gameState.playerPosition * 300));

    return AnimatedPositioned(
      duration: const Duration(milliseconds: GameConstants.playerAnimationMs),
      top: playerBottom,
      left:
          MediaQuery.of(context).size.width / 2 - GameConstants.playerSize / 2,
      child: Image.asset(
        _getPlayerSprite(),
        width: GameConstants.playerSize,
        height: GameConstants.playerSize + 10,
      ),
    );
  }

  Widget _buildDeadPlayer(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playerBottom =
        screenHeight - (100 + (gameState.playerPosition * 300));

    return Positioned(
      top: playerBottom,
      left:
          MediaQuery.of(context).size.width / 2 - GameConstants.playerSize / 2,
      child: Image.asset(
        'assets/sprites/dead_player.png',
        width: GameConstants.playerSize,
        height: GameConstants.playerSize + 10,
      ),
    );
  }

  String _getPlayerSprite() {
    if (gameState.isPlayerMoving) {
      return gameState.showLeftLeg
          ? 'assets/sprites/left_leg_player.png'
          : 'assets/sprites/right_leg_player.png';
    }
    return 'assets/sprites/left_leg_player.png';
  }
}
