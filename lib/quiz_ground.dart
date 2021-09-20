import 'package:audiofileplayer/audiofileplayer.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'items.dart';
import 'score_screen.dart';

class QuizGround extends StatefulWidget {
  final String name;
  const QuizGround(this.name, {Key? key}) : super(key: key);

  @override
  _QuizGroundState createState() => _QuizGroundState();
}

class _QuizGroundState extends State<QuizGround> {
  late Items items;
  PageController pageController = PageController();
//  AudioPlayer audioPlayer = AudioPlayer();
  late String sound;
  int score = 0;
  @override
  void initState() {
    items = Items();
    items.initialize();
    super.initState();
  }

  play(String path) async {
    Audio.load(path)
      ..play()
      ..dispose();
//    int result = await audioPlayer.play(path, isLocal: true);
  }

  toNext() {
    //this line play sound
    play(sound);
    //this 4 second for delay 4 second
    Future.delayed(Duration(seconds: 4)).then((value) {
      if (pageController.page == 27) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    ScoreScreen(name: widget.name, score: score)),
            (route) => false);
      }
      pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                toNext();
              },
              child: Text("Skip"),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: items.items.length,
            itemBuilder: (context, index) {
              sound = items.items[index].sound;

              return EachPage(
                  onAccept: () {
                    score++;
                    toNext();
                    print(score);
                  },
                  onLeave: () {
                    toNext();
                    print(score);
                  },
                  items: items,
                  index: index);
            }));
  }
}

class EachPage extends StatefulWidget {
  const EachPage({
    Key? key,
    required this.items,
    required this.index,
    required this.onAccept,
    required this.onLeave,
  }) : super(key: key);
  final int index;
  final Items items;
  final VoidCallback onAccept;
  final VoidCallback onLeave;

  @override
  State<EachPage> createState() => _EachPageState();
}

class _EachPageState extends State<EachPage> {
  bool isAnswered = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: " ${widget.index + 1} /"),
            TextSpan(
                text: "${widget.items.items.length}",
                style: const TextStyle(fontSize: 18)),
          ], style: const TextStyle(fontSize: 26, color: Color(0xFF3a3b6b))),
        ),
        Expanded(
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Draggable<Item>(
                data: widget.items.items[widget.index],
                feedback: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    widget.items.items[widget.index].image,
                    fit: BoxFit.fill,
                  ),
                ),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    widget.items.items[widget.index].image,
                    fit: BoxFit.fill,
                  ),
                ),
                childWhenDragging: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    widget.items.items[widget.index].image,
                    fit: BoxFit.fill,
                    color: Colors.grey.withOpacity(0.2),
                    colorBlendMode: BlendMode.saturation,
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.items.items[widget.index].options
                    .map((word) => Option(
                        word: word,
                        onAccept: () {
                          if (isAnswered) return;
                          widget.onAccept();
                          setState(() => isAnswered = true);
                        },
                        onLeave: () {
                          if (isAnswered) return;
                          widget.onLeave();
                          setState(() => isAnswered = true);
                        }))
                    .toList(),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Option extends StatefulWidget {
  const Option({
    Key? key,
    required this.word,
    required this.onAccept,
    required this.onLeave,
  }) : super(key: key);
  final String word;
  final VoidCallback onAccept;
  final VoidCallback onLeave;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  Color color = Color(0xFFcaa7ac);
  @override
  Widget build(BuildContext context) {
    return DragTarget<Item>(
      onWillAccept: (item) {
        return item!.word == widget.word;
      },
      onAccept: (item) {
        setState(() => color = Color(0xFF3b954a));
        widget.onAccept();
        //          toNext(sound);
      },
      onLeave: (item) {
        setState(() => color = Color(0xFFb74330));
        widget.onLeave();
        //        toNext(sound);
      },
      builder: (context, candidate, rejects) {
        return Container(
          alignment: Alignment(0, 0),
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Text(widget.word,
              style: const TextStyle(fontSize: 22, color: Color(0xFF1d1640))),
        );
      },
    );
  }
}
