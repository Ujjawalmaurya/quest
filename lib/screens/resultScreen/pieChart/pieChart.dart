import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resultController.dart';
import 'data.dart';

class PieChartWidget extends StatelessWidget {
  // final List sectors;
  ResultController res = Get.find<ResultController>();

  PieChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: PieChart(
        PieChartData(
          // pieTouchData: PieTouchData(
          //   touchCallback: (FlTouchEvent event, pieTouchResponse) {
          //     res.handleTouch(event, pieTouchResponse);
          //   },
          // ),
          sections: _chartSections(),
          centerSpaceRadius: 50.0,
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections() {
    const double _radius = 65.0;
    final List<PieChartSectionData> list = [
      PieChartSectionData(
        color: Colors.grey,
        value: res.notAnswered.toDouble(),
        radius: _radius,
        title: 'Not Answered',
      ),
      PieChartSectionData(
        color: Colors.greenAccent,
        value: res.correct.toDouble(),
        radius: _radius,
        title: 'Correct',
      ),
      PieChartSectionData(
        color: Colors.redAccent,
        value: (res.incorrect - res.notAnswered).toDouble(),
        radius: _radius,
        title: 'Incorrect',
      ),
    ];
    // for (var sector in sectors) {
    //   const double radius = 50.0;
    //   final data = PieChartSectionData(
    //     color: sector.color,
    //     value: sector.value,
    //     radius: 50.0,
    //     title: '',
    //   );
    //   list.add(data);
    // }
    return list;
  }
}
