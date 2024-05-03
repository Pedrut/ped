import 'package:flutter/material.dart';
import 'game_page.dart';

class HangmanGame extends StatelessWidget {
  const HangmanGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman Game',
      home: GamePage(),
    );
  }
}
