import 'package:flutter/material.dart';
import '../../../core/constants/assest_const.dart' hide Icons;
import 'manage_group_screen.dart';

class InstructorGroupsScreen extends StatelessWidget {
  const InstructorGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "TALK/'BZ/",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Groups",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Manage your assigned classes and students.",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search groups...",
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  icon: SizedBox.shrink(), // No icon inside as per image? Wait, search bar usually has one, but image shows none.
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.filter_list, color: Color(0xFF6B7280), size: 20),
                  SizedBox(width: 12),
                  Text(
                    "All Status",
                    style: TextStyle(color: Color(0xFF4B5563), fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down, color: Color(0xFF6B7280)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Group Cards
            _buildGroupCard(
              context: context,
              letter: "A",
              title: "Advanced Calculus 101",
              students: "35 Students",
              time: "2 hours ago",
              color: const Color(0xFF5151EF),
              status: "Active",
            ),
            _buildGroupCard(
              context: context,
              letter: "P",
              title: "Physics Fundamentals",
              students: "42 Students",
              time: "5 hours ago",
              color: const Color(0xFF10B981),
              status: "Active",
            ),
            _buildGroupCard(
              context: context,
              letter: "L",
              title: "Linear Algebra",
              students: "28 Students",
              time: "1 day ago",
              color: const Color(0xFFF59E0B),
              status: "Active",
            ),
            _buildGroupCard(
              context: context,
              letter: "Q",
              title: "Quantum Mechanics Intro",
              students: "15 Students",
              time: "2 days ago",
              color: const Color(0xFF8B5CF6),
              status: "Active",
            ),
            _buildGroupCard(
              context: context,
              letter: "B",
              title: "Basic Geometry",
              students: "22 Students",
              time: "1 month ago",
              color: const Color(0xFF64748B),
              status: "Expired",
              isExpired: true,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCard({
    required BuildContext context,
    required String letter,
    required String title,
    required String students,
    required String time,
    required Color color,
    required String status,
    bool isExpired = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Border Highlight
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color.withAlpha(200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isExpired ? const Color(0xFFF1F5F9) : const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: isExpired ? const Color(0xFF64748B) : const Color(0xFF15803D),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.people_outline, size: 16, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 6),
                    Text(
                      students,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.access_time, size: 16, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageGroupScreen(
                          groupName: title,
                          studentCount: students,
                          instructorName: "Dr. Sarah Jenkins",
                          primaryColor: color,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Manage Group",
                        style: TextStyle(
                          color: Color(0xFF5151EF),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFF5151EF),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
