import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'subscriber_choose_program_screen.dart';

class SubscriberProfileScreen extends StatelessWidget {
  const SubscriberProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Stack(
          children: [
            // ─── Main Content (Blurred) ──────────────────────────────────────────
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(),
                  const Divider(color: Color(0xFFD1D1D1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        _buildProfileInfoCard(),
                        const SizedBox(height: 20),
                        _buildStatsRow(),
                        const SizedBox(height: 24),
                        _buildProgressBreakdown(),
                        const SizedBox(height: 28),
                        _buildQuickActions(),
                        const SizedBox(height: 28),
                        _buildSubscriptionCard(),
                        const SizedBox(height: 20),
                        _buildSettingsTile(),
                        const SizedBox(height: 20),
                        _buildLogoutButton(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ─── Blur Overlay ──────────────────────────────────────────────────
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: GestureDetector(
                  onTap: () => Get.to(() => const SubscriberChooseProgramScreen()),
                  child: Container(
                    color: Colors.black.withOpacity(0.01),
                  ),
                ),
              ),
            ),

            // ─── Unblurred Header (AppBar + Profile Card) ──────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color(0xFFF7F8FC),
                child: Column(
                  children: [
                    _buildAppBar(),
                    const Divider(color: Color(0xFFD1D1D1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          _buildProfileInfoCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Color(0xFF1E293B), size: 28),
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
          const SizedBox(width: 28), // balance
        ],
      ),
    );
  }

  Widget _buildProfileInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFFE9E9E9), width: 1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=kathy',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kathy Onana',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      'moses@abc.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF686868),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 130,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A63E),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/crown.png',
                            width: 12,
                            height: 12,
                          ),
                          const Text(
                            ' IMMERSION++',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Color(0xFFDEDEDE)),
          const SizedBox(height: 12),
          _buildInfoRow('User ID', 'BZ-20240-1234'),
          const SizedBox(height: 12),
          Divider(color: Color(0xFFDEDEDE)),
          const SizedBox(height: 12),
          _buildInfoRow('Member Since', 'January, 2026'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF686868),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(
          'Lessons\nCompleted',
          '45',
          'assets/images/medal-star.png',
          const Color(0xFF5456E7),
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          'Daily\nStreaks',
          '15 days',
          'assets/images/daily_streak.png',
          const Color(0xFF5456E7),
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          'Total\nProgress',
          '68%',
          'assets/images/symbols_crown.png',
          const Color(0xFF5456E7),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, String image, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFFEAEAEA)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            children: [
              Image.asset(image, width: 26, height: 26),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF49454F),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBreakdown() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressBar('Voice Recording', 0.65, const Color(0xFF00C853)),
          const SizedBox(height: 16),
          _buildProgressBar('Video Recording', 0.65, const Color(0xFFFB8C00)),
          const SizedBox(height: 16),
          _buildProgressBar('Vocabulary', 0.65, const Color(0xFFFFD600)),
          const SizedBox(height: 16),
          _buildProgressBar('Reading', 0.65, const Color(0xFF4A82E7)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, double progress, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF878787),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '23/35%',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF878787),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey[100],
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(
          'BZ-WALLET',
          'assets/images/wallet.png',
          const Color(0xFFD2D3F6),
        ),
        _buildActionItem(
          'BZ-Daily Mission',
          'assets/images/note.png',
          const Color(0xFFCBF2EF),
        ),
        _buildActionItem(
          'BZ-Library',
          'assets/images/bz_library.png',
          const Color(0xFFF5E3EE),
        ),
        _buildActionItem(
          'BZPad',
          'assets/images/pad.png',
          const Color(0xFFAAFFB4),
        ),
      ],
    );
  }

  Widget _buildActionItem(String label, String image, Color bgColor) {
    return Column(
      children: [
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(image, width: 24, height: 24),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subscription',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'IMMERSION++ - Active',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF878787),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/glyphs-poly_crown-1.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Manage Subscription',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.settings_outlined, color: Color(0xFF1E293B), size: 24),
          SizedBox(width: 16),
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE00000)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.logout, color: Color(0xFFE00000)),
        label: const Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFFE00000),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
