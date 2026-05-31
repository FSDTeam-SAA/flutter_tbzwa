import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/role_selection_screen.dart';

class LoginController extends GetxController {
  // Form Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Interactive States
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggles
  void togglePasswordVisibility() => isPasswordVisible.toggle();

  // Login action
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    // Simulate login process
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    // Navigate to Choose Your Role selection screen
    Get.offAll(() => const RoleSelectionScreen());
  }
}
