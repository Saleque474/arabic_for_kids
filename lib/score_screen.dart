import 'package:flutter/material.dart';

import 'main.dart';

class ScoreScreen extends StatelessWidget {
  final String name;
  final int score;

  const ScoreScreen({required this.name, required this.score, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFb9d5b7),
      body: Column(
        children: [
          const Spacer(flex: 2),
          Text(name,
              style: const TextStyle(fontSize: 30, color: Color(0xFF8fedcc))),
          const Spacer(flex: 1),
          Text("$score",
              style: const TextStyle(fontSize: 30, color: Color(0xFF8fa0ed))),
          const Spacer(flex: 2),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => LearnArabicByQuiz()),
                    (route) => false);
              },
              child: Text("Return")),
          const Spacer(flex: 2),
          Container(),
        ],
      ),
    );
  }
}
