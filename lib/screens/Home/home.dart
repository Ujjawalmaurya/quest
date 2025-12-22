import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:quest/customWidgets/ruleList.dart';
import 'package:quest/screens/Home/homeController.dart';
import 'package:quest/screens/Login/login.dart';
import 'package:quest/screens/settings/settings.dart';
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
        appBar: AppBar(
          title: const Text("Ongoing Quizzes"),
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
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text(
                        "${Storage.read(StorageKeys.username)[0]}".toUpperCase(),
                        style: Get.theme.textTheme.headlineMedium!.copyWith(
                          color: Get.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${Storage.read(StorageKeys.username)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.home, 'Home', () => Get.back()),
              _buildDrawerItem(Icons.settings, 'Settings', () {
                Get.back();
                Get.toNamed(SettingsScreen.path);
              }),
              _buildDrawerItem(Icons.rule, 'Rules', () {
                Get.defaultDialog(
                  title: "Rules",
                  content: const RuleList(),
                  titlePadding: const EdgeInsets.all(16),
                );
              }),
              _buildDrawerItem(Icons.logout, 'Logout', () {
                Get.defaultDialog(
                  title: "Logout",
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
                    ElevatedButton(
                      onPressed: () {
                        Storage.clear();
                        Get.offAllNamed(LoginPage.path);
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const Listview(),
        ));
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Get.theme.colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
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
        padding: EdgeInsets.all(_w / 25),
        physics: const BouncingScrollPhysics(),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            delay: const Duration(milliseconds: 100),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Card(
                  margin: EdgeInsets.only(bottom: _w / 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Get.toNamed(Rules.path),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.quiz_outlined,
                              color: context.theme.colorScheme.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Test Series ${index + 1}",
                                  style: context.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Chemistry Practice • 10 Questions",
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: context.theme.colorScheme.primary.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
