import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
    this.score,
  });

  final String title;
  final String subtitle;
  final int? score;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ).animate().slideY(duration: 750.ms, begin: -3, end: 0),

          const SizedBox(height: 16),

          if (score != null) ...[
            Text(
              'Score: $score',
              style: Theme.of(context).textTheme.headlineMedium,
            )
                .animate(delay: 750.ms)
                .fadeIn(duration: 1.seconds),
            const SizedBox(height: 16),
          ],

          Text(subtitle, style: Theme.of(context).textTheme.headlineSmall)
              .animate(delay: 750.ms, onPlay: (controller) => controller.repeat())
              .fadeIn(duration: 1.seconds)
              .then()
              .fadeOut(duration: 1.seconds),
        ],
      ),
    );
  }
}
