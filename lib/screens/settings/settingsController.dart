import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/src/utils/getStorage.dart';
import 'package:quest/src/utils/theme.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = ((Storage.read(StorageKeys.isDarkMode) as bool?) ?? false).obs;
  Rx<Color> accentColor =
      Color((Storage.read(StorageKeys.accentColor) as int?) ?? Colors.deepPurple.value).obs;
  RxBool hapticFeedback = ((Storage.read(StorageKeys.hapticFeedback) as bool?) ?? true).obs;
  RxBool showTimer = ((Storage.read(StorageKeys.showTimer) as bool?) ?? true).obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Storage.write(StorageKeys.isDarkMode, value);
    Get.changeTheme(QuestAppTheme.getTheme(accentColor.value, value));
  }

  void updateAccentColor(Color color) {
    accentColor.value = color;
    Storage.write(StorageKeys.accentColor, color.value);
    Get.changeTheme(QuestAppTheme.getTheme(color, isDarkMode.value));
  }

  void toggleHaptic(bool value) {
    hapticFeedback.value = value;
    Storage.write(StorageKeys.hapticFeedback, value);
  }

  void toggleTimer(bool value) {
    showTimer.value = value;
    Storage.write(StorageKeys.showTimer, value);
  }

  final List<Color> availableColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
  ];
}
