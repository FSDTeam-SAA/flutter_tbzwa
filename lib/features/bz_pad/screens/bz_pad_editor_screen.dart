import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/note_model.dart';
import '../controllers/bz_pad_controller.dart';
import 'bz_pad_history_screen.dart';



class BZPadEditorScreen extends StatefulWidget {
  final NoteModel? note;

  const BZPadEditorScreen({super.key, this.note});

  @override
  State<BZPadEditorScreen> createState() => _BZPadEditorScreenState();
}

class _BZPadEditorScreenState extends State<BZPadEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? "");
    _contentController = TextEditingController(text: widget.note?.content ?? "");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToolbar(),
            const SizedBox(height: 20),
            TextField(
              controller: _titleController,
              cursorColor: Color(0xFF263238),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
              decoration: const InputDecoration(
                hintText: "Enter Note Title...",
                hintStyle: TextStyle(color: Color(0xFF263238), fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              height: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD1D2D2), width: 1),
                ),
                child: TextField(
                  cursorColor: Color(0xFF90A4AE),
                  controller: _contentController,
                  maxLines: null,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF000000)),
                  decoration: const InputDecoration(
                    hintText: "Write your notes here...",
                    hintStyle: TextStyle(color: Color(0xFF90A4AE)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => const BZPadVersionHistoryScreen()),
                  child: const Text(
                    "Version History",
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
                      final controller = Get.find<BZPadController>();
                      controller.addNote(_titleController.text, _contentController.text);
                    }
                    Get.back();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5151EF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEDF1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.format_bold, color: Color(0xFF263238), size: 20),
          const Icon(Icons.format_italic, color: Color(0xFF263238), size: 20),
          const Icon(Icons.format_underlined, color: Color(0xFF263238), size: 20),
          Container(height: 20, width: 1, color: const Color(0xFFEAEDF1)),
          const Text("H1", style: TextStyle(color: Color(0xFF263238), fontWeight: FontWeight.bold)),
          const Text("H2", style: TextStyle(color: Color(0xFF263238), fontWeight: FontWeight.bold)),
          Container(height: 20, width: 1, color: const Color(0xFFEAEDF1)),
          const Icon(Icons.format_list_bulleted, color: Color(0xFF263238), size: 20),
          const Icon(Icons.format_list_numbered, color: Color(0xFF263238), size: 20),
        ],
      ),
    );
  }

}
