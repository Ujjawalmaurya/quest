import 'dart:developer';

import 'package:get_storage/get_storage.dart';

final GetStorage box = GetStorage();

void writeData(String key, dynamic value) {
  box.write(key, value).onError(
        (error, stackTrace) => log(
          "$error while writing$key, $stackTrace",
          name: "getStorage.dart writing error log",
        ),
      );
}

readData(String key) => box.read(key);

class StorageKeys {
  static const String username = 'user';
  // static const String  = '';
}//

// FOR FUTURE USE ONLY
// class StorageKeys {
//   static const String isLogin = 'isLogin';
//   static const String isDarkMode = 'isDarkMode';
//   static const String isTest = 'isTest';
//   static const String isTestCompleted = 'isTestCompleted';
//   static const String isTestCompletedDate = 'isTestCompletedDate';
//   static const String isTestCompletedTime = 'isTestCompletedTime';
//   static const String isTestCompletedScore = 'isTestCompletedScore';
//   static const String isTestCompletedPercentage = 'isTestCompletedPercentage';
//   static const String isTestCompletedCorrect = 'isTestCompletedCorrect';
//   static const String isTestCompletedWrong = 'isTestCompletedWrong';
//   static const String isTestCompletedUnattempted = 'isTestCompletedUnattempted';
//   static const String isTestCompletedTotal = 'isTestCompletedTotal';
//   static const String isTestCompletedTotalTime = 'isTestCompletedTotalTime';
//   static const String isTestCompletedTotalScore = 'isTestCompletedTotalScore';
//   static const String isTestCompletedTotalPercentage = 'isTestCompletedTotalPercentage';
//   static const String isTestCompletedTotalCorrect = 'isTestCompletedTotalCorrect';
//   static const String isTestCompletedTotalWrong = 'isTestCompletedTotalWrong';
//   static const String isTestCompletedTotalUnattempted = 'isTestCompletedTotalUnattempted';
//   static const String isTestCompletedTotalTotal = 'isTestCompletedTotalTotal';
//   static const String isTestCompletedTotalTotalTime = 'isTestCompletedTotalTotalTime';
//   static const String isTestCompletedTotalTotalScore = 'isTestCompletedTotalTotalScore';
//   static const String isTestCompletedTotalTotalPercentage = 'isTestCompletedTotalTotalPercentage';
//   static const String isTestCompletedTotalTotalCorrect = 'isTestCompletedTotalTotalCorrect';
//   static const String isTestCompletedTotalTotalWrong = 'isTestCompletedTotalTotalWrong';
//   static const String isTestCompletedTotalTotalUnattempted = 'isTestCompletedTotalTotalUnattempted';
//   static const String isTestCompletedTotalTotalTotal = 'isTestCompletedTotalTotalTotal';
//   static const String isTestCompletedTotalTotalTotalTime = 'isTestCompletedTotalTotalTotalTime';
//   static const String isTestCompletedTotalTotalTotalScore = 'isTestCompletedTotalTotalTotalScore';
//   static const String isTestCompletedTotalTotalTotalPercentage = 'isTestCompletedTotalTotalTotalPercentage';
// }
