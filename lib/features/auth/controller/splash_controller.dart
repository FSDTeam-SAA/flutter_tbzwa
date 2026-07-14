import 'package:flutx_core/core/debug_print.dart';
import 'package:flutter_tbzwa/features/auth/screens/login_screen.dart';
import 'package:flutter_tbzwa/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../core/api/api_client.dart';
import '../../../core/services/auth_storage_service.dart';
import '../../../core/services/secure_store_services.dart';
import '../../navigation/instructor_nav_menu.dart' as instructor_navigation;
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
    DPrint.log("SplashController: Starting splash flow...");

    const videoPath = 'assets/images/splash_video.mp4';
    DPrint.log("SplashController: Initializing video: $videoPath");

    // Initialize video controller
    videoController = VideoPlayerController.asset(videoPath);

    try {
      await videoController!.initialize();
      DPrint.log("SplashController: Video initialized successfully.");

      isVideoInitialized.value = true;

      await videoController!.play();
      DPrint.log("SplashController: Video playing...");

      // Wait for video to complete (with a fallback if duration is zero)
      final duration = videoController!.value.duration;
      if (duration.inMilliseconds > 0) {
        DPrint.log("SplashController: Waiting for video duration: $duration");
        await Future.delayed(duration);
      } else {
        DPrint.log(
          "SplashController: Video duration is zero, waiting for 5 seconds fallback.",
        );
        await Future.delayed(const Duration(seconds: 0));
      }
    } catch (e) {
      DPrint.error("SplashController: Error initializing video: $e");
      // If video fails, maybe show something else or just proceed
      await Future.delayed(const Duration(seconds: 3));
    }

    DPrint.log("SplashController: Navigating to next screen...");
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    final secureStore = SecureStoreServices();
    final savedEmail = await secureStore.retrieveData("email");
    final savedPassword = await secureStore.retrieveData("password");

    final hasStoredSession = await _authStorageService.isAuthenticated();

    if (hasStoredSession) {
      await ApiClient().restoreSession();
    }

    final isAuth = await _authStorageService.isAuthenticated();

    if (isAuth) {
      final role = await _authStorageService.getRole();
      if (role == 'instructor') {
        Get.offAll(() => const instructor_navigation.NavigationMenu());
      } else {
        Get.offAll(() => const NavigationMenu());
      }
    } else if (savedEmail != null && savedPassword != null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.off(() => const OnboardingScreen());
    }
  }
}
