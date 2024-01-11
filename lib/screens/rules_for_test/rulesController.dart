import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:quest/screens/test_provider/testScreen.dart';

class RulesController extends GetxController {
  //

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO:
    startTimer();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO:
    // timer.cancel();

    super.onClose();
  }

  late Timer? _timer;
  RxInt duration = 3.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        duration == 0
            ? {
                timer.cancel(),
                Get.offNamed(TestScreen.path),
              }
            : {
                duration--,
                log('* $duration', name: "==Timer=="),
              };
      },
    );
  }
} //class RulesController
