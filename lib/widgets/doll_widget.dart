import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../models/game_state.dart';

class DollWidget extends StatelessWidget {
  final GameState gameState;
  final AnimationController dollRotationController;

  const DollWidget({
    super.key,
    required this.gameState,
    required this.dollRotationController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: MediaQuery.of(context).size.width / 2 - GameConstants.dollSize / 2,
      child: AnimatedBuilder(
        animation: dollRotationController,
        builder: (context, child) {
          return Transform.scale(
            scaleX: dollRotationController.value > 0.5 ? -1 : 1,
            child: Image.asset(
              _getDollSprite(),
              width: GameConstants.dollSize,
              height: GameConstants.dollSize + 20,
            ),
          );
        },
      ),
    );
  }

  String _getDollSprite() {
    return gameState.isGreenLight
        ? 'assets/sprites/doll_forward.png'
        : 'assets/sprites/doll_front.png';
  }
}
