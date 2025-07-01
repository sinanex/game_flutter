import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../constants/text_styles.dart';
import '../models/game_state.dart';

class MoveButton extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onMove;

  const MoveButton({super.key, required this.gameState, required this.onMove});

  @override
  Widget build(BuildContext context) {
    if (!gameState.isGameActive) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: onMove,
        child: Container(
          height: GameConstants.moveButtonHeight,
          decoration: BoxDecoration(
            color:
                gameState.isGreenLight
                    ? Colors.green.withValues(alpha: 0.8)
                    : Colors.red.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: Text(
              gameState.isGreenLight ? 'TAP TO MOVE' : 'DON\'T MOVE!',
              style: GameTextStyles.moveButton,
            ),
          ),
        ),
      ),
    );
  }
}
