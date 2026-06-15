import 'package:flutter/material.dart';
import '../../subcribers_flow/subscriber_menu_drawer.dart';

class VoiceRoom extends StatefulWidget {
  const VoiceRoom({super.key});

  @override
  State<VoiceRoom> createState() => _VoiceRoomState();
}

class _VoiceRoomState extends State<VoiceRoom> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _teacherNames = [
    "Thomas",
    "Philip",
    "Mitchell",
    "Dwight",
    "Lee",
    "Eduardo",
    "Calvin",
    "Sarah"
  ];

  late List<Map<String, dynamic>> _allRooms;
  List<Map<String, dynamic>> _filteredRooms = [];

  @override
  void initState() {
    super.initState();
    _allRooms = List.generate(8, (index) {
      return {
        "index": index + 1,
        "teacher": _teacherNames[index % _teacherNames.length],
        "title": "Advanced English - Class ${(index + 1).toString().padLeft(2, '0')}"
      };
    });
    _filteredRooms = _allRooms;
  }

  void _filterRooms(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRooms = _allRooms;
      } else {
        _filteredRooms = _allRooms
            .where((room) =>
                room['title'].toLowerCase().contains(query.toLowerCase()) ||
                room['teacher'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      drawer: const SubscriberMenuDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: const Icon(
                              Icons.menu,
                              color: Color(0xFF1E293B),
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildHeader(),
                  ],
                ),
              ),

            Divider(
              color: Color(0xFFD1D1D1),
            ),
            
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildSearchBar(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredRooms.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = _filteredRooms[index];
                        return _buildVoiceRoomCard(
                          index: room['index'],
                          teacherName: room['teacher'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No rooms found",
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAEDF1)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterRooms,
        style: const TextStyle(color: Color(0xFF536F7A)),
        decoration: const InputDecoration(
          hintText: "Search notes...",
          hintStyle: TextStyle(color: Color(0xFF90A4AE), fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Color(0xFF90A4AE)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildVoiceRoomCard({required int index, required String teacherName, bool hasBorder = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasBorder ? const Color(0xFF26A69A) : const Color(0xFFEAEDF1),
          width: hasBorder ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Advanced English - Class ${index.toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=$teacherName"),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    teacherName,
                    style: const TextStyle(
                      color: Color(0xFF374151),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              _buildParticipantAvatars(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Builder(
          //   builder: (context) => GestureDetector(
          //     onTap: () => Scaffold.of(context).openDrawer(),
          //     child: const Icon(Icons.menu, color: Color(0xFF1E293B), size: 24),
          //   ),
          // ),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
                letterSpacing: 0.5,
              ),
              children: [
                TextSpan(text: "TALK/"),
                TextSpan(text: "'BZ/"),
              ],
            ),
          ),
          const SizedBox(width: 24),
          // balance spacer
        ],
      ),
    );
  }

  Widget _buildParticipantAvatars() {
    return SizedBox(
      height: 32,
      width: 100, // Adjusted based on overlap
      child: Stack(
        children: List.generate(4, (index) {
          return Positioned(
            right: index * 20.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=p$index${DateTime.now().millisecond}"),
              ),
            ),
          );
        }),
      ),
    );
  }
}
