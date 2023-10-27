import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/test_provider/testController.dart';
import 'package:quest/customWidgets/choicesTile.dart';

enum MCQ { a, b, c, d, notselected }
// enum SingingCharacter { lafayette, jefferson }

class TestScreen extends GetWidget<TestController> {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.textsms_sharp),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dangerous),
          ),
          IconButton(
              onPressed: () => Get.find<TestController>().summarySheet(),
              icon: const Icon(Icons.pie_chart_outline_sharp)),
        ],
        title: GetBuilder<TestController>(
          init: TestController(),
          initState: (_) {},
          builder: (_) {
            return Text("Questions ${_.currentIndex + 1}/${_.testMetaData.length}");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(6),
                  child: GetBuilder<TestController>(
                    init: TestController(),
                    initState: (_) {},
                    builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Question ${_.testMetaData[_.currentIndex]["questNo"]}: \n ${_.testMetaData[_.currentIndex]["question"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            // letterSpacing: 0.5,
                          ),
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
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
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
                            // Radio(
                            //   value: SingingCharacter.jefferson,
                            //   groupValue: _.character,
                            //   onChanged: (val) {
                            //     setState(() {
                            //       _.character = val;
                            //     });
                            //   },
                            // ),
                            // Radio(
                            //   value: SingingCharacter.lafayette,
                            //   groupValue: _.character,
                            //   onChanged: (val) {
                            //     setState(() {
                            //       _.character = val;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            // Expanded(
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 30,
            //       itemBuilder: (context, index) {
            //         return const Card(
            //           color: Colors.blueAccent,
            //           child: Text("data"),
            //         );
            //       }),
            // )
            GetBuilder<TestController>(
              init: TestController(),
              initState: (_) {},
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                        onPressed: () {
                          _.mark();
                        },
                        child: const Text("Mark for review")),
                    ElevatedButton(
                        style:
                            const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
                        onPressed: () => _.next(),
                        child: const Text("Next")),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
