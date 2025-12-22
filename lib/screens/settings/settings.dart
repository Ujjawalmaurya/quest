import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/settings/settingsController.dart';

class SettingsScreen extends GetView<SettingsController> {
  static const String path = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          _buildSectionHeader("Appearance"),
          Obx(() => SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text("Dark Mode"),
                subtitle: const Text("Switch between light and dark themes"),
                value: controller.isDarkMode.value,
                onChanged: controller.toggleDarkMode,
              )),
          const ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("Accent Color"),
            subtitle: Text("Personalize the app interface"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 12,
              children: controller.availableColors.map((color) {
                return Obx(() => GestureDetector(
                      onTap: () => controller.updateAccentColor(color),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.accentColor.value == color
                                ? context.theme.colorScheme.onSurface
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: controller.accentColor.value == color
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : null,
                      ),
                    ));
              }).toList(),
            ),
          ),
          const Divider(),
          _buildSectionHeader("Quiz Settings"),
          Obx(() => SwitchListTile(
                secondary: const Icon(Icons.vibration),
                title: const Text("Haptic Feedback"),
                subtitle: const Text("Vibrate on interactions"),
                value: controller.hapticFeedback.value,
                onChanged: controller.toggleHaptic,
              )),
          Obx(() => SwitchListTile(
                secondary: const Icon(Icons.timer),
                title: const Text("Show Quiz Timer"),
                subtitle: const Text("Display the remaining time during tests"),
                value: controller.showTimer.value,
                onChanged: controller.toggleTimer,
              )),
          const Divider(),
          _buildSectionHeader("About"),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("App Version"),
            trailing: Text("1.0.0"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Get.textTheme.titleMedium!.copyWith(
          color: Get.theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
