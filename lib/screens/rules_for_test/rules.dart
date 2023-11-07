import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/rules_for_test/rulesController.dart';

class Rules extends GetWidget<RulesController> {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    final headerTxtStyle = Theme.of(context).textTheme.displayLarge;
    final bodyTxtStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Rules',
                    style: headerTxtStyle,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '1 - Screenshots and Recording is NOT allowed.',
                        style: bodyTxtStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '2 - Switching and closing app will SUBMIT Quiz with existing answers',
                        style: bodyTxtStyle,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: Text('3 - Keep an eye on Remaining TIME if it have', style: bodyTxtStyle),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '3 - Answers CAN be changed before submission only.',
                        style: bodyTxtStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Test will start automatically after"),
                            Text(
                              "${controller.duration.value}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Text("Seconds"),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
