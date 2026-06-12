import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayProgressScreen extends StatelessWidget {
  const TodayProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Today's Progress", style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1F2937), size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildCircularProgress(),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF2EE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Moderately Engaged (72%)",
                style: TextStyle(color: Color(0xFF000000), fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
            _buildAchievementCard(),
            const SizedBox(height: 40),
            Container(decoration:BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16)
            ),child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildActivityBreakdown(),
            )),
            const SizedBox(height: 40),
            _buildWeeklyActivity(),
            const SizedBox(height: 40),
            _buildStatsCards(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDFF2EE),
                foregroundColor: const Color(0xFF006B5B),
                elevation: 0,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Complete Today's Tasks", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress() {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: 0.72,
                strokeWidth: 15,
                backgroundColor: const Color(0xFFF3F4F6),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF26A69A)),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "72%",
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Color(0xFF1F2937)),
                ),
                const Text(
                  "DAILY SCORE",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(
                      0xFF9CA4B1), letterSpacing: 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFCCE8E7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            "Nice Progress Kathy!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 12),
          const Text(
            "Few progress are still remaining.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Color(0xFF000000), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBreakdown() {
    final activities = [
      {'label': 'Daily Voice', 'progress': 2 / 3, 'value': '2/3', 'icon': Icons.mic_none_rounded, 'color': Color(0xFF26A69A)},
      {'label': 'Daily Video', 'progress': 1 / 3, 'value': '1/3', 'icon': Icons.video_camera_back_outlined, 'color': Color(0xFF26A69A)},
      {'label': 'Daily Vocabulary', 'progress': 2 / 2, 'value': '2/2', 'icon': Icons.text_fields_rounded, 'color': Color(0xFF26A69A)},
      {'label': 'Daily Summary', 'progress': 1 / 2, 'value': '1/2', 'icon': Icons.assignment_outlined, 'color': Color(0xFF26A69A)},
      {'label': 'Daily English Immersion', 'progress': 0 / 1, 'value': '0/1', 'icon': Icons.headphones_outlined, 'color': Color(0xFFD1D5DB)},
      {'label': 'Daily BZPad', 'progress': null, 'value': 'REMINDER', 'icon': Icons.edit_note_rounded, 'color': Color(0xFF26A69A)},
      {'label': 'Switch Everything In English', 'progress': null, 'value': 'REMINDER', 'icon': Icons.star_border_rounded, 'color': Color(0xFF26A69A)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Activity Breakdown", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(6)),
              child: const Text("Total 100%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(
                  0xFF686F7C))),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...activities.map((act) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(decoration: BoxDecoration(
                    color: Color(0xFFEAFDFA), borderRadius: BorderRadius.circular(100)
                  ),child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(act['icon'] as IconData, size: 18, color: act['color'] as Color),
                  )),
                  const SizedBox(width: 12),
                  Text(act['label'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Text(
                    act['value'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: act['value'] == 'REMINDER' ? const Color(0xFF26A69A) : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              if (act['progress'] != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: LinearProgressIndicator(
                    value: act['progress'] as double,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(act['color'] as Color),
                  ),
                ),
              ],
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildWeeklyActivity() {
    final days = [
      {'day': 'M', 'progress': 0.8},
      {'day': 'T', 'progress': 0.5},
      {'day': 'W', 'progress': 1.0},
      {'day': 'T', 'progress': 0.6},
      {'day': 'F', 'progress': 0.9},
      {'day': 'S', 'progress': 0.2},
      {'day': 'S', 'progress': 0.7},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) => Column(
        children: [
          Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              heightFactor: d['progress'] as double,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF30EDCD),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(d['day'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
        ],
      )).toList(),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        _buildStatItem("Current Streak", "12 Days", Icons.auto_graph_rounded),
        const SizedBox(width: 16),
        _buildStatItem("Average Score", "70%", Icons.percent_rounded),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFC7C8CF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(decoration:BoxDecoration(
              color: Color(0xFFEAFDFA), borderRadius: BorderRadius.circular(100)
            ),child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: const Color(0xFF26A69A), size: 20),
            )),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
          ],
        ),
      ),
    );
  }
}
