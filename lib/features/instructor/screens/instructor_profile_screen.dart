import 'package:flutter/material.dart';
import 'instructor_edit_profile_screen.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFC),
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
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 20),
            _buildAssignedGroupsCard(),
            const SizedBox(height: 20),
            _buildSettingsCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5151EF), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026024d"),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF6366F1), 
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.school, color: Colors.white, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InstructorEditProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 14, color: Color(0xFF4B5563)),
                      label: const Text("Edit", style: TextStyle(color: Color(0xFF4B5563), fontSize: 13)),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Row(
                    children: [
                      const Text(
                        "Dr. Sarah Jenkins",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Instructor",
                          style: TextStyle(color: Color(0xFF4F46E5), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Senior Instructor specializing in Advanced Mathematics and Physics. 10+ years of teaching experience.",
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.mail_outline, size: 16, color: Color(0xFF9CA3AF)),
                    SizedBox(width: 8),
                    Text("sarah.jenkins@edu.com", style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Icon(Icons.phone_outlined, size: 16, color: Color(0xFF9CA3AF)),
                    SizedBox(width: 8),
                    Text("+1 (555) 123-4567", style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedGroupsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Assigned Groups",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 20),
          _buildGroupItem(letter: "A", title: "Advanced Calculus 101", students: "35 Students", color: const Color(0xFF5151EF)),
          const SizedBox(height: 16),
          _buildGroupItem(letter: "P", title: "Physics Fundamentals", students: "42 Students", color: const Color(0xFF10B981)),
          const SizedBox(height: 16),
          _buildGroupItem(letter: "L", title: "Linear Algebra", students: "28 Students", color: const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildGroupItem({required String letter, required String title, required String students, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF1F2937))),
              const SizedBox(height: 4),
              Text(students, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.notifications_none, size: 18, color: Color(0xFF4B5563)),
              ),
              const SizedBox(width: 16),
              const Expanded(child: Text("Notifications", style: TextStyle(color: Color(0xFF4B5563), fontSize: 14, fontWeight: FontWeight.w500))),
              Switch(
                value: true,
                onChanged: (val) {},
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF5151EF),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.security, size: 18, color: Color(0xFF4B5563)),
              ),
              const SizedBox(width: 16),
              const Expanded(child: Text("Privacy & Security", style: TextStyle(color: Color(0xFF4B5563), fontSize: 14, fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 32),
          const Center(
            child: Text("Log Out", style: TextStyle(color: Color(0xFFEF4444), fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
