import 'package:flutter/material.dart';

class InstructorEditProfileScreen extends StatelessWidget {
  const InstructorEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Account",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Done",
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                   const CircleAvatar(
                     radius: 40,
                     backgroundColor: Color(0xFFE5E7EB),
                     backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=a042581f4e29026024d"),
                   ),
                   Positioned(
                     bottom: 0,
                     right: 0,
                     child: Container(
                       padding: const EdgeInsets.all(4),
                       decoration: const BoxDecoration(
                         color: Color(0xFF1F2937),
                         shape: BoxShape.circle,
                       ),
                       child: const Icon(Icons.edit, color: Colors.white, size: 14),
                     ),
                   )
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(label: "Name", hint: "John Doe"),
            const SizedBox(height: 20),
            _buildTextField(label: "Phone Number", hint: "01547898622"),
            const SizedBox(height: 20),
            _buildTextField(label: "Email", hint: "John@hmail.com"),
            const SizedBox(height: 20),
            _buildTextField(
              label: "Bio",
              hint: "Senior Instructor specializing in Advanced Mathematics and Physics. 10+ years of teaching experience.",
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF4B5563), fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF5151EF)),
            ),
          ),
        ),
      ],
    );
  }
}
