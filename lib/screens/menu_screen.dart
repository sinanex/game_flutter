import 'package:flutter/material.dart';
import '../game/RGLight/rg_light_game.dart';
import '../game/JRGame/jr_game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sprites/background_sprite.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SQUID GAME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD62598),
                  fontFamily: 'Courier',
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 6,
                      color: Colors.black54,
                    ),
                    Shadow(
                      offset: Offset(-1, -1),
                      blurRadius: 2,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Your Challenge',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Courier',
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              _buildGameButton(
                context,
                title: 'RED LIGHT\nGREEN LIGHT',
                subtitle:
                    'Move when green, stop when red!\nReach the finish line to survive.',
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RGLightGame(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              _buildGameButton(
                context,
                title: 'JUMP ROPE\nCHALLENGE',
                subtitle:
                    'Jump over the rope to survive!\nReach the top platform to escape.',
                color: Colors.red,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JRGameScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.9),
              color.withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Courier',
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Courier',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
