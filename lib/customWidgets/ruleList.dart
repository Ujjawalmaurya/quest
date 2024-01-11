import 'package:flutter/material.dart';

class RuleList extends StatelessWidget {
  const RuleList({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyTxtStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey.shade700);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text.rich(
            const TextSpan(
              children: [
                TextSpan(
                  text: '1. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Screenshots and Recordings are'),
                TextSpan(
                  text: ' NOT ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'allowed.'),
              ],
            ),
            style: bodyTxtStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text.rich(
            const TextSpan(
              children: [
                TextSpan(
                  text: '2. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Minimising the app or Switching app will'),
                TextSpan(
                  text: ' AUTO SUBMIT ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Quiz with'),
                TextSpan(
                  text: ' existing ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'answers',
                ),
              ],
            ),
            style: bodyTxtStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text.rich(
            const TextSpan(
              children: [
                TextSpan(
                  text: '3. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Answers '),
                TextSpan(
                  text: 'CAN ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'be changed before submission only.'),
              ],
            ),
            style: bodyTxtStyle,
          ),
        ),
      ],
    );
  }
}
