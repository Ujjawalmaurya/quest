import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/customWidgets/colorMEans.dart';

import 'package:quest/screens/resultScreen/resultController.dart';
import 'package:quest/screens/test_provider/testController.dart';

class ShowResult extends GetView<ResultController> {
  static const String path = '/showResult';
  const ShowResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance Report"),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSummaryCard(context),
                    const SizedBox(height: 20),
                    _buildTimeAnalysisGraph(context),
                    const SizedBox(height: 20),
                    _buildQuestionGrid(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Overall Score",
              style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, "Correct", controller.correct.toString(), Colors.green),
                _buildStatItem(context, "Incorrect", controller.incorrect.toString(), Colors.red),
                _buildStatItem(context, "Skipped", controller.notAnswered.toString(), Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Total Time: ${_formatDuration(controller.performanceReport['total_time'] ?? 0)}",
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: context.textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildTimeAnalysisGraph(BuildContext context) {
    final report = controller.performanceReport['details'] as List;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Time per Question (seconds)", style: context.textTheme.titleMedium),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (report.map((e) => e['time'] as int).reduce((a, b) => a > b ? a : b) + 5).toDouble(),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: context.theme.colorScheme.surface,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          "${report[groupIndex]['time']}s\n${report[groupIndex]['status']}",
                          TextStyle(color: context.theme.colorScheme.onSurface),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text("Q${value.toInt() + 1}"),
                      ),
                    ),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: report.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    final status = data['status'];
                    Color color = Colors.grey;
                    if (status == 'Correct') color = Colors.green;
                    if (status == 'Incorrect') color = Colors.red;

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (data['time'] as int).toDouble(),
                          color: color,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionGrid(BuildContext context) {
    return Column(
      children: [
        Text("Question Analysis", style: context.textTheme.titleLarge),
        const SizedBox(height: 10),
        const ColorMeanings(),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: Get.find<TestController>().testMetaData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            final meta = Get.find<TestController>().testMetaData[i];
            Color color = Colors.grey;
            if (meta["submittedAns"] == meta["correctAns"])
              color = Colors.green;
            else if (meta["submittedAns"] != '') color = Colors.red;

            return Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Q${i + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    meta["submittedAns"] == meta["correctAns"]
                        ? "+1"
                        : meta["submittedAns"] == ''
                            ? "0"
                            : "-1",
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}
