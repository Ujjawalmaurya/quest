import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quest/screens/Login/loginController.dart';

// import 'package:quest/Login/loginController.dart';

class LoginPage extends GetWidget<LoginController> {
  static const String path = '/login';
  LoginPage({super.key});

  // LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Login")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Form(
            key: controller.loginFormKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80.0),
                  // Image.asset('assets/stu-login.svg'),
                  SvgPicture.asset('assets/stu-login.svg', height: 230, width: 230),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Student Login", style: Theme.of(context).textTheme.displaySmall),
                  ),

                  TextFormField(
                    validator: ((value) {
                      if (value!.trim() == '') {
                        return "Username or Email is required";
                      }
                      // if (value != username) {
                      //   return "Incorect username";
                      // }
                      else {
                        return null;
                      }
                    }),
                    controller: controller.usernameCtr,
                    // initialValue: username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Username",
                      // labelStyle: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.grey,
                      // ),
                      //   border: UnderlineInputBorder(
                      //     borderSide: BorderSide(width: 2, color: Colors.green),
                      //   ),
                      //   focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(12)),
                      //     borderSide: BorderSide(width: 2, color: Colors.green),
                      //   ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    validator: ((value) {
                      if (value!.trim() == '') {
                        return "Password is required";
                      }
                      // if (value != pass) {
                      //   return "Incorrect password";
                      // }
                      else {
                        return null;
                      }
                    }),
                    // initialValue: pass,
                    controller: controller.passCtr,
                    obscureText: true,
                    decoration: const InputDecoration(
                      // helperText: "Password ",
                      labelText: "Password",
                      // labelStyle: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   color: Colors.grey,
                      // ),
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.green),
                      // ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: SizedBox(
                      width: 600,
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.loginFormKey.currentState!.validate()) {
                            controller.initiateLogin();
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
