import 'package:get/get.dart';
import '../models/note_model.dart';

class BZPadController extends GetxController {
  var notes = <NoteModel>[].obs;
  var searchText = "".obs;
  
  // Mock data based on screenshots
  @override
  void onInit() {
    super.onInit();
    // Start with empty notes as per requirement
    notes.clear();
  }

  void addNote(String title, String content) {
    final newNote = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: content,
      updatedAt: DateTime.now(),
      type: 'note', // Default type
    );
    notes.insert(0, newNote); // Add to the top of the list
  }


  List<NoteModel> get filteredNotes {
    if (searchText.value.isEmpty) return notes;
    return notes.where((n) => 
      n.title.toLowerCase().contains(searchText.value.toLowerCase()) ||
      n.content.toLowerCase().contains(searchText.value.toLowerCase())
    ).toList();
  }

  void deleteNote(String id) {
    notes.removeWhere((n) => n.id == id);
  }
}
