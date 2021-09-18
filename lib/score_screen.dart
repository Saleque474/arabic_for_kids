import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final String name;
  final int score;

  const ScoreScreen({required this.name, required this.score, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(flex:2),
          Text("$name"),
           Spacer(flex:1),
           Text("$score"),
           Spacer(flex:2),
          Container(),
        ],
      ),
    );
  }
}
