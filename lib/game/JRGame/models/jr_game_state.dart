import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import '../constants/jr_game_constants.dart';

class JRGameState {
  // Game state
  bool isGameStarted = false;
  bool isGameOver = false;
  bool isWinner = false;
  bool isPlayerDead = false;
  bool isPlayerJumping = false;
  bool isPlayerMoving = false;

  // Player position and animation
  double playerY = JRGameConstants.playerStartY;
  double playerJumpOffset = 0.0;
  bool showLeftLeg = true;

  // Rope animation
  double ropeRotation = 0.0;

  // Timer
  int gameTimeLeft = JRGameConstants.gameTimeLimit;
  Timer? gameTimer;
  Timer? legAnimationTimer;

  // Callbacks
  VoidCallback? onStateChanged;
  VoidCallback? onPlayerDeath;
  VoidCallback? onGameWon;

  JRGameState({this.onStateChanged, this.onPlayerDeath, this.onGameWon});

  void startGame() {
    isGameStarted = true;
    isGameOver = false;
    isWinner = false;
    isPlayerDead = false;
    playerY = JRGameConstants.playerStartY;
    gameTimeLeft = JRGameConstants.gameTimeLimit;
    _notifyStateChanged();

    // Start game timer
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      gameTimeLeft--;
      _notifyStateChanged();

      if (gameTimeLeft <= 0) {
        gameOver(false);
      }
    });

    // Start leg animation
    _startLegAnimation();
  }

  void _startLegAnimation() {
    legAnimationTimer = Timer.periodic(
      Duration(milliseconds: JRGameConstants.legAnimationIntervalMs),
      (timer) {
        if (isPlayerMoving && !isPlayerJumping) {
          showLeftLeg = !showLeftLeg;
          _notifyStateChanged();
        }
      },
    );
  }

  void movePlayer(bool up) {
    if (!isGameStarted || isPlayerDead || isGameOver) return;

    isPlayerMoving = true;
    if (up && playerY > JRGameConstants.minPlayerY) {
      playerY -= JRGameConstants.playerSpeed;
    } else if (!up && playerY < JRGameConstants.maxPlayerY) {
      playerY += JRGameConstants.playerSpeed;
    }
    _notifyStateChanged();

    Timer(Duration(milliseconds: JRGameConstants.moveStopDelayMs), () {
      isPlayerMoving = false;
      _notifyStateChanged();
    });

    // Check if player reached the top
    if (playerY <= JRGameConstants.topReachY) {
      gameOver(true);
    }
  }

  void jump() {
    if (!isGameStarted || isPlayerDead || isGameOver || isPlayerJumping) return;

    isPlayerJumping = true;
    _notifyStateChanged();
  }

  void updateJumpOffset(double offset) {
    playerJumpOffset = offset;
    _notifyStateChanged();
  }

  void onJumpComplete() {
    isPlayerJumping = false;
    _notifyStateChanged();
  }

  void updateRopeRotation(double rotation) {
    ropeRotation = rotation;
    _notifyStateChanged();
  }

  void playerDeath() {
    HapticFeedback.heavyImpact();
    isPlayerDead = true;
    _notifyStateChanged();
    onPlayerDeath?.call();

    Timer(Duration(seconds: JRGameConstants.deathDelaySeconds), () {
      gameOver(false);
    });
  }

  void gameOver(bool won) {
    isGameOver = true;
    isWinner = won;
    _notifyStateChanged();

    gameTimer?.cancel();
    legAnimationTimer?.cancel();

    if (won) {
      onGameWon?.call();
      HapticFeedback.lightImpact();
    }
  }

  void resetGame() {
    isGameStarted = false;
    isGameOver = false;
    isWinner = false;
    isPlayerDead = false;
    isPlayerJumping = false;
    isPlayerMoving = false;
    playerY = JRGameConstants.playerStartY;
    playerJumpOffset = 0.0;
    gameTimeLeft = JRGameConstants.gameTimeLimit;
    showLeftLeg = true;
    _notifyStateChanged();

    gameTimer?.cancel();
    legAnimationTimer?.cancel();
  }

  // Check rope collision - very precise detection
  bool isPlayerHittingRope(double screenWidth) {
    // If player is jumping OR has any upward offset, they're safe
    if (isPlayerJumping ||
        playerJumpOffset < JRGameConstants.jumpSafetyOffset) {
      return false; // Player is jumping - no collision
    }

    double ropeCurrentX =
        screenWidth / 2 + sin(ropeRotation) * JRGameConstants.ropeSwingRadius;
    double playerCenterX = screenWidth / 2;
    double playerCurrentY = playerY + playerJumpOffset;

    // Very precise collision - only when rope actually overlaps with player ON GROUND
    bool playerInRopeArea =
        (playerCurrentY > JRGameConstants.ropeTopStart &&
            playerCurrentY <
                JRGameConstants.ropeTopStart + JRGameConstants.ropeHeight);
    bool ropeHitsPlayer =
        (ropeCurrentX > playerCenterX - JRGameConstants.ropeCollisionBuffer &&
            ropeCurrentX < playerCenterX + JRGameConstants.ropeCollisionBuffer);

    return playerInRopeArea && ropeHitsPlayer;
  }

  void _notifyStateChanged() {
    onStateChanged?.call();
  }

  void dispose() {
    gameTimer?.cancel();
    legAnimationTimer?.cancel();
  }
}
