import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BZPadVersionHistoryScreen extends StatefulWidget {
  const BZPadVersionHistoryScreen({super.key});

  @override
  State<BZPadVersionHistoryScreen> createState() => _BZPadVersionHistoryScreenState();
}

class _BZPadVersionHistoryScreenState extends State<BZPadVersionHistoryScreen> {
  int selectedIndex = 1; // "Yesterday 05:45 PM" by default for demo

  final List<Map<String, dynamic>> versions = [
    {
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'label': 'Today 12:30 AM',
      'type': 'Current Version',
    },
    {
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      'label': 'Yesterday 05:45 PM',
      'type': 'Auto saved',
    },
    {
      'time': DateTime.now().subtract(const Duration(days: 30, hours: 2)),
      'label': 'May 10, 02:15 PM',
      'type': 'Manual save',
    },
    {
      'time': DateTime.now().subtract(const Duration(days: 31, hours: 8)),
      'label': 'May 09, 09:00 AM',
      'type': 'Initial Draft',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(versions.length, (index) {
              final version = versions[index];
              final isSelected = selectedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    width: double.infinity,
                    padding: isSelected ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5) : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected 
                        ? Border.all(color: const Color(0xFF5151EF), width: 1.2)
                        : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            version['label'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF263238),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            version['type'],
                            style: TextStyle(
                              fontSize: 14,
                              color: isSelected ? const Color(0xFF5151EF) : const Color(0xFF94A3B8),
                              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  if (selectedIndex != -1) {
                    Get.back();
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  "Restore Version",
                  style: TextStyle(
                    color: selectedIndex != -1 ? const Color(0xFF5151EF) : const Color(0xFF94A3B8),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }

}
