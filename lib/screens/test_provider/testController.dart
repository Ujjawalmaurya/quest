import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:get/get.dart';
import 'package:kiosk_mode/kiosk_mode.dart';
import 'package:safe_device/safe_device.dart';
import 'package:quest/screens/resultScreen/resultScreen.dart';
import 'package:quest/screens/test_provider/testScreen.dart';
import 'package:quest/screens/settings/settingsController.dart';
import 'package:quest/src/constants/colors.dart';

class TestController extends FullLifeCycleController with FullLifeCycleMixin {
  late Timer _timer;
  RxInt remainingTime = 600.obs; // 10 minutes in seconds
  RxInt violationCount = 0.obs;
  RxList<Map<String, dynamic>> auditLog = <Map<String, dynamic>>[].obs;

  DateTime? _questionStartTime;
  StreamSubscription<KioskMode>? _kioskSubscription;
  bool _isRestartingKiosk = false;
  DateTime? _lastViolationTime;

  @override
  void onInit() {
    startTimer();
    _questionStartTime = DateTime.now();
    _startIntegrityChecks();
    super.onInit();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer.cancel();
        instantSubmit();
      }
    });
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

  // Mandatory
  @override
  void onHidden() {
    print('HomeController - onHidden called');
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        log("App Resumed");
        break;
      case AppLifecycleState.inactive:
        log("App InActive");
        _recordViolation("App minimized or notification shade opened");
        break;
      case AppLifecycleState.paused:
        log("App Paused");
        _recordViolation("App backgrounded");
        break;
      case AppLifecycleState.detached:
        log("App Detached");
        break;
      case AppLifecycleState.hidden:
        log("Lifecycle Hidden");
        _recordViolation("App hidden");
        break;
    }
  }

  void _recordViolation(String reason) {
    // Debounce similar violations within 1 second
    if (_lastViolationTime != null && DateTime.now().difference(_lastViolationTime!).inMilliseconds < 1000) {
      return;
    }

    _lastViolationTime = DateTime.now();
    violationCount.value++;
    final timestamp = DateTime.now();
    auditLog.add({
      "time": "${timestamp.hour}:${timestamp.minute}:${timestamp.second}",
      "reason": reason,
    });
    log("Violation: $reason. Count: ${violationCount.value}");

    // Auto-submit on excessive violations (e.g., 3)
    if (violationCount.value >= 3) {
      _recordViolation("Auto-submitting due to repeated integrity violations");
      instantSubmit();
    }
  }

  void _startIntegrityChecks() {
    // Periodic check for mock locations or developer options
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (onCloseCalled) {
        timer.cancel();
        return;
      }
      bool isMockLocation = await SafeDevice.isMockLocation;
      if (isMockLocation) {
        _recordViolation("Mock location detected");
      }

      bool isDevelopmentMode = await SafeDevice.isDevelopmentModeEnable;
      if (isDevelopmentMode) {
        _recordViolation("Developer mode enabled");
      }
    });
  }

  bool onCloseCalled = false;

  @override
  void onReady() async {
    await FlutterWindowManagerPlus.addFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    _startLockdown();
    super.onReady();
  }

  @override
  void onClose() async {
    onCloseCalled = true;
    _timer.cancel();
    _stopLockdown();
    await FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    super.onClose();
  }

  Future<void> _startLockdown() async {
    if (_isRestartingKiosk) return;
    _isRestartingKiosk = true;
    try {
      final res = await startKioskMode();
      log("Kiosk mode started: $res");

      // Initialize listener only if not already listening
      if (_kioskSubscription == null) {
        _kioskSubscription = watchKioskMode().listen((state) {
          if (state == KioskMode.disabled && !onCloseCalled) {
            _handleKioskDisabled();
          }
        });
      }
    } catch (e) {
      log("Error starting kiosk mode: $e");
    } finally {
      _isRestartingKiosk = false;
    }
  }

  void _handleKioskDisabled() async {
    // Cooldown check for kiosk violations
    if (_lastViolationTime != null && DateTime.now().difference(_lastViolationTime!).inSeconds < 2) {
      return;
    }

    _recordViolation("Kiosk mode deactivated manually");
    await _startLockdown(); // Attempt to restart
  }

  Future<void> _stopLockdown() async {
    try {
      await _kioskSubscription?.cancel();
      await stopKioskMode();
      log("Kiosk mode stopped");
    } catch (e) {
      log("Error stopping kiosk mode: $e");
    }
  }

  int currentIndex = 0;
  MCQ? selectedOption = MCQ.notselected;

  //
  List<Map> testMetaData = [
    {
      "questNo": "1",
      "question":
          "When a gas jar full of air is placed upside down on a gas jar full of bromine vapours, the red-brown vapours of bromine from the lower jar go upward into the jar containing air. In this experiment:",
      "A": "Air is heavier than bromine",
      "B": "Both air and bromine have the same density",
      "C": "Bromine is heavier than air",
      "D": "Bromine cannot be heavier than air because it is going upwards against gravity",
      "correctAns": "C",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "2",
      "question": " When water at 0°C freezes to form ice at the same temperature of 0°C, then it:",
      "A": "Absorbs some heat",
      "B": "Releases some heat",
      "C": "Neither absorbs nor releases heat",
      "D": "Absorbs exactly 3.34 x 105J/kg of heat",
      "correctAns": "B",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "3",
      "question": "The evaporation of a liquid can best be carried out in a:",
      "A": "Flask",
      "B": "China dish",
      "C": "Test tube",
      "D": "Beaker",
      "correctAns": "B",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "4",
      "question": "Zig-zag movement of the solute particle in a solution is known as",
      "A": "Linear motion",
      "B": "Circular motion",
      "C": "Brownian motion",
      "D": "Curved motion",
      "correctAns": "C",
      "submittedAns": "",
      'isMarked': false
    },
    {
      "questNo": "5",
      "question": "CO2 can be easily liquified and even solidified because",
      "A": "It has weak forces of attraction",
      "B": "It has comparatively more force of attraction than other gases",
      "C": "It has more intermolecular space",
      "D": "It is present in atmosphere.",
      "correctAns": "B",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "6",
      "question":
          " A few substances are arranged in the increasing order of ‘forces of attraction’ between their particles. Which one of the following represents a correct arrangement?",
      "A": "Water, air, wind",
      "B": "Air, sugar, oil",
      "C": "Oxygen, water, sugar",
      "D": "Salt, juice, air",
      "correctAns": "C",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "7",
      "question": "Which of the following phenomena always results in the cooling effect?",
      "A": "Condensation",
      "B": "Evaporation",
      "C": "Sublimation",
      "D": "None of these",
      "correctAns": "B",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "8",
      "question": "The colour of vapours formed on sublimation of iodine solid is:",
      "A": "Purple (violet)",
      "B": "Colourless",
      "C": "Yellow",
      "D": "Orange",
      "correctAns": "A",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "9",
      "question": "A gas which obeys the gas laws is known as:",
      "A": "An ideal gas",
      "B": "A heavier gas",
      "C": "A lighter gas",
      "D": "A real gas",
      "correctAns": "A",
      "submittedAns": "",
      "isMarked": false
    },
    {
      "questNo": "10",
      "question": "What’s the term used to describe the phase change as a liquid becomes a solid?",
      "A": "Evaporation",
      "B": "Condensation",
      "C": "Freezing",
      "D": "None of the above",
      "correctAns": "C",
      "submittedAns": "",
      "isMarked": false
    },
  ];

  void next() {
    _recordTime();
    _triggerHaptic();
    if ((currentIndex + 1) < testMetaData.length) {
      currentIndex++;
      _updateSelectedOptionFromSubmitted();
      _questionStartTime = DateTime.now();
    } else {
      Get.toNamed(ShowResult.path);
    }
    update();
  }

  void _updateSelectedOptionFromSubmitted() {
    String submitted = testMetaData[currentIndex]["submittedAns"];
    switch (submitted) {
      case 'A':
        selectedOption = MCQ.a;
        break;
      case 'B':
        selectedOption = MCQ.b;
        break;
      case 'C':
        selectedOption = MCQ.c;
        break;
      case 'D':
        selectedOption = MCQ.d;
        break;
      default:
        selectedOption = MCQ.notselected;
    }
  }

  void jumpToQuestion(int index) {
    _recordTime();
    _triggerHaptic();
    currentIndex = index;
    _updateSelectedOptionFromSubmitted();
    _questionStartTime = DateTime.now();
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    update();
  }

  void _recordTime() {
    if (_questionStartTime != null) {
      final duration = DateTime.now().difference(_questionStartTime!).inSeconds;
      testMetaData[currentIndex]['timeTaken'] = (testMetaData[currentIndex]['timeTaken'] ?? 0) + duration;
    }
  }

  void mark() {
    testMetaData[currentIndex]['isMarked'] = !testMetaData[currentIndex]['isMarked'];
    next();
    update();
  }

  void instantSubmit() {
    for (var i = currentIndex; i < testMetaData.length; i++) {
      _recordTime(); // Record time for each before finishing
      if (i < testMetaData.length - 1) {
        currentIndex = i + 1;
        _questionStartTime = DateTime.now();
      }
    }
    Get.toNamed(ShowResult.path);
    update();
  }

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

  void _triggerHaptic() {
    if (Get.find<SettingsController>().hapticFeedback.value) {
      HapticFeedback.lightImpact();
    }
  }

  Map<String, dynamic> generatePerformanceReport() {
    int totalTime = 0;
    List<Map<String, dynamic>> details = [];

    for (var i = 0; i < testMetaData.length; i++) {
      var data = testMetaData[i];
      totalTime += (data['timeTaken'] as int?) ?? 0;
      details.add({
        "question": i + 1,
        "time": (data['timeTaken'] as int?) ?? 0,
        "status": data['submittedAns'] == data['correctAns']
            ? "Correct"
            : data['submittedAns'] == ''
                ? "Unanswered"
                : "Incorrect",
      });
    }

    return {
      "total_time": totalTime,
      "details": details,
    };
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
                          builder: (_) {
                            return InkWell(
                              onTap: () => _.jumpToQuestion(i),
                              child: CircleAvatar(
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
