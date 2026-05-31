import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/auth_storage_service.dart';
import '../../../core/services/secure_store_services.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthStorageService _authStorageService = AuthStorageService();

  bool showSecondSplash = false;

  @override
  void initState() {
    super.initState();
    _startSplashFlow();
  }

  Future<void> _startSplashFlow() async {
    // First splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Show second splash image
    setState(() {
      showSecondSplash = true;
    });

    // Second splash for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Navigate after splash
    final secureStore = SecureStoreServices();
    final savedEmail = await secureStore.retrieveData("email");
    final savedPassword = await secureStore.retrieveData("password");

    final isAuth = await _authStorageService.isAuthenticated();

    if (isAuth) {
      // Get.offAll(() => NavigationMenu());
    } else if (savedEmail != null && savedPassword != null) {
      // Get.offAll(
      //   () => LoginScreen(
      //     email: savedEmail,
      //     password: savedPassword,
      //   ),
      // );
    } else {
      Get.off(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          showSecondSplash
              ? 'assets/images/Splash_new.png'
              : 'assets/images/Splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
