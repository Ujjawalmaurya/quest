import 'package:flutter/material.dart';
import 'package:quest/src/constants/colors.dart';

class ColorMeanings extends StatelessWidget {
  const ColorMeanings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(radius: 12, backgroundColor: QuizColors.grey),
            ),
            Text("Marked for review or NOT Attemped")
          ]),
          Row(children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(radius: 12, backgroundColor: QuizColors.green),
            ),
            Text("Correct")
          ]),
          Row(children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(radius: 12, backgroundColor: QuizColors.red),
            ),
            Text("Incorrect")
          ]),
          Row(children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(radius: 12, backgroundColor: QuizColors.blue),
            ),
            Text("Attempted")
          ]),
        ],
      ),
    );
  }
}
