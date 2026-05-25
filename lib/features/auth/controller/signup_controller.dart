import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Form Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Interactive States
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isAgreedToTerms = false.obs;
  final isLoading = false.obs;
  final referredByName = "".obs;

  @override
  void onInit() {
    super.onInit();
    referralCodeController.addListener(() {
      final code = referralCodeController.text.trim();
      if (code == "BZ-284910") {
        referredByName.value = "Jean Dupont";
      } else {
        referredByName.value = "";
      }
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralCodeController.dispose();
    super.onClose();
  }

  // Toggles
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();
  void toggleTermsAgreement() => isAgreedToTerms.toggle();

  // Signup action
  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (!isAgreedToTerms.value) {
      Get.snackbar(
        "Terms & Conditions",
        "You must agree to the Terms and Conditions to continue.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // Simulate Signup process
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.snackbar(
      "Success",
      "Account created successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[600],
      colorText: Colors.white,
    );
  }
}
