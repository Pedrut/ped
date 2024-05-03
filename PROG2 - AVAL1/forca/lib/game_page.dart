import 'package:flutter/material.dart';
import 'dart:math';
import 'datas/data.dart'; 
import 'keyboard.dart'; 

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  int currentHangmanImageIndex = 0;
  late WordHint currentWordHint;
  List<String> correctLetters = [];
  int wrongGuessCount = 0;
  final int maxGuesses = 6;
  static const TextStyle customTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 71, 71, 71),
  );
  List<WordHint> remainingWords = [];
  bool displayHint = false;
  bool gameStarted = false;

  Map<String, Color> letterState = {};

  @override
  void initState() {
    super.initState();
    loadInitialWordList();
    resetGame();
  }

  void loadInitialWordList() {
    remainingWords = List.from(wordList); 
  }

  void startGame() {
    setState(() {
      resetGame();
      gameStarted = true;
    });
  }

  void resetGame() {
    setState(() {
      if (remainingWords.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Todas as palavras foram usadas"),
            content: const Text("O jogo vai recarregar a lista de palavras."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  loadInitialWordList();
                  resetGame();
                },
              )
            ],
          ),
        );
        return;
      }
      int randomIndex = Random().nextInt(remainingWords.length);
      currentWordHint = remainingWords[randomIndex];
      remainingWords.removeAt(randomIndex);
      correctLetters = List<String>.generate(currentWordHint.word.length, (i) => currentWordHint.word[i] == ' ' ? ' ' : '_');
      wrongGuessCount = 0;
      currentHangmanImageIndex = 0;
      letterState = {for (var item in 'abcdefghijklmnopqrstuvwxyz'.split('')) item: const Color.fromARGB(255, 247, 147, 208)};
      displayHint = false;
    });
  }

  void guessLetter(String letter) {
  setState(() {
    if (letterState[letter] == const Color.fromARGB(255, 247, 147, 208)) { 
      bool isLetterFound = false;
      for (int i = 0; i < currentWordHint.word.length; i++) {
        if (currentWordHint.word[i].toLowerCase() == letter) { 
          correctLetters[i] = letter.toUpperCase(); 
          isLetterFound = true;
        }
      }

      letterState[letter] = isLetterFound ? const Color.fromARGB(255, 255, 47, 203) : Colors.red;

      if (!isLetterFound) {
        wrongGuessCount++;
        currentHangmanImageIndex = min(wrongGuessCount, maxGuesses - 1);
      }

      if (!displayHint && wrongGuessCount >= 4) {
        displayHint = true;
      }

      if (wrongGuessCount == maxGuesses || !correctLetters.contains('_')) {
        
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Game Over"),
            content: Text(wrongGuessCount == maxGuesses
                ? "Você perdeu. A palavra era: ${currentWordHint.word}."
                : "Você ganhou!! A palavra era: ${currentWordHint.word}."),
            actions: <Widget>[
              TextButton(
                child: const Text("JOGAR NOVAMENTE"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  resetGame();
                },
              )
            ],
          ),
        );
      }
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 216, 241),
      appBar: AppBar(
        title: const Text("Hangman Game"),
        backgroundColor: const Color.fromARGB(255, 247, 147, 208),
      ),
      body: Center(
        child: gameStarted ? gameLayout() : startGameButton(),
      ),
    );
  }

  Widget startGameButton() {
    return ElevatedButton(
      onPressed: startGame,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 247, 147, 208),
      ),
      child: const Text('Start Game'),
    );
  }

  Widget gameLayout() {
  return Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "lib/assets/hangman-$currentHangmanImageIndex.png",
            width: 200,
          ),
          const SizedBox(height: 20), 
          Wrap(
            spacing: 4, 
            alignment: WrapAlignment.center,
            children: List<Widget>.generate(correctLetters.length, (i) {
              return Container(
                width: 30, 
                height: 50, 
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 247, 147, 208)),
                  borderRadius: BorderRadius.circular(5), 
                ),
                child: Text(
                  correctLetters[i].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24, 
                    color: Colors.black, 
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20), 
          if (displayHint)
            Column(
              children: [
                Text(
                  "Dica: ${currentWordHint.hint}",
                  style: customTextStyle.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
            ),
          RichText(
            text: TextSpan(
              style: customTextStyle, 
              children: <TextSpan>[
                const TextSpan(text: 'Tentativas incorretas: '), 
                TextSpan(
                  text: '$wrongGuessCount/$maxGuesses', 
                  style: const TextStyle(color: Colors.red), 
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), 
          Keyboard(
            letterState: letterState,
            // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
            onPressed: guessLetter, onLetterTapped: (String ) {  },
          ),
        ],
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Text(
          "Pedro Felipe",
          style: TextStyle(
            fontSize: 20,
            color: const Color.fromARGB(255, 37, 37, 37).withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ],
  );
}
}