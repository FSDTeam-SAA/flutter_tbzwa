import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecordingScreen extends StatefulWidget {
  const AudioRecordingScreen({super.key});

  @override
  State<AudioRecordingScreen> createState() => _AudioRecordingScreenState();
}

class _AudioRecordingScreenState extends State<AudioRecordingScreen> {
  late final RecorderController recorderController;
  final AudioRecorder audioRecorder = AudioRecorder();

  bool isRecording = false;
  bool isPaused = false;
  String? path;
  Duration duration = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initialiseControllers();
  }

  void _initialiseControllers() {
    recorderController = RecorderController();
  }

  @override
  void dispose() {
    recorderController.dispose();
    audioRecorder.dispose();
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        duration += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    timer?.cancel();
    duration = Duration.zero;
  }

  Future<void> _startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        path =
            '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await audioRecorder.start(const RecordConfig(), path: path!);
        await recorderController.record();

        setState(() {
          isRecording = true;
          isPaused = false;
        });
        _startTimer();
      }
    } catch (e) {
      debugPrint("Error starting recording: $e");
    }
  }

  Future<void> _pauseRecording() async {
    try {
      await audioRecorder.pause();
      await recorderController.pause();
      setState(() {
        isPaused = true;
      });
      timer?.cancel();
    } catch (e) {
      debugPrint("Error pausing recording: $e");
    }
  }

  Future<void> _resumeRecording() async {
    try {
      await audioRecorder.resume();
      await recorderController.record();
      setState(() {
        isPaused = false;
      });
      _startTimer();
    } catch (e) {
      debugPrint("Error resuming recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await audioRecorder.stop();
      await recorderController.stop();

      setState(() {
        isRecording = false;
        isPaused = false;
      });
      _stopTimer();

      if (path != null) {
        debugPrint("Recording saved to: $path");
        Get.snackbar(
          "Success",
          "Recording saved",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Error stopping recording: $e");
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF374151)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Recording Voice",
          style: TextStyle(
            color: Color(0xFF374151),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const Spacer(),
            // Waveform
            AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width, 100.0),
              recorderController: recorderController,
              enableGesture: true,
              waveStyle: WaveStyle(
                waveColor: const Color(0xFF26A69A),
                spacing: 8.0,
                showMiddleLine: false,
                extendWaveform: true,
              ),
            ),
            //const SizedBox(height: 48),
            // Timer
            Text(
              _formatDuration(duration),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              isRecording
                  ? (isPaused ? 'TAP MIC TO RESUME' : 'TAP MIC TO PAUSE')
                  : "TAP MIC TO START",
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 16),
            ),
            const Spacer(),
            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleButton(
                  icon: Icons.delete_outline,
                  color: Colors.red.shade50,
                  iconColor: Colors.red,
                  onTap: () => Get.back(),
                ),
                GestureDetector(
                  onTap: () {
                    if (!isRecording) {
                      _startRecording();
                    } else if (isPaused) {
                      _resumeRecording();
                    } else {
                      _pauseRecording();
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A69A),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF26A69A).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      isRecording && !isPaused ? Icons.pause : Icons.mic,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                _buildCircleButton(
                  icon: Icons.stop,
                  color: const Color(0xFFFF6B6B),
                  iconColor: const Color(0xFFFFFFFF),
                  onTap: isRecording ? _stopRecording : null,
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}
