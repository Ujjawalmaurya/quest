import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quest/screens/test_provider/testController.dart';
import 'package:quest/src/constants/colors.dart';

class MentorOverridePanel extends StatelessWidget {
  const MentorOverridePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mentor Override Panel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => Text(
                "Total Violations: ${controller.violationCount.value}",
                style: TextStyle(
                  color: controller.violationCount.value > 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const Divider(),
          const Text("Audit Trail", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: Obx(() => controller.auditLog.isEmpty
                ? const Center(child: Text("No violations recorded."))
                : ListView.builder(
                    itemCount: controller.auditLog.length,
                    itemBuilder: (context, index) {
                      final log = controller.auditLog[index];
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.warning_amber, color: Colors.amber),
                        title: Text(log['reason'] ?? "Unknown"),
                        subtitle: Text(log['time'] ?? ""),
                      );
                    },
                  )),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    controller.violationCount.value = 0;
                    controller.auditLog.add({
                      "time": "Override",
                      "reason": "Violations reset by mentor",
                    });
                    Get.snackbar("Success", "Violations reset successfully");
                  },
                  child: const Text("Reset Violations", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: QuizColors.red),
                  onPressed: () {
                    controller.instantSubmit();
                    Get.back();
                  },
                  child: const Text("Force Submit", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  static void show() {
    Get.bottomSheet(const MentorOverridePanel());
  }
}
