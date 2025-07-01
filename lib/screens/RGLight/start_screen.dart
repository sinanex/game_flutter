import 'package:flutter/material.dart';
import '../../constants/text_styles.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStartGame;

  const StartScreen({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'RED LIGHT\nGREEN LIGHT',
            textAlign: TextAlign.center,
            style: GameTextStyles.mainTitle,
          ),
          const SizedBox(height: 20),
          const Text(
            'TAP TO MOVE WHEN GREEN\nDON\'T MOVE WHEN RED\nREACH THE FINISH LINE IN 30 SECONDS!',
            textAlign: TextAlign.center,
            style: GameTextStyles.instructions,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onStartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('START GAME', style: GameTextStyles.button),
          ),
        ],
      ),
    );
  }
}
