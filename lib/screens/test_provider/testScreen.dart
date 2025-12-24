import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/bg.dart';
import 'package:quest/screens/test_provider/testController.dart';
import 'package:quest/screens/settings/settingsController.dart';
import 'package:quest/customWidgets/choicesTile.dart';
import 'package:quest/customWidgets/mentor_override_panel.dart';

enum MCQ { a, b, c, d, notselected }
// enum SingingCharacter { lafayette, jefferson }

class TestScreen extends GetWidget<TestController> {
  static const path = '/testScreen';
  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            GetX<SettingsController>(
              builder: (settings) {
                return settings.showTimer.value
                    ? Center(
                        child: Obx(() => GestureDetector(
                              onLongPress: () => MentorOverridePanel.show(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _formatTime(Get.find<TestController>().remainingTime.value),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                            )),
                      )
                    : const SizedBox.shrink();
              },
            ),
            IconButton(
              onPressed: () => Get.find<TestController>().summarySheet(),
              icon: const Icon(Icons.pie_chart_outline_sharp),
            ),
          ],
          title: GetBuilder<TestController>(
            init: TestController(),
            initState: (_) {},
            builder: (_) {
              return const Text(
                // "Questions ${_.currentIndex + 1}/${_.testMetaData.length}",
                "Questions",
                // style: Theme.of(context).textTheme.bodyLarge,
              );
            },
          ),
        ),
        body: Stack(
          children: [
            AnimatingBg(),
            Column(
              children: [
                Expanded(
                  child: GetBuilder<TestController>(
                    builder: (_) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Text(
                                    "Question ${_.testMetaData[_.currentIndex]["questNo"]}",
                                    style: context.textTheme.titleMedium?.copyWith(
                                      color: context.theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "${_.testMetaData[_.currentIndex]["question"]}",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Select Answer",
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.theme.colorScheme.onBackground.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ChoiceTile(
                            value: MCQ.a,
                            groupValue: _.selectedOption,
                            onChanged: (_val) => _.updateMCQSelection(_val),
                            choice: "${_.testMetaData[_.currentIndex]['A']}",
                          ),
                          ChoiceTile(
                            value: MCQ.b,
                            groupValue: _.selectedOption,
                            onChanged: (_val) => _.updateMCQSelection(_val),
                            choice: "${_.testMetaData[_.currentIndex]['B']}",
                          ),
                          ChoiceTile(
                            value: MCQ.c,
                            groupValue: _.selectedOption,
                            onChanged: (_val) => _.updateMCQSelection(_val),
                            choice: "${_.testMetaData[_.currentIndex]['C']}",
                          ),
                          ChoiceTile(
                            value: MCQ.d,
                            groupValue: _.selectedOption,
                            onChanged: (_val) => _.updateMCQSelection(_val),
                            choice: "${_.testMetaData[_.currentIndex]['D']}",
                          ),
                        ],
                      );
                    },
                  ),
                ),
                GetBuilder<TestController>(
                  builder: (_) => Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _.mark(),
                            child: const Text("Mark Review"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _.next(),
                            child: const Text("Next Question"),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
