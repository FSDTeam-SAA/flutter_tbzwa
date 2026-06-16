import 'dart:async';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

enum RecordingState { initial, recording, paused, finished }

class AudioRecordingController extends GetxController {
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  var state = RecordingState.initial.obs;
  var duration = 0.obs;
  var clipName = "".obs;
  var amplitude = 0.0.obs;
  var amplitudeHistory = <double>[].obs;
  Timer? _timer;
  Timer? _ampTimer;
  String? _path;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _ampTimer?.cancel();
    _audioRecorder.dispose();
    super.onClose();
  }

  Future<void> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        _path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
        
        const config = RecordConfig();
        await _audioRecorder.start(config, path: _path!);
        
        state.value = RecordingState.recording;
        _startTimer();
        _startAmplitudeTimer();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to start recording: $e');
    }
  }

  Future<void> pauseRecording() async {
    try {
      await _audioRecorder.pause();
      state.value = RecordingState.paused;
      _timer?.cancel();
      _ampTimer?.cancel();
    } catch (e) {
      Get.snackbar('Error', 'Failed to pause recording: $e');
    }
  }

  Future<void> resumeRecording() async {
    try {
      await _audioRecorder.resume();
      state.value = RecordingState.recording;
      _startTimer();
      _startAmplitudeTimer();
    } catch (e) {
      Get.snackbar('Error', 'Failed to resume recording: $e');
    }
  }

  Future<void> stopRecording() async {
    try {
       final path = await _audioRecorder.stop();
       _path = path;
       state.value = RecordingState.finished;
       _timer?.cancel();
       _ampTimer?.cancel();
    } catch (e) {
      Get.snackbar('Error', 'Failed to stop recording: $e');
    }
  }

  void resetRecording() {
    state.value = RecordingState.initial;
    duration.value = 0;
    clipName.value = "";
    amplitudeHistory.clear();
    _timer?.cancel();
    _ampTimer?.cancel();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration.value++;
    });
  }

  void _startAmplitudeTimer() {
    _ampTimer?.cancel();
    _ampTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) async {
       if (state.value != RecordingState.recording) {
         timer.cancel();
         return;
       }
       final amp = await _audioRecorder.getAmplitude();
       amplitude.value = amp.current;
       
       // Normalize amplitude for visualization (usually -160 to 0)
       // Let's convert it to a positive value between 0 and 1
       double normalized = (amp.current + 160) / 160;
       if (normalized < 0) normalized = 0;
       
       amplitudeHistory.add(normalized);
       if (amplitudeHistory.length > 40) {
         amplitudeHistory.removeAt(0);
       }
    });
  }

  String formatDuration() {
    final minutes = duration.value ~/ 60;
    final seconds = duration.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
