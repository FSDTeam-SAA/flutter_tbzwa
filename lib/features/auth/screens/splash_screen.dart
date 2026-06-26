import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Obx(() {
          if (controller.isVideoInitialized.value &&
              controller.videoController != null) {
            return AspectRatio(
              aspectRatio: controller.videoController!.value.aspectRatio,
              child: VideoPlayer(controller.videoController!),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        }),
      ),
    );

  }
}




