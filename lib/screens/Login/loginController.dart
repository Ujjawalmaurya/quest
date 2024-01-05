import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quest/src/utils/getStorage.dart';

class LoginController extends GetxController {
  TextEditingController usernameCtr = TextEditingController(
      // text: 'Student02',
      );
  TextEditingController passCtr = TextEditingController(
      // text: '123456789000',
      );

  String correctUsername = 'CSE00';
  String correctPass = '123456';
  //
  final loginFormKey = GlobalKey<FormState>();

  void initiateLogin() {
    if (usernameCtr.text == correctUsername && passCtr.text == correctPass) {
      writeData(StorageKeys.username, usernameCtr.text);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Wrong Credentials',
        'Username and Password are incorrect',
        barBlur: 5,
        overlayBlur: 10,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pinkAccent,
        borderRadius: 8,
        animationDuration: const Duration(milliseconds: 1100),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

//
} // END
