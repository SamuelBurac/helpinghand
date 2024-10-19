import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.inkDrop(
                  color: const Color.fromARGB(255, 255, 123, 21),
                  size: 150,
                ),
      ),
    );
  }
}