import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Use a gradient background
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1F1F1F)
                : const Color(0xFFE0F7FA),
            Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF121212)
                : const Color(0xFFB2EBF2),
          ],
        ),
        // Optional: You can also add an image overlay to the gradient
        image: const DecorationImage(
          image: AssetImage('assets/images/bg_pattern.png'),
          repeat: ImageRepeat.repeat,
          opacity: 0.05, // Subtle background pattern
        ),
      ),
      child: child,
    );
  }
}
