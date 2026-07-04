import 'package:flutter/material.dart';
import 'package:flutter_tbzwa/features/auth/screens/login_screen.dart';
import 'package:flutter_tbzwa/features/auth/screens/role_selection_screen.dart';
import 'package:flutter_tbzwa/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/services/auth_storage_service.dart';
import '../../../core/services/secure_store_services.dart';
import '../../onboarding/screens/onboarding_screen.dart';

class SplashController extends GetxController {
  final AuthStorageService _authStorageService = AuthStorageService();

  VideoPlayerController? videoController;
  final RxBool isVideoInitialized = false.obs;
  final RxBool showSecondSplash = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startSplashFlow();
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }

  Future<void> _startSplashFlow() async {
    print("SplashController: Starting splash flow...");

    const videoPath = 'assets/images/splash_video.mp4';
    print("SplashController: Initializing video: $videoPath");

    // Initialize video controller
    videoController = VideoPlayerController.asset(videoPath);

    try {
      await videoController!.initialize();
      print("SplashController: Video initialized successfully.");
      
      isVideoInitialized.value = true;
      
      await videoController!.play();
      print("SplashController: Video playing...");

      // Wait for video to complete (with a fallback if duration is zero)
      final duration = videoController!.value.duration;
      if (duration.inMilliseconds > 0) {
        print("SplashController: Waiting for video duration: $duration");
        await Future.delayed(duration);
      } else {
        print("SplashController: Video duration is zero, waiting for 5 seconds fallback.");
        await Future.delayed(const Duration(seconds: 0));
      }
    } catch (e) {

      print("SplashController: Error initializing video: $e");
      // If video fails, maybe show something else or just proceed
      await Future.delayed(const Duration(seconds: 3));
    }

    print("SplashController: Navigating to next screen...");
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final secureStore = SecureStoreServices();
    final savedEmail = await secureStore.retrieveData("email");
    final savedPassword = await secureStore.retrieveData("password");

    final isAuth = await _authStorageService.isAuthenticated();

    if (isAuth) {
      Get.to(() => LoginScreen());
      //Get.offAll(() => RoleSelectionScreen());
      // For now, if no navigation target is defined for Auth, go to Onboarding or similar
      // Or uncomment the above if NavigationMenu exists.
    
    } else if (savedEmail != null && savedPassword != null) {
      Get.offAll(
        () => LoginScreen(
          // email: savedEmail,
          // password: savedPassword,
        ),
      );
      Get.off(() => const OnboardingScreen());
    } else {
      Get.off(() => const OnboardingScreen());
    }
  }
}

