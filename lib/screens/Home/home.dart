import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:quest/screens/Home/homeController.dart';
// import 'package:quest/Test/test.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ongoing Quizes"),
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
                ))
              : Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(4.0),
                    //   child: Text(
                    //     "Ongoing Quizes",
                    //     style: Theme.of(context).textTheme.headlineSmall,
                    //   ),
                    // ),
                    const Listview(),
                  ],
                ),
        )
        // ListView.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) => ListTile(
        //     // tileColor: Colors.tealAccent,
        //     title: Text("Test series ${index + 1}"),
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
        shrinkWrap: true,
        padding: EdgeInsets.all(_w / 30),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: 5,
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
                // onTap: () => Get.toNamed("/testScreen"),
                onTap: () => Get.toNamed("/rules"),
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
