import 'package:get/get.dart';
import 'package:flutter_tbzwa/navbar_menu.dart' as subscriber_navigation;
import 'package:flutter_tbzwa/navigation_menu.dart' as learner_navigation;

import '../../../core/services/auth_storage_service.dart';
import '../../instructor/controllers/instructor_home_controller.dart';
import '../../navigation/instructor_nav_menu.dart' as instructor_navigation;
import '../../payment/screens/buy_plan_screen.dart';

class RoleSelectionController extends GetxController {
  final AuthStorageService _authStorageService = AuthStorageService();

  // Selection State
  // Defaults to "learner" as seen highlighted in the user's design image
  final selectedRole = "learner".obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  Future<void> proceed() async {
    _resetRoleNavigationState();
    await _authStorageService.storeActiveRole(selectedRole.value);
    if (selectedRole.value == 'instructor') {
      Get.to(() => const instructor_navigation.NavigationMenu());
    } else {
      Get.to(() => const BuyPlanScreen());
    }
  }

  void _resetRoleNavigationState() {
    if (Get.isRegistered<learner_navigation.NavigationController>()) {
      Get.delete<learner_navigation.NavigationController>(force: true);
    }
    if (Get.isRegistered<instructor_navigation.NavigationController>()) {
      Get.delete<instructor_navigation.NavigationController>(force: true);
    }
    if (Get.isRegistered<subscriber_navigation.NavbarController>()) {
      Get.delete<subscriber_navigation.NavbarController>(force: true);
    }
    if (Get.isRegistered<InstructorHomeController>()) {
      Get.delete<InstructorHomeController>(force: true);
    }
  }
}
