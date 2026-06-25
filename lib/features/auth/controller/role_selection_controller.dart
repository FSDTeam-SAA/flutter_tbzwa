import 'package:get/get.dart';

import '../../navigation/instructor_nav_menu.dart';
import '../../payment/screens/buy_plan_screen.dart';
import '../../instructor/screens/instructor_dashboard_screen.dart';

class RoleSelectionController extends GetxController {
  // Selection State
  // Defaults to "learner" as seen highlighted in the user's design image
  final selectedRole = "learner".obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void proceed() {
    if (selectedRole.value == 'instructor') {
      Get.to(() => const NavigationMenu());
    } else {
      Get.to(() => const BuyPlanScreen());
    }
  }
}
