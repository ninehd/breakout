import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../brick_breaker.dart';
import '../config.dart';

class GameApp extends StatelessWidget {
  const GameApp({super.key});

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
                child: GameWidget.controlled(
                  gameFactory: BrickBreaker.new,
                  overlayBuilderMap: {
                    PlayState.welcome.name: (context, game) => Center(
                      child: Text(
                        'TAP TO PLAY',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    PlayState.gameOver.name: (context, game) {
                      final brickBreaker = game as BrickBreaker;
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'G A M E   O V E R',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 20),
                            ValueListenableBuilder<int>(
                              valueListenable: brickBreaker.score,
                              builder: (_, value, __) => Text(
                                'Score: $value',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    PlayState.won.name: (context, game) => Center(
                      child: Text(
                        'Y O U   W O N ! ! !',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
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
