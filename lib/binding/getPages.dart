import 'package:get/get.dart';
import 'package:quest/screens/Home/home.dart';
import 'package:quest/screens/Login/login.dart';
import 'package:quest/screens/resultScreen/resultScreen.dart';
import 'package:quest/screens/rules_for_test/rules.dart';
import 'package:quest/screens/test_provider/testScreen.dart';
import 'package:quest/binding/bindings.dart';

Transition primaryTransition = Transition.cupertino;
Transition secondaryTransition = Transition.rightToLeft;

class GetPages {
  static List<GetPage> pages = [
    GetPage(
      // transition: primaryTransition,
      name: LoginPage.path,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: HomePage.path,
      // transition: primaryTransition,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: TestScreen.path,
      // transition: secondaryTransition,
      page: () => TestScreen(),
      binding: TestBinding(),
    ),
    GetPage(
      name: ShowResult.path,
      page: () => const ShowResult(),
      bindings: [
        TestBinding(),
        ResultBinding(),
      ],
    ),
    GetPage(
      name: Rules.path,
      page: () => const Rules(),
      binding: RuleBinding(),
    ),

    // GetPage(
    //   name: '/',
    //   page: () => const (),
    // ),
  ];
}
