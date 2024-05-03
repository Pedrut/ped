import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final Map<String, Color> letterState;
  final Function(String) onPressed;
  final Function(String) onLetterTapped;

  const Keyboard({
    Key? key,
    required this.letterState,
    required this.onPressed,
    required this.onLetterTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstRow = "qwertyuiop".split('');
    final secondRow = "asdfghjkl".split('');
    final thirdRow = "zxcvbnm".split('');

    Widget buildKey(String letter) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(28, 40),
            backgroundColor: letterState[letter],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            foregroundColor: Colors.white,
          ),
          onPressed: letterState[letter] == const Color.fromARGB(255, 247, 147, 208) ? () {
            onPressed(letter);
            onLetterTapped(letter);
          } : null,
          child: Text(
            letter.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget buildRow(List<String> letters) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letters.map((letter) => buildKey(letter)).toList(),
      );
    }

    return Column(
      children: [
        buildRow(firstRow),
        buildRow(secondRow),
        buildRow(thirdRow),
      ],
    );
  }
}
