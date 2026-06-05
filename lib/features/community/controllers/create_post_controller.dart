import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/services/smart_media_service.dart';

class CreatePostController extends GetxController {
  final SmartMediaService _mediaService = Get.find<SmartMediaService>();
  final TextEditingController textController = TextEditingController();
  
  final Rxn<File> selectedImage = Rxn<File>();
  final Rxn<File> selectedVideo = Rxn<File>();
  final Rxn<File> selectedAudio = Rxn<File>();

  Future<void> pickImage() async {
    final image = await _mediaService.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      selectedVideo.value = null;
      selectedAudio.value = null;
    }
  }

  Future<void> pickVideo() async {
    final video = await _mediaService.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      selectedVideo.value = File(video.path);
      selectedImage.value = null;
      selectedAudio.value = null;
    }
  }

  Future<void> pickAudio() async {
    final files = await _mediaService.pickFiles(type: FileType.audio);
    if (files != null && files.isNotEmpty) {
      selectedAudio.value = files.first;
      selectedImage.value = null;
      selectedVideo.value = null;
    }
  }

  void removeMedia() {
    selectedImage.value = null;
    selectedVideo.value = null;
    selectedAudio.value = null;
  }

  void submitPost() {
    // Logic to submit the post
    if (textController.text.isNotEmpty || selectedImage.value != null || selectedVideo.value != null || selectedAudio.value != null) {
      Get.back();
      Get.snackbar("Success", "Post created successfully!", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, duration: Duration(seconds: 1));
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
