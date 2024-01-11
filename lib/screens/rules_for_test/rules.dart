import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/customWidgets/ruleList.dart';
import 'package:quest/screens/rules_for_test/rulesController.dart';

class Rules extends GetWidget<RulesController> {
  static const String path = '/rules';
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    // final headerTxtStyle = Theme.of(context).textTheme.displayMedium;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: Get.width,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/rules.jpg',
                  // height: 320,
                  // width: 320,
                ),
                const Divider(),
                // Center(
                //   child: Text(
                //     'Rules',
                //     style: headerTxtStyle,
                //   ),
                // ),
                // Column(
                //   children: [

                const RuleList(),
                // ],
                // ),
                Divider(),
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
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Quiz will'),
                                  TextSpan(
                                    text: ' Automatically start ',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: 'after'),
                                ],
                              ),
                              // style: Get.theme.textTheme.titleSmall,
                            ),
                            // const Text("Test will start automatically after"),
                            Text(
                              "${controller.duration.value}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const Text("Seconds"),
                            Text(
                              "Please Wait!!",
                              style: Get.theme.textTheme.titleMedium,
                            )
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
