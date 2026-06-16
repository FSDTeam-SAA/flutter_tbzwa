import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'video_recording_screen.dart';

class DailyVideoRecordingScreen extends StatelessWidget {
  const DailyVideoRecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF374151), size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Daily Video Recording",
          style: TextStyle(
            color: Color(0xFF374151),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF94A3B8)),
                  hintText: "Search recordings...",
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Today's Video Progress Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEBECEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0F2F1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "MISSION ACTIVE",
                              style: TextStyle(
                                color: Color(0xFF151918),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Today's Video\nProgress",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF374151),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF26A69A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.videocam_rounded, color: Colors.white, size: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress to Mastery",
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                      ),
                      Text(
                        "2/3",
                        style: TextStyle(color: Color(0xFF374151), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(
                      value: 0.66,
                      minHeight: 10,
                      backgroundColor: Color(0xFFE0F2F1),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF26A69A)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Start Video Recording Button
            ElevatedButton(
              onPressed: () => Get.to(() => const VideoRecordingScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF26A69A),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text(
                "Start Video Recording",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Consistency Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEBECEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Weekly Consistency",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDayItem("M", 1.0, isActive: true),
                      _buildDayItem("T", 0.6),
                      _buildDayItem("W", 0.8),
                      _buildDayItem("T", 0.5),
                      _buildDayItem("F", 0.9),
                      _buildDayItem("S", 0.2),
                      _buildDayItem("S", 1.0, isSpecial: true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Stats row
            Row(
              children: [
                 _buildSmallStatCard("Current Streak", "12 Days", Icons.bolt, const Color(0xFF26A69A)),
                 const SizedBox(width: 16),
                 _buildSmallStatCard("Average Score", "70%", Icons.percent, const Color(0xFF26A69A)),
              ],
            ),
            const SizedBox(height: 32),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip("All Recordings", isActive: true),
                  _buildFilterChip("Morning Drill"),
                  _buildFilterChip("Afternoon Dr."),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Daily Voice Section (Should probably be Daily Video based on image labels?)
            // Actually, the image says "Daily Voice 2/3" at the bottom but let's follow the title
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daily Voice",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF374151)),
                ),
                Text(
                  "2/3",
                  style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Recording List Items
            _buildRecordingItem(
              "Morning Drill",
              "Vowel pronunciation &\ntone check",
              Icons.play_arrow_rounded,
            ),
            _buildRecordingItem(
              "Afternoon Flunency",
              "3-minute casual\nconversation",
              Icons.play_arrow_rounded,
            ),
            _buildRecordingItem(
              "Evening Reflection",
              "Summarize your day in target\nlanguage",
              Icons.mic, // Keep as per image
              isActive: true,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, double heightFactor, {bool isActive = false, bool isSpecial = false}) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 48,
          decoration: BoxDecoration(
            color: isSpecial ? const Color(0xFF22A892) : const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomCenter,
          child: isActive ? Container(
            height: 48 * heightFactor,
            decoration: BoxDecoration(
              color: isSpecial ? const Color(0xFF26A69A) : const Color(0xFF26A69A).withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ) : null,
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 10, color: Color(0xFF000000), fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSmallStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEBECEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 10, color: Color(
                0xFF374151))),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF22A892) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.transparent : const Color(0xFFF1F5F9)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xFF64748B),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildRecordingItem(String title, String subtitle, IconData icon, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF26A69A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEBECEE)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.2) : const Color(0xFFE0F2F1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.white : const Color(0xFF26A69A), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : const Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.white : const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: isActive ? Colors.white : const Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}
