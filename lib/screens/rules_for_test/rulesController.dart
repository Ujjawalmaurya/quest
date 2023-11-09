import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';

class RulesController extends GetxController {
  //

  @override
  void onInit() async {
    // Future.delayed(
    //   const Duration(seconds: 5),
    //   () {
    //     Get.offNamed("/testScreen");
    //   },
    // );
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
  RxInt duration = 2.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        duration == 0
            ? {
                timer.cancel(),
                Get.offNamed("/testScreen"),
              }
            : {
                duration--,
                log('* $duration', name: "==Timer=="),
              };
      },
    );
  }
} //class RulesController
