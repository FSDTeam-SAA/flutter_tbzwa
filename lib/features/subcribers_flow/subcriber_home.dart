import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'subscriber_choose_program_screen.dart';


class SubscriberHome extends StatelessWidget {
  const SubscriberHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Stack(
        children: [
          // ─── Main Content (Blurred) ──────────────────────────────────────────
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildTodayGoalCard(),
                      const SizedBox(height: 30),
                      _buildSectionHeader("Daily Missions", 'yes', onSeeAll: () {}),
                      const SizedBox(height: 16),
                      _buildDailyMissionsGrid(),
                      const SizedBox(height: 30),
                      const Text(
                        "Next Live Class",
                        style: TextStyle(
                          color: Color(0xFF263238),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildNextLiveClassCard(),
                      const SizedBox(height: 30),
                      _buildSectionHeader("Quick Access", 'no', onSeeAll: () {}),
                      const SizedBox(height: 16),
                      _buildQuickAccessList(),
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
                  color: Colors.black.withOpacity(0.01), // Needs a color to capture taps
                ),
              ),
            ),
          ),

          // ─── Unblurred Header ─────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour,",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Kathy Onana",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "PRO",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none_rounded, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF5151EF),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(30),
        //   bottomRight: Radius.circular(30),
        // ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      child: Column(
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bonjour,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Kathy Onana",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "PRO",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_none_rounded, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF6666EE),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xFF8585F1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined, size: 20, color: Color(0xFFFFFFFF)),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TalkCoin Balance",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          "\$55.00",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4F5CD1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 0,
                    ).copyWith(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                    child: const Text("Give interview", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: const Text(
                      "ID : BZ - 284910",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayGoalCard() {
    return Container(
      padding: const EdgeInsets.all(1.5), // Border thickness
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFAFAFF),
            Color(0xFF7E7EFB),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today’s Goal",
                  style: TextStyle(
                    color: Color(0xFF000055),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "72%",
                  style: TextStyle(
                    color: Color(0xFF000055),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Keep up the streak, Kathy!",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                ),
                Text(
                  "Completed",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 4),

            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.72,
                minHeight: 10,
                backgroundColor: Color(0xFFF0F2F5),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4880E6)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.trending_up, size: 14, color: Color(0xFF006B5B)),
                      SizedBox(width: 4),
                      Text(
                        "On Track",
                        style: TextStyle(color: Color(0xFF006B5B), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "3 tasks remaining",
                  style: TextStyle(color: Color(0xFF191C1F), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String text, {VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF263238),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if(text != 'no')
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            "View all",
            style: TextStyle(color: Color(0xFF4F5CD1), fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyMissionsGrid() {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildMissionCard(
          "Daily Audio",
          "3/3 complete",
          Color(0xFFE2E3F7),
          "assets/images/voice.png",
          const Color(0xFFC5C6F5),
          const Color(0xFF5151EF),
          isDone: true,
        ),
        _buildMissionCard(
          "Daily Video",
          "1/3 in progress",
          Color(0xFFDFF2F4),
          "assets/images/video.png",
          const Color(0xFFBCF1EC),
          const Color(0xFF006B5B),
          isDone: false,
          progress: "1/3",
        ),
        _buildMissionCard(
          "Daily Vocabulary",
          "2 words today",
          Color(0xFFF3EBF3),
          "assets/images/vocabulary.png",
          const Color(0xFFF5DDEA),
          const Color(0xFF7F3858),
          isDone: true,
        ),
        _buildMissionCard(
          "Daily Summary",
          "0/2 reads",
          Color(0xFFFFFFFF),
          "assets/images/summary.png",
          const Color(0xFFDCDCFC),
          const Color(0xFF5151EF),
          isDone: false,
          progress: "0/2",
        ),
      ],
    );
  }

  Widget _buildMissionCard(String title, String status, Color background_Color, String iconPath, Color bgColor, Color iconColor, {bool isDone = false, String? progress, }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background_Color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F2F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(iconPath, width: 24, height: 24, color: iconColor),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF263238), fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isDone ? Icons.check_circle_outline_rounded : Icons.cancel_outlined,
                size: 14,
                color: isDone ? Color(0xFF006B5B) : Color(0xFFFF8800),
              ),
              const SizedBox(width: 4),
              Text(
                status,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNextLiveClassCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F2F5)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFDCDCFC),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              "MS",
              style: TextStyle(color: Color(0xFF000055), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FLUENCY+ P1",
                  style: TextStyle(color: Color(0xFF263238), fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Mr. Samuel • 09:00 AM",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5151EF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 0,
            ),
            child: const Text("Join", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessList() {
    final items = [
      {'label': 'BZPad', 'icon': 'assets/images/bz_pad.png'},
      {'label': 'BZ-WALLET', 'icon': 'assets/images/bzwallet.png'},
      {'label': 'BZ-Library', 'icon': 'assets/images/library.png'},
      {'label': 'BZ-Daily Mission', 'icon': 'assets/images/daily_mission.png'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  width: 85,
                  height: 85,
                  //padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(item['icon']!),
                ),
                const SizedBox(height: 8),
                Text(
                  item['label']!,
                  style: const TextStyle(color: Color(0xFF374151), fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
