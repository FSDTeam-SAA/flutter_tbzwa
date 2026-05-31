import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_scaffold.dart';
import '../controller/buy_plan_controller.dart';
import 'self_learning_system_screen.dart';
import 'immersion_plans_screen.dart';

class BuyPlanScreen extends StatelessWidget {
  const BuyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BuyPlanController());

    return AppScaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF0F172A),
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          "Buy Plan",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            /// Plan Option 1: Self Learning System
            Obx(() {
              final isSelected = controller.selectedPlan.value == 1;
              return _buildPlanCard(
                number: 1,
                title: "Self Learning System",
                subtitle: null,
                isSelected: isSelected,
                onTap: () {
                  controller.selectPlan(1);
                  Get.to(() => const SelfLearningSystemScreen());
                },
              );
            }),
            const SizedBox(height: 16),

            /// Plan Option 2: Live Learning System
            Obx(() {
              final isSelected = controller.selectedPlan.value == 2;
              return _buildPlanCard(
                number: 2,
                title: "Live Learning System",
                subtitle: "(Immersion++ Plans)",
                isSelected: isSelected,
                onTap: () {
                  controller.selectPlan(2);
                  Get.to(() => const ImmersionPlansScreen());
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Builds a selectable plan card with a number badge on the left
  Widget _buildPlanCard({
    required int number,
    required String title,
    String? subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF5F4FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF5151EF)
                : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            /// Number badge
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFEEEDFF)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF5151EF)
                      : const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: Text(
                "$number",
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF5151EF)
                      : const Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 16),

            /// Title and optional subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF1E1B4B)
                          : const Color(0xFF1F2937),
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF5151EF)
                            : const Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
