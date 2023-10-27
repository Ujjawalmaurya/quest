import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:quest/screens/Login/login.dart';
import 'package:quest/binding/getPages.dart';
import 'package:quest/src/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: GetPages.pages,
      initialRoute: '/login',
      title: 'QUESTion',
      themeMode: ThemeMode.light,
      theme: QuestAppTheme.lightTheme,
      darkTheme: QuestAppTheme.darkTheme,
    );
  }
}
