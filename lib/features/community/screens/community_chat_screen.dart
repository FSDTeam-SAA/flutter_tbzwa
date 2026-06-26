import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'audio_call_screen.dart';
import 'video_call_screen.dart';

class CommunityChatScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const CommunityChatScreen({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<CommunityChatScreen> createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      "isMe": false,
      "text": "Salut! How's your French grammar coming along? I found a great podcast for those irregular verbs we struggled with yesterday. 🎧",
      "time": "09:42 AM"
    },
    {
      "isMe": true,
      "text": "Merci Amelia! Honestly, the subjunctive is still a bit of a nightmare. Please send the link! Is it the one with the slow-speaking narrator?",
      "time": "09:42 AM"
    },
    {
      "isMe": false,
      "text": "Salut! How's your French grammar coming along? I found a great podcast for those irregular verbs we struggled with yesterday. 🎧",
      "time": "09:42 AM"
    },
    {
      "isMe": true,
      "text": "Merci Amelia! Honestly, the subjunctive is still a bit of a nightmare. Please send the link! Is it the one with the slow-speaking narrator?",
      "time": "09:42 AM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),

              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text.rich(
                  //   TextSpan(
                  //     style: const TextStyle(
                  //       color: Color(0xFFFB923C),
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //     children: [
                  //       const TextSpan(text: "IMMERSION"),
                  //       WidgetSpan(
                  //         child: Transform.translate(
                  //           offset: const Offset(0, -4),
                  //           child: const Text(
                  //             "++",
                  //             style: TextStyle(
                  //               color: Color(0xFFFB923C),
                  //               fontSize: 6,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.phone_outlined, color: Color(0xFF5456E7), size: 18),
            ),
            onPressed: () => Get.to(() => AudioCallScreen(
              name: widget.name,
              imageUrl: widget.imageUrl,
            )),
          ),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.videocam_outlined, color: Color(0xFF5456E7), size: 18),
            ),
            onPressed: () => Get.to(() => VideoCallScreen(
              name: widget.name,
              imageUrl: widget.imageUrl,
            )),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length + 1, // +1 for date separator
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "TODAY",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  );
                }
                
                final msg = _messages[index - 1];
                return _buildMessageBubble(
                  text: msg['text'],
                  time: msg['time'],
                  isMe: msg['isMe'],
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({required String text, required String time, required bool isMe}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF5456E7) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isMe ? 20 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 20),
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : const Color(0xFF1E293B),
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 48), // Align with text start on other's messages
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _messageController,
                style: TextStyle(color: Color(0xFF1B1A1A)),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  _messages.add({
                    "isMe": true,
                    "text": _messageController.text,
                    "time": "NOW"
                  });
                  _messageController.clear();
                });
              }
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                color: Color(0xFF5456E7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
