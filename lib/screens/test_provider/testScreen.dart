import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/test_provider/testController.dart';
import 'package:quest/customWidgets/choicesTile.dart';

enum MCQ { a, b, c, d, notselected }
// enum SingingCharacter { lafayette, jefferson }

class TestScreen extends GetWidget<TestController> {
  TestScreen({super.key});

  // TestController testCtr = Get.find<TestController>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    controller.instantSubmit();
    controller.everResumed.value = true;
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.textsms_sharp),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.dangerous),
          // ),
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  elevation: 8,
                  margin: const EdgeInsets.all(6),
                  child: GetBuilder<TestController>(
                    init: TestController(),
                    initState: (_) {},
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              "Question ${_.testMetaData[_.currentIndex]["questNo"]}:",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              "${_.testMetaData[_.currentIndex]["question"]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                // letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GetBuilder<TestController>(
                  init: TestController(),
                  initState: (_) {},
                  builder: (_) {
                    return Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Column(
                          children: [
                            ChoiceTile(
                              value: MCQ.a,
                              groupValue: _.selectedOption,
                              onChanged: (_val) => _.updateMCQSelection(_val),
                              choice: "(A) ${_.testMetaData[_.currentIndex]['option_A']}",
                            ),
                            ChoiceTile(
                              value: MCQ.b,
                              groupValue: _.selectedOption,
                              onChanged: (_val) => _.updateMCQSelection(_val),
                              choice: "(B) ${_.testMetaData[_.currentIndex]['option_B']}",
                            ),
                            ChoiceTile(
                              value: MCQ.c,
                              groupValue: _.selectedOption,
                              onChanged: (_val) => _.updateMCQSelection(_val),
                              choice: "(C) ${_.testMetaData[_.currentIndex]['option_C']}",
                            ),
                            ChoiceTile(
                              value: MCQ.d,
                              groupValue: _.selectedOption,
                              onChanged: (_val) => _.updateMCQSelection(_val),
                              choice: "(D) ${_.testMetaData[_.currentIndex]['option_D']}",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          GetBuilder<TestController>(
            init: TestController(),
            initState: (_) {},
            builder: (_) => Padding(
              padding: const EdgeInsets.all(28.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () => _.mark(),
                    child: const Text(
                      "Mark for review",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.greenAccent),
                    ),
                    onPressed: () => _.next(),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
