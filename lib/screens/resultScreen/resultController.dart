import 'dart:developer';

// import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:quest/screens/test_provider/testController.dart';

class ResultController extends GetxController {
  //
  // int obtainedMarks = 0;
  int incorrect = 0;
  int correct = 0;
  int attempt = 0;
  int notAnswered = 0;
  RxBool isLoading = true.obs;
  //
  // int touchedIndex = -1;

  TestController testController = Get.find<TestController>();
  //

  @override
  void onInit() {
    calculateValues();
    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //
  //

  void calculateValues() {
    // for (int i in testController.testMetaData) {
    //   print(i);
    // }

    testController.testMetaData.forEach((var i) {
      if (i["submittedAns"] != '') {
        attempt++;
      } else {
        notAnswered++;
      }

      if (i["submittedAns"] == i["correctAns"]) {
        correct++;
      } else {
        incorrect++;
      }
    });
  }

  // handleTouch(FlTouchEvent event, pieTouchResponse) {
  //   if (!event.isInterestedForInteractions ||
  //       pieTouchResponse == null ||
  //       pieTouchResponse.touchedSection == null) {
  //     touchedIndex = -1;
  //     return;
  //   }
  //   touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
  //   update();
  // }
} // END
