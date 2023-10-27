import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/resultScreen/pieChart/pieChart.dart';
import 'package:quest/screens/resultScreen/resultController.dart';
import 'package:quest/test_provider/testController.dart';

class ShowResult extends StatefulWidget {
  const ShowResult({super.key});

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: GetBuilder<ResultController>(
                init: ResultController(),
                initState: (_) {},
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attempt: ${_.attempt}",
                        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Correct: ${_.correct}",
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Incorrect: ${_.incorrect}",
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            child: GetBuilder<TestController>(
              init: TestController(),
              initState: (_) {},
              builder: (_) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: _.testMetaData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                _.testMetaData[i]["submittedAns"] == _.testMetaData[i]["correctAns"]
                                    ? Colors.greenAccent
                                    : _.testMetaData[i]["submittedAns"] != ''
                                        ? Colors.redAccent
                                        : Colors.grey,
                            radius: 20,
                            child: Text(
                              _.testMetaData[i]["submittedAns"] == _.testMetaData[i]["correctAns"]
                                  ? "+1"
                                  : "-1",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            "Question\nno: ${i + 1}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11.5,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          PieChartWidget(),
        ],
      ),
    );
  }
}