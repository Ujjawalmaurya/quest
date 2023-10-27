import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/test_provider/test.dart';

class TestController extends GetxController {
  //
  // FirebaseDatabase database = FirebaseDatabase.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    // Firebase.initializeApp();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO:
    super.onReady();
  }

  @override
  void onClose() {
    // TODO:
    super.onClose();
  }

  int currentIndex = 0;

  // MCQ? mcqOptions = MCQ.notselected;
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
  ];

  void next() {
    print("$currentIndex ${testMetaData.length}");
    if ((currentIndex + 1) < testMetaData.length) {
      currentIndex++;
      updateMCQSelection(MCQ.notselected);
    } else {
      // TODO: Last question
      // alertSnackBar("Limit reached", "Reached to last question");
      // Get.off(() => const ShowResult());
      Get.toNamed("/showResult");
    }
    update();
  }

  void mark() {
    testMetaData[currentIndex]['isMarked'] = !testMetaData[currentIndex]['isMarked'];
    next();
    update();
  }

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

  updateMCQSelection(MCQ value) {
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
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: testMetaData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: GetBuilder<TestController>(
                      init: TestController(),
                      initState: (_) {},
                      builder: (_) {
                        return CircleAvatar(
                          radius: 3,
                          backgroundColor: _.testMetaData[i]["isMarked"]
                              ? Colors.redAccent
                              : _.testMetaData[i]["submittedAns"] != ''
                                  ? Colors.green
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
      ),
    );
    // return Get.dialog(AlertDialog(title: const Text("Questions summary"), content: Text("ASDasd")
    //
    // ));
  }
  //
} //END
