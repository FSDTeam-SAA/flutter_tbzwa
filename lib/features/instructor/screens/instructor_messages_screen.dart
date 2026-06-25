import 'package:flutter/material.dart';

class InstructorMessagesScreen extends StatelessWidget {
  const InstructorMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // User requested no back arrow
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Messages",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            _buildMessageCard(
              name: "Emma Watson",
              message: "Perfect! Let's practice the subj...",
              time: "12:45 PM",
              imagePath: "https://i.pravatar.cc/150?u=a042581f4e29026024d", // Random avatar fallback
              initial: "E",
            ),
            _buildMessageCard(
              name: "Kenji Sato",
              message: "Perfect! Let's practice the subj...",
              time: "Yesterday",
              imagePath: "https://i.pravatar.cc/150?u=a04258a2462d826712d",
              initial: "K",
            ),
            _buildGroupMessageCard(
              name: "Linear Class",
              message: "Perfect! Let's practice the subj...",
              time: "Monday",
            ),
            _buildMessageCard(
              name: "Carlos Ruiz",
              message: "Perfect! Let's practice the subj...",
              time: "Tuesday",
              imagePath: "https://i.pravatar.cc/150?u=a04258114e29026702d",
              initial: "C",
            ),
            _buildGroupMessageCard(
              name: "Linear Class",
              message: "Perfect! Let's practice the subj...",
              time: "Monday",
            ),
            _buildMessageCard(
              name: "Carlos Ruiz",
              message: "Perfect! Let's practice the subj...",
              time: "Tuesday",
              imagePath: "https://i.pravatar.cc/150?u=a04258114e29026702d",
              initial: "C",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageCard({
    required String name,
    required String message,
    required String time,
    required String imagePath,
    required String initial,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFE5E7EB),
            backgroundImage: NetworkImage(imagePath),
            child: imagePath.isEmpty ? Text(
              initial,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
            ) : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Text(
                 time,
                 style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
               ),
               const SizedBox(height: 20),
             ]
          )
        ],
      ),
    );
  }

  Widget _buildGroupMessageCard({
    required String name,
    required String message,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 48,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFE5E7EB),
                    backgroundImage: const NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026024d"),
                  ),
                ),
                Positioned(
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFFE5E7EB),
                      backgroundImage: const NetworkImage("https://i.pravatar.cc/150?u=a04258a2462d826712d"),
                    ),
                  ),
                ),
                Positioned(
                  left: 32,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFD1D5DB),
                      child: Text("11+", style: TextStyle(color: Color(0xFF4B5563), fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F2937)),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF), 
                    fontSize: 13,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Text(
                 time,
                 style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
               ),
               const SizedBox(height: 20),
             ]
          )
        ],
      ),
    );
  }
}
