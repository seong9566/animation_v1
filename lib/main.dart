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

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(16),
  ),
  borderSide: BorderSide(color: Color(0xFFDEE3F2), width: 1),
);
