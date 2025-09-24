import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'overlay_screen.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: Center(
            child: FittedBox(
              child: SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: GameWidget(
                  game: game,
                  overlayBuilderMap: {
                    PlayState.welcome.name: (context, game) =>
                    const OverlayScreen(
                      title: 'TAP TO PLAY',
                      subtitle: 'Press enter or tap',
                    ),
                    PlayState.gameOver.name: (context, game) {
                      final brickBreaker = game as BrickBreaker;
                      return OverlayScreen(
                        title: 'G A M E   O V E R',
                        subtitle: 'Tap to Play Again',
                        score: brickBreaker.score.value,
                      );
                    },
                    PlayState.won.name: (context, game) {
                      final brickBreaker = game as BrickBreaker;
                      return OverlayScreen(
                        title: 'Y O U   W O N ! ! !',
                        subtitle: 'Tap to Play Again',
                        score: brickBreaker.score.value,
                      );
                    },
                    'hud': (context, game) {
                      final brickBreaker = game as BrickBreaker;
                      return Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, right: 12),
                          child: ValueListenableBuilder<int>(
                            valueListenable: brickBreaker.score,
                            builder: (_, value, __) => Text(
                              '$value',
                              // reuse your app theme; bump size if needed
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      );
                    },
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
