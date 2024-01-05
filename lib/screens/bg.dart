import 'dart:async';
import 'package:flutter/material.dart';

class AnimatingBg extends StatefulWidget {
  @override
  _AnimatingBgState createState() => _AnimatingBgState();
}

class _AnimatingBgState extends State<AnimatingBg> with TickerProviderStateMixin {
  List<Color> colorList = [
    Color.fromARGB(255, 159, 163, 241),
    Color.fromARGB(255, 216, 177, 255),
    Color.fromARGB(255, 189, 223, 255),
    Color.fromARGB(255, 176, 173, 255),
    Color.fromARGB(255, 230, 179, 255),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = Color.fromARGB(255, 146, 199, 255);
  Color topColor = Color.fromARGB(255, 198, 142, 255);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(microseconds: 0),
      () => setState(() => bottomColor = const Color(0xff33267C)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () => setState(
        () {
          index = index + 1;
          bottomColor = colorList[index % colorList.length];
          topColor = colorList[(index + 1) % colorList.length];
        },
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
    );
  }
}
