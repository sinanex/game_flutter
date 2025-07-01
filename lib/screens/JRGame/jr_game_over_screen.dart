import 'package:flutter/material.dart';
import '../../game/JRGame/constants/jr_game_constants.dart';

class JRGameOverScreen extends StatelessWidget {
  final bool isWinner;
  final bool isPlayerDead;
  final VoidCallback onPlayAgain;

  const JRGameOverScreen({
    super.key,
    required this.isWinner,
    required this.isPlayerDead,
    required this.onPlayAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: JRGameConstants.backgroundBlack.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWinner ? 'SURVIVOR!' : 'ELIMINATED!',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w900,
                color:
                    isWinner
                        ? JRGameConstants.winnerGreen
                        : JRGameConstants.primaryRed,
                fontFamily: 'Courier',
                letterSpacing: 3.0,
                shadows: [
                  Shadow(
                    offset: Offset(4, 4),
                    blurRadius: 8,
                    color: Colors.black,
                  ),
                  if (isWinner)
                    Shadow(
                      offset: Offset(-1, -1),
                      blurRadius: 2,
                      color: Colors.yellow,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _getGameOverMessage(),
              style: const TextStyle(
                fontSize: 18,
                color: JRGameConstants.textWhite,
                fontFamily: 'Courier',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onPlayAgain,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JRGameConstants.primaryBlue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Courier',
                      letterSpacing: 2.0,
                      color: JRGameConstants.textWhite,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JRGameConstants.primaryOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'BACK TO MENU',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Courier',
                      letterSpacing: 2.0,
                      color: JRGameConstants.textWhite,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getGameOverMessage() {
    if (isWinner) {
      return 'You escaped! Well done!';
    } else if (isPlayerDead) {
      return 'You hit the rope or moved during red light!';
    } else {
      return 'Time\'s up! You didn\'t escape in time!';
    }
  }
}
