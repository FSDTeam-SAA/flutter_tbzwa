import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VocabularyListScreen extends StatelessWidget {
  final String category;
  const VocabularyListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> words = [
      {
        'word': 'Hello',
        'phonetic': '/hɛˈloʊ/',
        'translation': 'Bonjour',
        'example': '“Hello, how are you?”',
        'tag': 'Basics'
      },
      {
        'word': 'Goodbye',
        'phonetic': '/ɡʊdˈbaɪ/',
        'translation': 'Au revoir',
        'example': '“Goodbye, see you tomorrow!”',
        'tag': 'Basics'
      },
      {
        'word': 'Please',
        'phonetic': '/pliːz/',
        'translation': 'S\'il vous plaît',
        'example': '“Can I have some water, please?”',
        'tag': 'Basics'
      },
      {
        'word': 'Thank you',
        'phonetic': '/θæŋk juː/',
        'translation': 'Merci',
        'example': '“Thank you for your help!”',
        'tag': 'Basics'
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF263451), size: 20),
                  onPressed: () => Get.back(),
                ),
                Expanded(child: _buildSearchBar()),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildSectionHeader(category),
                  const SizedBox(height: 16),
                  ...words.map((w) => _buildWordCard(w)).toList(),
                  const SizedBox(height: 20),
                  _buildFooterSection("Bathroom Verbs"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: const TextField(
        cursorColor: Color(0xFF989494),
        style: TextStyle(color: Color(0xFF000000)),
        decoration: InputDecoration(
          hintText: "Search vocabulary...",
          hintStyle: TextStyle(color: Color(0xFF989494), fontSize: 13),
          icon: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1F2937), size: 18),
        ],
      ),
    );
  }

  Widget _buildWordCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(data['word'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
              const SizedBox(width: 12),
              const Icon(Icons.volume_up_outlined, color: Color(0xFF5151EF), size: 20),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD1D5DB).withOpacity(0.5)),
                ),
                child: Text(data['tag'], style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(data['phonetic'], style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF))),
          const SizedBox(height: 8),
          Text(data['translation'], style: const TextStyle(fontSize: 15, color: Color(0xFF5151EF), fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              data['example'],
              style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563), fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFF3F4F6)),
        ],
      ),
    );
  }

  Widget _buildFooterSection(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
          const Icon(Icons.keyboard_arrow_right, color: Color(0xFF1F2937), size: 18),
        ],
      ),
    );
  }
}
