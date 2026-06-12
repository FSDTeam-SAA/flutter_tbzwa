import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vocabulary_list_screen.dart';

class LibraryHomeScreen extends StatefulWidget {
  const LibraryHomeScreen({super.key});

  @override
  State<LibraryHomeScreen> createState() => _LibraryHomeScreenState();
}

class _LibraryHomeScreenState extends State<LibraryHomeScreen> {
  int _selectedFolderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 30),
              const Text("My Folders",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
              const SizedBox(height: 16),
              _buildFoldersList(),
              const SizedBox(height: 30),
              
              // Dynamic Content Section
              if (_selectedFolderIndex == 0) ...[
                _buildVocabularyHeader("Vocabulary (12)"),
                const SizedBox(height: 16),
                _buildVocabularyGrid(),
              ] else if (_selectedFolderIndex == 1) ...[
                _buildComingSoonSection("Discover II", const Color(0xFFDCFCE7)),
              ] else if (_selectedFolderIndex == 2) ...[
                _buildComingSoonSection("Discover III", const Color(0xFFFCE7F3)),
              ],
              
              const SizedBox(height: 30),
            ],
          ),
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
        decoration: InputDecoration(
          hintText: "Search vocabulary...",
          hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          icon: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFoldersList() {
    final folders = [
      {'title': 'Discover I', 'color': const Color(0xFFE0DEFF)},
      {'title': 'Discover II', 'color': const Color(0xFFDCFCE7)},
      {'title': 'Discover III', 'color': const Color(0xFFFCE7F3)},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(folders.length, (index) {
          final folder = folders[index];
          bool isSelected = _selectedFolderIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFolderIndex = index;
              });
            },
            child: Container(
              width: 112,
              height: 100,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: folder['color'] as Color,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(
                        color: const Color(0xFF4A82E7),
                        width: 2,
                      )
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.description_outlined, color: Colors.black),
                  const SizedBox(height: 8),
                  Text(
                    folder['title'] as String,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildVocabularyHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
      ],
    );
  }

  Widget _buildVocabularyGrid() {
    final categories = [
      {
        'title': 'Bathroom Equipment',
        'image': 'assets/images/bathroom_equipment.png',
      },
      {'title': 'Bathroom Verbs', 'image': 'assets/images/mdi_bathroom.png'},
      {
        'title': 'Bathroom Actions',
        'image': 'assets/images/bathroom_actions.png',
      },
      {'title': 'Professions', 'image': 'assets/images/professions.png'},
      {'title': 'Body Actions', 'image': 'assets/images/body_actions.png'},
      {'title': 'Furniture', 'image': 'assets/images/furniture.png'},
      {'title': 'Small Menu', 'image': 'assets/images/menu-small.png'},
      {'title': 'Kitchen', 'image': 'assets/images/kitchen.png'},
      {'title': 'Cooking Teams', 'image': 'assets/images/cooking_teams.png'},
      {'title': 'Knowledge Disabilities', 'image': 'assets/images/disability.png'},
      {'title': 'Common Mistakes', 'image': 'assets/images/mistakes.png'},
      {'title': 'Kitchen Verbs', 'image': 'assets/images/kitchen-knives.png'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final cat = categories[index];
        return GestureDetector(
          onTap: () => Get.to(() => VocabularyListScreen(category: cat['title'] as String)),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFDFF2EE),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF4A82E7), width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      cat['image'] as String,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                //Icon(cat['icon'] as IconData, color: const Color(0xFF1F2937), size: 24),
                const SizedBox(height: 8),
                Text(
                  cat['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildComingSoonSection(String title, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lock_outline, color: color, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Coming Soon",
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
