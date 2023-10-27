import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication.dart';
import 'loginController.dart';
// import 'package:quest/Login/loginController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
            const SizedBox(height: 45.0),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email Address",
                labelStyle: TextStyle(
                  // fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  // fontFamily: "Montserrat",
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
                  child:
                      ElevatedButton(onPressed: () => Get.offAllNamed('/home'), child: const Text("Login"))),
            ),
            // FutureBuilder(
            //   future: Authentication.initializeFirebase(context: context),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       log(snapshot.toString());
            //       return const Text('Error initializing Firebase');
            //     } else if (snapshot.connectionState == ConnectionState.done) {
            //       return const Text("Googlesigninbutton");
            //     }
            //     return const CircularProgressIndicator();
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
