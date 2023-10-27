import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/Login/loginController.dart';
// import 'package:quest/Login/loginController.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

  // LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(
              //   height: 155.0,
              //   child: Image.asset(
              //     "assets/images/login_logo.png",
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Text("Login", style: Theme.of(context).textTheme.displayLarge),
              ),

              TextFormField(
                validator: ((value) {
                  if (value!.trim() == '') {
                    return "Username or Email is required";
                  } else {
                    return null;
                  }
                }),
                initialValue: "user_7120",
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                validator: ((value) {
                  if (value!.trim() == '') {
                    return "Password is required";
                  } else {
                    return null;
                  }
                }),
                initialValue: "123456789000",
                obscureText: true,
                decoration: const InputDecoration(
                  // helperText: "Password ",
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
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
                        Get.offAllNamed('/home');
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
    );
  }
}
