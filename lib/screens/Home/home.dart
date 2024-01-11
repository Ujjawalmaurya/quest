import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:quest/customWidgets/ruleList.dart';
import 'package:quest/screens/Home/homeController.dart';
import 'package:quest/screens/Login/login.dart';
import 'package:quest/screens/rules_for_test/rules.dart';
import 'package:quest/src/utils/getStorage.dart';
// import 'package:quest/Test/test.dart';

class HomePage extends GetWidget<HomeController> {
  static const String path = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Get.theme.textTheme.headlineSmall;

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Ongoing Quizes"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Get.theme.colorScheme.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Text(
                        "${Storage.read(StorageKeys.username)[0]}",
                        style: Get.theme.textTheme.displayMedium!.copyWith(color: Colors.white),
                      ),
                      // Placeholder image or load the user's profile picture here
                      // backgroundImage: ,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${Storage.read(StorageKeys.username)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  'Settings',
                ),
                onTap: () {
                  //
                  // Navigate to the settings screen or perform other actions
                },
              ),
              ListTile(
                leading: const Icon(Icons.rule),
                title: const Text("Rules"),
                onTap: () => Get.defaultDialog(
                  title: "Rules",
                  content: const RuleList(),
                  titlePadding: const EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.verified_user_outlined),
                title: Text("Terms of use"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () => Get.defaultDialog(
                  title: "Logout",
                  titlePadding: EdgeInsets.only(top: 50, bottom: 5),
                  content: const Text("Are you sure you want to logout?"),
                  contentPadding: EdgeInsets.only(top: 55, bottom: 30),
                  actions: [
                    TextButton.icon(
                      label: const Text("Cancel"),
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Storage.clear();
                        Get.offAllNamed(LoginPage.path);
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                    ),
                  ],
                ),
              ),
              // const EndDrawerButton(style: ButtonStyle()),
            ],
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Getting Quiz info...",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    ],
                  ),
                )
              :
              // : Column(
              //     mainAxisSize: MainAxisSize.max,
              //     children: [
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: Text(

              //     "Ongoing Quizes",
              //     style: Theme.of(context).textTheme.headlineSmall,
              //   ),
              // ),
              const Listview(),
          //   ],
          // ),
        )
        // ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) => ListTile(
        //     // tileColor: Colors.tealAccent,
        //     title: Text(
        //"Test series ${index + 1}"),
        //     onTap: () => Get.toNamed("/testScreen"),
        //   ),
        // ),
        );
  }
}

class Listview extends StatelessWidget {
  const Listview({super.key});

  @override
  Widget build(BuildContext context) {
    double _w = Get.width;
    return AnimationLimiter(
      child: ListView.builder(
        // shrinkWrap: true,
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              duration: const Duration(milliseconds: 2500),
              curve: Curves.fastLinearToSlowEaseIn,
              horizontalOffset: -300,
              verticalOffset: -850,
              child: InkWell(
                onTap: () => Get.toNamed(Rules.path),
                child: Container(
                  margin: EdgeInsets.only(bottom: _w / 20),
                  height: _w / 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(child: Text("Test series ${index + 1}")),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
