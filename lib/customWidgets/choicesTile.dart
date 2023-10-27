import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quest/customWidgets/snackbar.dart';

class ChoiceTile extends StatelessWidget {
  final String choice;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChanged;

  const ChoiceTile(
      {super.key,
      required this.choice,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      activeColor: Colors.deepPurple,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(choice),
    );
  }
}
