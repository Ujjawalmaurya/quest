import 'package:get/get.dart';
import 'package:quest/screens/Home/home.dart';
import 'package:quest/screens/Login/login.dart';
import 'package:quest/screens/resultScreen/resultScreen.dart';
import 'package:quest/test_provider/test.dart';
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
      page: () => const TestScreen(),
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
    // GetPage(
    //   name: '/',
    //   page: () => const (),
    // ),
  ];
}