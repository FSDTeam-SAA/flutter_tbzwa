import 'package:flutter/material.dart';
import 'package:flutter_tbzwa/core/constants/assest_const.dart';
import 'package:get/get.dart';

class ClassDetailsScreen extends StatelessWidget {
  final String title;
  final String time;

  const ClassDetailsScreen({
    super.key,
    this.title = 'IMMERSION++',
    this.time = 'Today, 09:00 AM',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Class Details',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer Banner
            _buildTimerBanner(),
            const SizedBox(height: 30),

            // Live Status Marker
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBFDF5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2FBDA3),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Class is Live',
                      style: TextStyle(
                        color: Color(0xFF2FBDA3),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Class Title
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Instructor Section
            _buildSectionTitle('INSTRUCTOR'),
            const SizedBox(height: 12),
            _buildInstructorCard(),
            const SizedBox(height: 30),

            // Description Section
            _buildSectionTitle('CLASS DESCRIPTION'),
            const SizedBox(height: 12),
            const Text(
              'In this session, we will focus on mastering past narrative tenses.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF191C1F),
                fontWeight: FontWeight.w500,
                //height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Objectives Section
            _buildSectionTitle('OBJECTIVES'),
            const SizedBox(height: 12),
            _buildObjectiveItem('Accurately use past continuous vs. past simple.'),
            _buildObjectiveItem('Tell a 2-minute personal story.'),
            _buildObjectiveItem('Participate in small group discussions.'),
            const SizedBox(height: 30),

            // Attendance Section
            _buildSectionTitle('WILL YOU ATTEND?'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildAttendanceButton('Going', Icons.check_circle_outline, isSelected: true)),
                const SizedBox(width: 12),
                Expanded(child: _buildAttendanceButton('Maybe', Icons.help_outline, isSelected: false)),
                const SizedBox(width: 12),
                Expanded(child: _buildAttendanceButton('Not Going', Icons.cancel_outlined, isSelected: false)),
              ],
            ),
            const SizedBox(height: 40),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22A892),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Join Via Zoom',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFEAEDF1))
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFF22A892),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Starts in 15 minutes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                "Don't forget your session today!",
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF94A3B8).withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF94A3B8),
      ),
    );
  }

  Widget _buildInstructorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width:2 ,color: Color(0xFFEAEDF1))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AssetsConstants.images.profileImage),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mr. Samuel',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1F),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'English coach with 5+ years experience specializing in conversational fluenncy.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFF22A892), size: 18),
                    const SizedBox(width: 4),
                    const Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(color: Color(0xFF000000), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '2.4k Students',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectiveItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(Icons.circle, size: 4, color: Color(0xFF1E293B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF191C1F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton(String label, IconData icon, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFBFF9F0) : Colors.white,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF22A892) : const Color(0xFF94A3B8),
            size: 24,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF22A892) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
