import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'class_details_screen.dart';

class LiveClassesScreen extends StatefulWidget {
  const LiveClassesScreen({super.key});

  @override
  State<LiveClassesScreen> createState() => _LiveClassesScreenState();
}

class _LiveClassesScreenState extends State<LiveClassesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B), size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "IMMERSION++ Live Classes",
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Tab Bar Container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: const Color(0xFF22A892),
              unselectedLabelColor: const Color(0xFF94A3B8),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              tabs: const [
                Tab(text: "Today"),
                Tab(text: "Upcoming"),
                Tab(text: "Past"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildClassList("Today"),
                _buildClassList("Upcoming"),
                _buildClassList("Past"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassList(String type) {
    String dateLabel = "";
    if (type == "Today") dateLabel = "Today, 09:00 AM";
    if (type == "Upcoming") dateLabel = "Tomorrow, 09:00 AM";
    if (type == "Past") dateLabel = "Yesterday, 09:00 AM";

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildClassCard(dateLabel);
      },
    );
  }

  Widget _buildClassCard(String dateLabel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFF9F0), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "IMMERSION++",
                style: TextStyle(
                  color: Color(0xFF22A892),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dateLabel,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=sarah"),
              ),
              const SizedBox(width: 8),
              const Text(
                "Instructor: ",
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
              const Text(
                "Sarah Jenkins",
                style: TextStyle(color: Color(0xFF1E293B), fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => ClassDetailsScreen(
                  title: "IMMERSION++",
                  time: dateLabel,
                )),
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
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
