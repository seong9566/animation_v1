import 'package:animation_v1/screens/onboding/onboding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationV1());
}

class AnimationV1 extends StatelessWidget {
  const AnimationV1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBodingScreen(),
    );
  }
}
