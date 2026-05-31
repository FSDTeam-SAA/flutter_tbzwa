import 'package:get/get.dart';

import '../../payment/screens/buy_plan_screen.dart';

class RoleSelectionController extends GetxController {
  // Selection State
  // Defaults to "learner" as seen highlighted in the user's design image
  final selectedRole = "learner".obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void proceed() {
    Get.to(() => const BuyPlanScreen());
  }
}
