import 'package:flutter/material.dart';
import '../RGLight/game_controller.dart';
import '../../widgets/player_widget.dart';
import '../../widgets/doll_widget.dart';
import '../../widgets/finish_line_widget.dart';
import '../../widgets/game_ui.dart';
import '../../widgets/move_button.dart';
import '../../screens/RGLight/start_screen.dart';
import '../../screens/RGLight/game_over_screen.dart';
import '../../screens/RGLight/win_screen.dart';

class RGLightGame extends StatefulWidget {
  const RGLightGame({super.key});

  @override
  State<RGLightGame> createState() => _RGLightGameState();
}

class _RGLightGameState extends State<RGLightGame>
    with TickerProviderStateMixin {
  late GameController _gameController;

  @override
  void initState() {
    super.initState();
    _gameController = GameController();
    _gameController.initialize(this);
  }

  @override
  void dispose() {
    _gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _gameController,
        builder: (context, child) {
          return Stack(
            children: [
              // Background
              _buildBackground(),

              // Game elements (only visible when game is started)
              if (_gameController.gameState.isGameStarted) ...[
                // Game UI (guards, light indicator, stats)
                GameUI(gameState: _gameController.gameState),

                // Doll
                DollWidget(
                  gameState: _gameController.gameState,
                  dollRotationController:
                      _gameController.dollRotationController,
                ),

                // Finish line
                const FinishLineWidget(),

                // Player
                PlayerWidget(gameState: _gameController.gameState),

                // Move button
                MoveButton(
                  gameState: _gameController.gameState,
                  onMove: _gameController.movePlayer,
                ),
              ],

              // Screens based on game state
              if (!_gameController.gameState.isGameStarted)
                StartScreen(onStartGame: _gameController.startGame),

              if (_gameController.gameState.isPlayerDead)
                GameOverScreen(onTryAgain: _gameController.resetGame),

              if (_gameController.gameState.hasWon)
                WinScreen(
                  onPlayAgain: _gameController.resetGame,
                  confettiController: _gameController.confettiController,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sprites/background_sprite.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
