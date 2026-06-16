import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

enum VideoState { initial, recording, review }

class VideoRecordingController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  
  var isInitialized = false.obs;
  var videoState = VideoState.initial.obs;
  var recordedVideoPath = "".obs;
  var clipName = "".obs;

  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: true,
      );
      
      await cameraController.initialize();
      isInitialized.value = true;
    } catch (e) {
      Get.snackbar("Error", "Failed to initialize camera: $e");
    }
  }

  Future<void> switchCamera() async {
     final lensDirection = cameraController.description.lensDirection;
     CameraDescription newDescription;
     if (lensDirection == CameraLensDirection.front) {
       newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
     } else {
       newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
     }

     await cameraController.dispose();
     cameraController = CameraController(newDescription, ResolutionPreset.high);
     await cameraController.initialize();
     isInitialized.refresh();
  }

  Future<void> startRecording() async {
    if (!cameraController.value.isInitialized) return;
    if (cameraController.value.isRecordingVideo) return;

    try {
      await cameraController.startVideoRecording();
      videoState.value = VideoState.recording;
    } catch (e) {
      Get.snackbar("Error", "Failed to start recording: $e");
    }
  }

  Future<void> stopRecording() async {
    if (!cameraController.value.isRecordingVideo) return;

    try {
      final XFile file = await cameraController.stopVideoRecording();
      recordedVideoPath.value = file.path;
      videoState.value = VideoState.review;
    } catch (e) {
      Get.snackbar("Error", "Failed to stop recording: $e");
    }
  }

  void resetRecording() {
    videoState.value = VideoState.initial;
    recordedVideoPath.value = "";
    clipName.value = "";
  }
}
