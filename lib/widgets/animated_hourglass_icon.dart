import 'package:flutter/material.dart';

class AnimatedHourglassIcon extends StatelessWidget {
  const AnimatedHourglassIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 50),
      tween: Tween<double>(begin: 0, end: 10),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.rotate(
          angle: value * 6.28319,
          child: const Icon(
            Icons.hourglass_empty,
            color: Color(0xFF13293D),
            size: 100,
          ),
        );
      },
    );
  }
}