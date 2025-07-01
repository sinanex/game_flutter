import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../constants/text_styles.dart';

class FinishLineWidget extends StatelessWidget {
  const FinishLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate position - if > 1.0, it goes above the visible screen
    final screenHeight = MediaQuery.of(context).size.height;
    final finishPosition =
        screenHeight - (100 + (GameConstants.finishLinePosition * 300));

    return Positioned(
      top: finishPosition,
      left: 0,
      right: 0,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border.all(color: Colors.red, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'FINISH LINE - SURVIVE!',
            style: GameTextStyles.finishLine,
          ),
        ),
      ),
    );
  }
}
