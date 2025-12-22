import 'package:get/get.dart';
import 'package:quest/screens/Home/homeController.dart';
import 'package:quest/screens/Login/loginController.dart';
import 'package:quest/screens/resultScreen/resultController.dart';
import 'package:quest/screens/rules_for_test/rulesController.dart';
import 'package:quest/screens/test_provider/testController.dart';
import 'package:quest/screens/settings/settingsController.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    HomeController controller = Get.put(HomeController());
  }
  //
}

class TestBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<TestController>(() => TestController());
    TestController controller = Get.put(TestController());
    Get.lazyPut(() => SettingsController());
  }
  //
}

class RuleBinding extends Bindings {
  @override
  void dependencies() {
    RulesController controller = Get.put(RulesController());
  }
}

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController());
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
