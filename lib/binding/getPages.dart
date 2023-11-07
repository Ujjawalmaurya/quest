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
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/home',
      // transition: primaryTransition,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/testScreen',
      // transition: secondaryTransition,
      page: () => TestScreen(),
      binding: TestBinding(),
    ),
    GetPage(
      name: '/showResult',
      page: () => const ShowResult(),
      bindings: [
        TestBinding(),
        ResultBinding(),
      ],
    ),
    GetPage(
      name: '/rules',
      page: () => const Rules(),
      binding: RuleBinding(),
    ),

    // GetPage(
    //   name: '/',
    //   page: () => const (),
    // ),
  ];
}
