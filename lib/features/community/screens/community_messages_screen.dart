import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'friend_requests_screen.dart';
import 'user_profile_screen.dart';
import '../controllers/community_controller.dart';

class CommunityMessagesScreen extends StatelessWidget {
  const CommunityMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());
    
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Community",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Search Bar ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Friend Requests Section ──────────────────────────────
                  _buildFriendRequestsSection(controller),

                  // ─── Friends Online Section ──────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Friends Online",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "3 active",
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildOnlineFriend("Elena", "https://i.pravatar.cc/150?u=elena", true),
                        _buildOnlineFriend("Kenji", "https://i.pravatar.cc/150?u=kenji", true),
                        _buildOnlineFriend("Marco", "https://i.pravatar.cc/150?u=marco", true),
                        _buildOnlineFriend("Yama", "https://i.pravatar.cc/150?u=yama", false),
                        _buildNewFriendButton(),
                      ],
                    ),
                  ),

                  // ─── Messages Section ────────────────────────────────────────
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 16),
                    child: Text(
                      "Messages",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  _buildMessageItem(
                    name: "Emma Watson",
                    message: "Perfect! Let's practice the subj...",
                    time: "12:45 PM",
                    imageUrl: "https://i.pravatar.cc/150?u=emma",
                  ),
                  _buildMessageItem(
                    name: "Kenji Sato",
                    message: "Perfect! Let's practice the subj...",
                    time: "Yesterday",
                    imageUrl: "https://i.pravatar.cc/150?u=kenji2",
                  ),
                  _buildMessageItem(
                    name: "Marie Dubois",
                    message: "Perfect! Let's practice the subj...",
                    time: "Monday",
                    imageUrl: "https://i.pravatar.cc/150?u=marie",
                  ),
                  _buildMessageItem(
                    name: "Carlos Ruiz",
                    message: "Perfect! Let's practice the subj...",
                    time: "Tuesday",
                    imageUrl: "https://i.pravatar.cc/150?u=carlos",
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRequestsSection(CommunityController controller) {
    return Obx(() {
      if (controller.friendRequests.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => const FriendRequestsScreen()),
                  child: const Text(
                    "Friend Requests",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
                Text(
                  "${controller.friendRequests.length}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...controller.friendRequests.take(2).toList().asMap().entries.map((entry) {
            int idx = entry.key;
            var req = entry.value;
            return _buildFriendRequestPreviewCard(
              name: req['name']!,
              subtitle: req['subtitle']!,
              mutual: req['mutual']!,
              imageUrl: req['imageUrl']!,
              bgColor: idx % 2 == 0 ? const Color(0xFFEFF6FF) : const Color(0xFFFFF7ED),
            );
          }).toList(),
        ],
      );
    });
  }

  Widget _buildFriendRequestPreviewCard({
    required String name,
    required String subtitle,
    required String mutual,
    required String imageUrl,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(imageUrl),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
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
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                Text(
                  mutual,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
          Row(
            children: [

              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.close, size: 16, color: Colors.black,),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF006B5B),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.check, size: 16, color: Colors.white,),
                  ),
                ),
              ),

              // OutlinedButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(),
              //   label: const Text("Decline", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: const Color(0xFFD9D9D9),
              //     minimumSize: const Size(90, 36),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineFriend(String name, String imageUrl, bool isActive) {
    return GestureDetector(
      onTap: () => Get.to(() => UserProfileScreen(name: name, imageUrl: imageUrl)),
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? const Color(0xFF10B981) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl),
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                if (isActive)
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewFriendButton() {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Container(
            height: 66,
            width: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFD1D5DB),
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
            child: const Icon(Icons.add, color: Color(0xFF9CA3AF), size: 30),
          ),
          const SizedBox(height: 8),
          const Text(
            "New",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem({
    required String name,
    required String message,
    required String time,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () => Get.to(() => UserProfileScreen(name: name, imageUrl: imageUrl)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey[200],
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
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
