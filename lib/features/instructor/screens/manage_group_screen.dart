import 'package:flutter/material.dart';

class ManageGroupScreen extends StatefulWidget {
  final String groupName;
  final String studentCount;
  final String instructorName;
  final Color primaryColor;

  const ManageGroupScreen({
    super.key,
    required this.groupName,
    required this.studentCount,
    required this.instructorName,
    this.primaryColor = const Color(0xFF5151EF),
  });

  @override
  State<ManageGroupScreen> createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF5151EF), size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Groups",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 10),
                  if (_selectedTabIndex == 0) _buildMembersSection(),
                  if (_selectedTabIndex == 1) _buildChatSection(),
                  if (_selectedTabIndex == 2) _buildVoiceRoomsSection(),
                  if (_selectedTabIndex == 3) _buildVideoClassSection(),
                ],
              ),
            ),
          ),
          if (_selectedTabIndex == 1) _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Banner
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: widget.primaryColor.withAlpha(200),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groupName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.people_outline, size: 18, color: Color(0xFF6B7280)),
                          const SizedBox(width: 6),
                          Text(
                            widget.studentCount,
                            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                          ),
                          const SizedBox(width: 12),
                          const Text("•", style: TextStyle(color: Color(0xFF6B7280))),
                          const SizedBox(width: 12),
                          const Text(
                            "Managed by",
                            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.instructorName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4B5563),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                        label: const Text(
                          "Start Class",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, color: Color(0xFFF3F4F6)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabIcon(0, Icons.group_outlined),
                        _buildTabIcon(1, Icons.chat_bubble_outline),
                        _buildTabIcon(2, Icons.mic_none),
                        _buildTabIcon(3, Icons.videocam_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: 20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.groupName.isNotEmpty ? widget.groupName[0] : "G",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabIcon(int index, IconData icon) {
    bool isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? widget.primaryColor : const Color(0xFF9CA3AF),
            size: 28,
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              width: 40,
              height: 3,
              decoration: BoxDecoration(
                color: widget.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMembersSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Group Members",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          // Search Input
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search members...",
                hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildMemberItem(
            name: "Alex Johnson",
            status: "Active",
            statusColor: const Color(0xFF10B981),
            rsvp: "Going",
            rsvpColor: const Color(0xFFDCFCE7),
            rsvpTextColor: const Color(0xFF15803D),
          ),
          _buildMemberItem(
            name: "Maria Garcia",
            status: "Active",
            statusColor: const Color(0xFF10B981),
            rsvp: "Maybe",
            rsvpColor: const Color(0xFFFEF3C7),
            rsvpTextColor: const Color(0xFFB45309),
          ),
          _buildMemberItem(
            name: "James Smith",
            status: "Expired",
            statusColor: const Color(0xFF9CA3AF),
            rsvp: "Not Going",
            rsvpColor: const Color(0xFFFEE2E2),
            rsvpTextColor: const Color(0xFFB91C1C),
          ),
          _buildMemberItem(
            name: "Linda Chen",
            status: "Active",
            statusColor: const Color(0xFF10B981),
            rsvp: "Going",
            rsvpColor: const Color(0xFFDCFCE7),
            rsvpTextColor: const Color(0xFF15803D),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildChatSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Group Discussion",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Instructor has moderation controls",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 32),
          _buildChatMessage(
            name: "Alex Johnson",
            time: "09:15 AM",
            message: "Will we cover chapter 4 today?",
            isInstructor: false,
          ),
          _buildChatMessage(
            name: "Dr. Sarah Jenkins",
            time: "09:20 AM",
            message: "Yes, we will start with chapter 4 and if time permits, move to chapter 5.",
            isInstructor: true,
          ),
          _buildChatMessage(
            name: "Maria Garcia",
            time: "09:25 AM",
            message: "Great, thanks!",
            isInstructor: false,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildChatMessage({
    required String name,
    required String time,
    required String message,
    required bool isInstructor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isInstructor ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isInstructor)
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFE5E7EB),
              child: Text(name[0], style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
            ),
          if (!isInstructor) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: isInstructor ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isInstructor) ...[
                      Text(
                        time,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    if (!isInstructor) ...[
                      const SizedBox(width: 8),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                      ),
                    ],
                    if (isInstructor) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E7FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "INSTRUCTOR",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4338CA),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isInstructor ? widget.primaryColor : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isInstructor ? 16 : 0),
                      bottomRight: Radius.circular(isInstructor ? 0 : 16),
                    ),
                    border: isInstructor ? null : Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: isInstructor ? Colors.white : const Color(0xFF4B5563),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isInstructor) const SizedBox(width: 12),
          if (isInstructor)
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFE5E7EB),
              child: Text(name[0], style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
            ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_file, color: Color(0xFF9CA3AF), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Type a message to the group...",
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceRoomsSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Active Rooms",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Voice and video study rooms\nfor this group",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9CA3AF),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mic_none, size: 16, color: widget.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      "Create Room",
                      style: TextStyle(
                        color: widget.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildRoomCard(
            title: "Math Study Group",
            isPublic: true,
            host: "Alex Johnson",
            avatars: ["A", "B", "C", "D"],
            extraCount: "+4",
          ),
          const SizedBox(height: 16),
          _buildRoomCard(
            title: "Physics Q&A",
            isPublic: false,
            host: "Dr. Sarah Jenkins",
            avatars: ["A", "B", "C"],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildRoomCard({
    required String title,
    required bool isPublic,
    required String host,
    required List<String> avatars,
    String? extraCount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPublic ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isPublic ? "Public" : "Private",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isPublic ? const Color(0xFF15803D) : const Color(0xFFB45309),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "Host:",
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(width: 6),
              Text(
                host,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  for (int i = 0; i < avatars.length; i++)
                    Align(
                      widthFactor: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: const Color(0xFFE5E7EB),
                          child: Text(
                            avatars[i],
                            style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  if (extraCount != null)
                    Align(
                      widthFactor: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: const Color(0xFFF3F4F6),
                          child: Text(
                            extraCount,
                            style: const TextStyle(fontSize: 9, color: Color(0xFF6B7280), fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  minimumSize: const Size(60, 32),
                ),
                child: const Text("Join", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoClassSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.videocam_outlined, size: 40, color: widget.primaryColor),
          ),
          const SizedBox(height: 24),
          const Text(
            "Next Live Class",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Derivatives & Integrals",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Time", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                          SizedBox(height: 6),
                          Text("10:00 AM -", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                          SizedBox(height: 2),
                          Text("11:30 AM", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Platform", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                          const SizedBox(height: 6),
                          Row(
                            children: const [
                              Icon(Icons.videocam, size: 16, color: Color(0xFF2563EB)),
                              SizedBox(width: 6),
                              Text("Zoom", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
                const SizedBox(height: 16),
                const Text("RSVP Status", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRsvpInfo(const Color(0xFF10B981), "24", "Going"),
                    _buildRsvpInfo(const Color(0xFFF59E0B), "5", "Maybe"),
                    _buildRsvpInfo(const Color(0xFFEF4444), "2", "Not"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
              label: const Text(
                "Start Class as Host",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Edit Details",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildRsvpInfo(Color color, String count, String label) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Row(
          children: [
            Text(count, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
          ],
        ),
      ],
    );
  }


  Widget _buildMemberItem({
    required String name,
    required String status,
    required Color statusColor,
    required String rsvp,
    required Color rsvpColor,
    required Color rsvpTextColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFE5E7EB),
                child: Text(
                  name[0],
                  style: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF9CA3AF), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Next Class RSVP:",
                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: rsvpColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  rsvp,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: rsvpTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
