import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/services/smart_media_service.dart';
import '../services/community_api_service.dart';

class CreatePostController extends GetxController {
  final SmartMediaService _mediaService = Get.find<SmartMediaService>();
  final CommunityApiService _communityApiService = CommunityApiService();
  final TextEditingController textController = TextEditingController();

  final Rxn<File> selectedImage = Rxn<File>();
  final Rxn<File> selectedVideo = Rxn<File>();
  final Rxn<File> selectedAudio = Rxn<File>();
  final isPosting = false.obs;

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

  Future<void> submitPost() async {
    if (isPosting.value) return;

    final content = textController.text.trim();
    final mediaFile =
        selectedImage.value ?? selectedVideo.value ?? selectedAudio.value;
    if (content.isEmpty && mediaFile == null) return;

    isPosting.value = true;
    try {
      await _communityApiService.createPost(
        content: content,
        mediaFile: mediaFile,
      );
      Get.back(result: true);
      Get.snackbar(
        "Success",
        "Post created successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      );
    } catch (error) {
      Get.snackbar(
        "Unable to create post",
        error.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isPosting.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
