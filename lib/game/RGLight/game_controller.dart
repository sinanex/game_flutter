import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../constants/game_constants.dart';
import '../../models/game_state.dart';

class GameController extends ChangeNotifier {
  GameState _gameState = GameState.initial;
  GameState get gameState => _gameState;

  // Controllers
  late AnimationController _playerAnimationController;
  late AnimationController _dollRotationController;
  late ConfettiController _confettiController;

  // Timers
  Timer? _gameTimer;
  Timer? _lightChangeTimer;
  Timer? _gracePeriodTimer;
  Timer? _playerMoveTimer;

  // Random generator
  final Random _random = Random();

  // Initialize controllers
  void initialize(TickerProvider vsync) {
    _playerAnimationController = AnimationController(
      duration: const Duration(milliseconds: GameConstants.playerAnimationMs),
      vsync: vsync,
    );

    _dollRotationController = AnimationController(
      duration: const Duration(milliseconds: GameConstants.dollRotationMs),
      vsync: vsync,
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: GameConstants.confettiDurationSec),
    );
  }

  // Getters for controllers
  AnimationController get playerAnimationController =>
      _playerAnimationController;
  AnimationController get dollRotationController => _dollRotationController;
  ConfettiController get confettiController => _confettiController;

  void startGame() {
    _updateGameState(
      _gameState.copyWith(
        status: GameStatus.playing,
        lightState: LightState.green,
        playerPosition: 0.0,
        remainingTime: GameConstants.gameDuration,
        isInGracePeriod: false,
      ),
    );

    // Start the game timer
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = _gameState.remainingTime - 1;

      if (newTime <= 0) {
        timer.cancel();
        _lightChangeTimer?.cancel();
        _updateGameState(_gameState.copyWith(status: GameStatus.gameOver));
      } else {
        _updateGameState(_gameState.copyWith(remainingTime: newTime));
      }
    });

    // Start light changes
    _changeLights();
  }

  void _changeLights() {
    // Random duration between min and max seconds
    final lightDuration =
        _random.nextInt(
          GameConstants.maxLightDuration - GameConstants.minLightDuration + 1,
        ) +
        GameConstants.minLightDuration;

    // Toggle light state
    final newLightState =
        _gameState.lightState == LightState.green
            ? LightState.red
            : LightState.green;

    _updateGameState(_gameState.copyWith(lightState: newLightState));

    // Handle doll rotation
    if (newLightState == LightState.green) {
      _dollRotationController.forward();
    } else {
      _dollRotationController.reverse();
      _startGracePeriod();
    }

    // Schedule next light change
    _lightChangeTimer = Timer(Duration(seconds: lightDuration), () {
      if (_gameState.isGameActive) {
        _changeLights();
      }
    });
  }

  void _startGracePeriod() {
    _updateGameState(_gameState.copyWith(isInGracePeriod: true));

    _gracePeriodTimer = Timer(
      const Duration(milliseconds: GameConstants.gracePeriodMs),
      () {
        _updateGameState(_gameState.copyWith(isInGracePeriod: false));
      },
    );
  }

  void movePlayer() {
    if (!_gameState.isGameActive) return;

    // Start moving animation
    _updateGameState(
      _gameState.copyWith(
        isPlayerMoving: true,
        showLeftLeg: !_gameState.showLeftLeg,
      ),
    );

    // Check if moving during red light (after grace period)
    if (_gameState.isRedLight && !_gameState.isInGracePeriod) {
      _killPlayer();
      return;
    }

    // Move player forward
    final newPosition =
        _gameState.playerPosition + GameConstants.playerMoveStep;
    _updateGameState(_gameState.copyWith(playerPosition: newPosition));

    // Check win condition
    if (newPosition >= GameConstants.finishLinePosition) {
      _winGame();
      return;
    }

    // Stop moving animation after a short delay
    _playerMoveTimer = Timer(
      const Duration(milliseconds: GameConstants.playerAnimationMs),
      () {
        _updateGameState(_gameState.copyWith(isPlayerMoving: false));
      },
    );
  }

  void _killPlayer() {
    _updateGameState(_gameState.copyWith(status: GameStatus.gameOver));
    _stopAllTimers();
  }

  void _winGame() {
    _updateGameState(_gameState.copyWith(status: GameStatus.won));
    _confettiController.play();
    _stopAllTimers();
  }

  void resetGame() {
    _stopAllTimers();
    _dollRotationController.reset();
    _confettiController.stop();
    _updateGameState(GameState.initial);
  }

  void _stopAllTimers() {
    _gameTimer?.cancel();
    _lightChangeTimer?.cancel();
    _gracePeriodTimer?.cancel();
    _playerMoveTimer?.cancel();
  }

  void _updateGameState(GameState newState) {
    _gameState = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _stopAllTimers();
    _playerAnimationController.dispose();
    _dollRotationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
}
