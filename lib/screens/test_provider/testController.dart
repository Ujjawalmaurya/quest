import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:quest/screens/resultScreen/resultScreen.dart';
import 'package:quest/screens/test_provider/testScreen.dart';
import 'package:quest/src/constants/colors.dart';

class TestController extends FullLifeCycleController with FullLifeCycleMixin {
  @override
  void onInit() {
    // WidgetsBinding.instance.addObserver(TestScreen());
    super.onInit();
  }

  // Mandatory
  @override
  void onDetached() {
    print('HomeController - onDetached called');
  }

  // Mandatory
  @override
  void onInactive() {
    print('HomeController - onInative called');
  }

  // Mandatory
  @override
  void onPaused() {
    print('HomeController - onPaused called');
  }

  // Mandatory
  @override
  void onResumed() {
    print('HomeController - onResumed called');
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        log("App Resumed");
        instantSubmit();
        break;
      case AppLifecycleState.inactive:
        log("App InActive");
        break;
      case AppLifecycleState.paused:
        log("App Paused");
        break;
      case AppLifecycleState.detached:
        log("App Detached");
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        log("Lifecycle Hidden");
        break;
    }
  }

  @override
  void onReady() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    super.onReady();
  }

  @override
  void onClose() async {
    // WidgetsBinding.instance.removeObserver(TestScreen());
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
    super.onClose();
  }

  int currentIndex = 0;
  RxBool everResumed = false.obs;
  MCQ? selectedOption = MCQ.notselected;

  //
  List<Map> testMetaData = [
    {
      "questNo": "1",
      "question":
          "When a gas jar full of air is placed upside down on a gas jar full of bromine vapours, the red-brown vapours of bromine from the lower jar go upward into the jar containing air. In this experiment:",
      "option_A": "Air is heavier than bromine",
      "option_B": "Both air and bromine have the same density",
      "option_C": "Bromine is heavier than air",
      "option_D": "Bromine cannot be heavier than air because it is going upwards against gravity",
      "correctAns": "C",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "2",
      "question": " When water at 0°C freezes to form ice at the same temperature of 0°C, then it:",
      "option_A": "Absorbs some heat",
      "option_B": "Releases some heat",
      "option_C": "Neither absorbs nor releases heat",
      "option_D": "Absorbs exactly 3.34 x 105J/kg of heat",
      "correctAns": "B",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "3",
      "question": "The evaporation of a liquid can best be carried out in a:",
      "option_A": "Flask",
      "option_B": "China dish",
      "option_C": "Test tube",
      "option_D": "Beaker",
      "correctAns": "B",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "4",
      "question": "Zig-zag movement of the solute particle in a solution is known as",
      "option_A": "Linear motion",
      "option_B": "Circular motion",
      "option_C": "Brownian motion",
      "option_D": "Curved motion",
      "correctAns": "C",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "5",
      "question": "CO2 can be easily liquified and even solidified because",
      "option_A": "It has weak forces of attraction",
      "option_B": "It has comparatively more force of attraction than other gases",
      "option_C": "It has more intermolecular space",
      "option_D": "It is present in atmosphere.",
      "correctAns": "B",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "6",
      "question":
          " A few substances are arranged in the increasing order of ‘forces of attraction’ between their particles. Which one of the following represents a correct arrangement?",
      "option_A": "Water, air, wind",
      "option_B": "Air, sugar, oil",
      "option_C": "Oxygen, water, sugar",
      "option_D": "Salt, juice, air",
      "correctAns": "C",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "7",
      "question": "Which of the following phenomena always results in the cooling effect?",
      "option_A": "Condensation",
      "option_B": "Evaporation",
      "option_C": "Sublimation",
      "option_D": "None of these",
      "correctAns": "B",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "8",
      "question": "The colour of vapours formed on sublimation of iodine solid is:",
      "option_A": "Purple (violet)",
      "option_B": "Colourless",
      "option_C": "Yellow",
      "option_D": "Orange",
      "correctAns": "A",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "9",
      "question": "A gas which obeys the gas laws is known as:",
      "option_A": "An ideal gas",
      "option_B": "A heavier gas",
      "option_C": "A lighter gas",
      "option_D": "A real gas",
      "correctAns": "A",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "10",
      "question": "What’s the term used to describe the phase change as a liquid becomes a solid?",
      "option_A": "Evaporation",
      "option_B": "Condensation",
      "option_C": "Freezing",
      "option_D": "None of the above",
      "correctAns": "C",
      "submittedAns": "",
      "isMarked": false
    },
  ];

  void next() {
    log(everResumed.toString());
    print("$currentIndex ${testMetaData.length}");
    if ((currentIndex + 1) < testMetaData.length) {
      currentIndex++;
      updateMCQSelection(MCQ.notselected);
    } else {
      // TODO: Last question
      // alertSnackBar("Limit reached", "Reached to last question");
      // Get.off(() => const ShowResult());
      Get.toNamed(ShowResult.path);
    }
    update();
  }

  void mark() {
    testMetaData[currentIndex]['isMarked'] = !testMetaData[currentIndex]['isMarked'];
    next();
    update();
  }

  void instantSubmit() {
    for (var i = currentIndex; i < testMetaData.length; i++) {
      next();
    }
  } //

  // void readData() {
  //   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('posts/123/starCount');
  //   starCountRef.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //     print(data);
  //   });
  // }a

  // void writeData() async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
  //   await ref.set({
  //     "name": "John",
  //     "age": 18,
  //     "address": {"line1": "100 Mountain View"}
  //   });
  // }

  // final ref = FirebaseDatabase.instance.ref();
  //
  // final snapshot = await ref.child('users/$userId').get();
  // if (snapshot.exists) {
  //   print(snapshot.value);
  // } else {
  //   print('No data available.');
  // }

  void updateMCQSelection(MCQ value) {
    selectedOption = value;
    log(value.toString());
    log(value.runtimeType.toString());
    switch (value) {
      case MCQ.a:
        testMetaData[currentIndex]["submittedAns"] = 'A';
        break;
      case MCQ.b:
        testMetaData[currentIndex]["submittedAns"] = 'B';
        break;
      case MCQ.c:
        testMetaData[currentIndex]["submittedAns"] = 'C';
        break;
      case MCQ.d:
        testMetaData[currentIndex]["submittedAns"] = 'D';
        break;
      default:
        testMetaData[currentIndex]["submittedAns"] = '';
    }
    update();
  }

  summarySheet() {
    Get.bottomSheet(
      // enableDrag: false,
      enterBottomSheetDuration: const Duration(milliseconds: 250),
      exitBottomSheetDuration: const Duration(milliseconds: 150),
      Container(
        // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Questions summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: testMetaData.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                        child: GetBuilder<TestController>(
                          init: TestController(),
                          initState: (_) {},
                          builder: (_) {
                            return CircleAvatar(
                              radius: 3.5,
                              backgroundColor: _.testMetaData[i]["isMarked"]
                                  ? Colors.redAccent
                                  : _.testMetaData[i]["submittedAns"] != ''
                                      ? QuizColors.green
                                      : Colors.grey,
                              child: Text(
                                "${i + 1}",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(radius: 12, backgroundColor: QuizColors.grey),
                    ),
                    Text("NOT Attemped")
                  ]),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(radius: 12, backgroundColor: QuizColors.green),
                    ),
                    Text("Attempted")
                  ]),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(radius: 12, backgroundColor: QuizColors.red),
                    ),
                    Text("Marked for review")
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Get.dialog(AlertDialog(title: const Text("Questions summary"), content: Text("ASDasd")
    //
    // ));
  }
  //
} //END
