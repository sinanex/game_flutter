enum GameStatus { notStarted, playing, gameOver, won }

enum LightState { green, red }

class GameState {
  final GameStatus status;
  final LightState lightState;
  final double playerPosition;
  final int remainingTime;
  final bool isPlayerMoving;
  final bool isInGracePeriod;
  final bool showLeftLeg;

  const GameState({
    required this.status,
    required this.lightState,
    required this.playerPosition,
    required this.remainingTime,
    required this.isPlayerMoving,
    required this.isInGracePeriod,
    required this.showLeftLeg,
  });

  // Initial state
  static const GameState initial = GameState(
    status: GameStatus.notStarted,
    lightState: LightState.green,
    playerPosition: 0.0,
    remainingTime: 30,
    isPlayerMoving: false,
    isInGracePeriod: false,
    showLeftLeg: false,
  );

  // Helper getters
  bool get isGameStarted => status != GameStatus.notStarted;
  bool get isGameActive => status == GameStatus.playing;
  bool get isPlayerDead => status == GameStatus.gameOver;
  bool get hasWon => status == GameStatus.won;
  bool get isGreenLight => lightState == LightState.green;
  bool get isRedLight => lightState == LightState.red;
  int get progressPercentage => (playerPosition * 100).toInt();

  // Copy with method for immutable updates
  GameState copyWith({
    GameStatus? status,
    LightState? lightState,
    double? playerPosition,
    int? remainingTime,
    bool? isPlayerMoving,
    bool? isInGracePeriod,
    bool? showLeftLeg,
  }) {
    return GameState(
      status: status ?? this.status,
      lightState: lightState ?? this.lightState,
      playerPosition: playerPosition ?? this.playerPosition,
      remainingTime: remainingTime ?? this.remainingTime,
      isPlayerMoving: isPlayerMoving ?? this.isPlayerMoving,
      isInGracePeriod: isInGracePeriod ?? this.isInGracePeriod,
      showLeftLeg: showLeftLeg ?? this.showLeftLeg,
    );
  }

  @override
  String toString() {
    return 'GameState(status: $status, lightState: $lightState, playerPosition: $playerPosition, remainingTime: $remainingTime)';
  }
}
