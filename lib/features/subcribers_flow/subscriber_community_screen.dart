import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'subscriber_choose_program_screen.dart';

class SubscriberCommunityScreen extends StatefulWidget {
  const SubscriberCommunityScreen({super.key});

  @override
  State<SubscriberCommunityScreen> createState() =>
      _SubscriberCommunityScreenState();
}

class _SubscriberCommunityScreenState extends State<SubscriberCommunityScreen> {
  int _selectedTab = 0; // 0 = Friends, 1 = Voice, 2 = Video room
  bool _translationEnabled = false;

  final List<String> _tabs = ['Friends', 'Voice', 'Live'];

  final Set<String> _acceptedFriends = {};

  // Sample data
  final List<Map<String, String>> _friendRequests = [
    {
      'name': 'Anna Hustler',
      'lang': 'French - Learning English',
      'mutual': '3 mutual friends',
    },
    {
      'name': 'Anna Hustler',
      'lang': 'French - Learning English',
      'mutual': '3 mutual friends',
    },
    {
      'name': 'Anna Hustler',
      'lang': 'French - Learning English',
      'mutual': '3 mutual friends',
    },
  ];

  final List<Map<String, String>> _onlineUsers = [
    {
      'name': 'Anna Hustler',
      'langs': 'Fra — Eng',
      'location': 'Guildford, Australia',
    },
    {
      'name': 'Anna Hustler',
      'langs': 'Fra — Eng',
      'location': 'Guildford, Australia',
    },
    {
      'name': 'Anna Hustler',
      'langs': 'Fra — Eng',
      'location': 'Guildford, Australia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      body: SafeArea(
        child: Stack(
          children: [
            // ─── Main Content ──────────────────────────────────────────
            Column(
              children: [
                _buildHeader(),
                _buildTabBar(),
                Expanded(
                  child: _selectedTab == 0
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              _buildFriendRequestsSection(),
                              const SizedBox(height: 28),
                              _buildOnlineNowSection(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                      : _selectedTab == 1
                          ? _buildVoiceTab()
                          : _buildLiveTab(),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Color(0xFF1E293B), size: 24),
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
          const SizedBox(width: 24), // balance spacer
        ],
      ),
    );
  }

  // ─── Voice Tab ───────────────────────────────────────────────────────────────

  Widget _buildVoiceTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildPremiumBanner(),
          const SizedBox(height: 8),
          _buildVoiceRoomCard(
            title: 'English Corner',
            hostName: 'David Kim',
            hostSubtitle: 'Daily Conversation Practice',
            language: 'English',
            count: '12/20',
            isPro: false,
          ),
          _buildVoiceRoomCard(
            title: 'French Talks',
            hostName: 'David Kim',
            hostSubtitle: 'Daily Conversation Practice',
            language: 'English',
            count: '12/20',
            isPro: true,
          ),

          //const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00A63E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Change radius here
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_alt, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Create Voice Rooms',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF655EFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'IMMERSION++ Exclusive',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Update to access premium voice rooms and unlimited hosting',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white70),
              foregroundColor: Color(0xFF655EFF),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              'Upgrade Now',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceRoomCard({
    required String title,
    required String hostName,
    required String hostSubtitle,
    required String language,
    required String count,
    required bool isPro,
  }) {
    // Participant avatar URLs & mic states (active, active, muted)
    final List<String> avatarUrls = [
      'https://i.pravatar.cc/150?u=p1',
      'https://i.pravatar.cc/150?u=p2',
      'https://i.pravatar.cc/150?u=p3',
    ];
    final List<bool> isMuted = [false, false, true];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // Room title + PRO badge
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isPro)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFAE00), Color(0xFFDB9600)],
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/crown.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'PRO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          // Host info
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?u=david',
                ),
                backgroundColor: const Color(0xFFE8EAF0),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hostName,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    hostSubtitle,
                    style: const TextStyle(
                      color: Color(0xFF8493AC),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Participants avatars
          Row(
            children: [
              // Stacked avatars with mic indicators
              SizedBox(
                height: 62,
                width: 52.0 * avatarUrls.length + 50,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: List.generate(avatarUrls.length, (i) {
                    return Positioned(
                      left: i * 60.0,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(avatarUrls[i]),
                            backgroundColor: const Color(0xFFE8EAF0),
                          ),
                          Positioned(
                            right: -4,
                            bottom: -4,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isMuted[i]
                                    ? const Color(0xFF94A3B8)
                                    : const Color(0xFF22C55E),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                isMuted[i] ? Icons.mic_off : Icons.mic,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 10),
              // +9 overflow
              // Container(
              //   width: 48,
              //   height: 48,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //         color: const Color(0xFF4F5CD1), width: 1.5),
              //   ),
              //   alignment: Alignment.center,
              //   child: const Text('+9',
              //       style: TextStyle(
              //           color: Color(0xFF4F5CD1),
              //           fontWeight: FontWeight.bold,
              //           fontSize: 13)),
              // ),
            ],
          ),
          const SizedBox(height: 14),
          // Bottom row: count + language + join
          Row(
            children: [
              const Icon(
                Icons.people_outline,
                size: 16,
                color: Color(0xFF000000),
              ),
              const SizedBox(width: 4),
              Text(
                count,
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xD7252424)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  language,
                  style: const TextStyle(
                    color: Color(0xFF2C3247),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mic, size: 16, color: Colors.white),
                label: const Text(
                  'Join',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE8EAF0)),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF4A82E7)
                        : const Color(0xFF000000),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFriendRequestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Friend Requests",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              "${_friendRequests.length}",
              style: const TextStyle(
                color: Color(0xFF516080),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(_friendRequests.length, (index) {
          final req = _friendRequests[index];
          return _buildFriendRequestCard(
            name: req['name']!,
            lang: req['lang']!,
            mutual: req['mutual']!,
          );
        }),
      ],
    );
  }

  Widget _buildFriendRequestCard({
    required String name,
    required String lang,
    required String mutual,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFE8EAF0),
            backgroundImage: const NetworkImage(
              'https://i.pravatar.cc/150?u=anna',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lang,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
                Text(
                  mutual,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Accept
              SizedBox(
                height: 34,
                width: 96,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, size: 14, color: Colors.white),
                  label: const Text(
                    "Accept",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Decline
              SizedBox(
                height: 34,
                width: 96,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 14,
                    color: Color(0xFFEF4444),
                  ),
                  label: const Text(
                    "Decline",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFEF4444)),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineNowSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Online Now",
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${_onlineUsers.length} online",
                style: const TextStyle(
                  color: Color(0xFF16A34A),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(_onlineUsers.length, (index) {
          final user = _onlineUsers[index];
          return _buildOnlineUserCard(
            name: user['name']!,
            langs: user['langs']!,
            location: user['location']!,
          );
        }),
      ],
    );
  }

  Widget _buildOnlineUserCard({
    required String name,
    required String langs,
    required String location,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFE8EAF0),
                backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/150?u=anna',
                ),
              ),
              Positioned(
                right: 0,
                bottom: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  langs,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "●Active now",
                      style: TextStyle(
                        color: Color(0xFF22C55E),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF4F5CD1),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.waving_hand_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Live Tab ────────────────────────────────────────────────────────────────

  Widget _buildLiveTab() {
    final List<Map<String, String>> liveStreams = [
      {
        'title': 'Japanese Culture Live',
        'host': 'Yomi Yamamoto',
        'thumbnail':
            'https://images.unsplash.com/photo-1536098561742-ca998e48cbcc?auto=format&fit=crop&w=800&q=80',
        'avatar': 'https://i.pravatar.cc/150?u=yomi1',
      },
      {
        'title': 'Spanish Culture Live',
        'host': 'Yomi Yamamoto',
        'thumbnail':
            'https://images.unsplash.com/photo-1504196606672-aef5c9cefc92?auto=format&fit=crop&w=800&q=80',
        'avatar': 'https://i.pravatar.cc/150?u=yomi2',
      },
      {
        'title': 'French Culture Live',
        'host': 'Yomi Yamamoto',
        'thumbnail':
            'https://images.unsplash.com/photo-1499856871958-5b9627545d1a?auto=format&fit=crop&w=800&q=80',
        'avatar': 'https://i.pravatar.cc/150?u=yomi3',
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: liveStreams.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final stream = liveStreams[index];
        return _buildLiveCard(
          title: stream['title']!,
          hostName: stream['host']!,
          thumbnailUrl: stream['thumbnail']!,
          avatarUrl: stream['avatar']!,
        );
      },
    );
  }

  Widget _buildLiveCard({
    required String title,
    required String hostName,
    required String thumbnailUrl,
    required String avatarUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              thumbnailUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: const Color(0xFFE8EAF0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                );
              },
            ),
          ),

          // Title row
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 4, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color(0xFF1E293B),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),

          // Host row
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFE8EAF0),
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hostName,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                // Gift button
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.card_giftcard_outlined,
                    size: 16,
                    color: Color(0xFF1E293B),
                  ),
                  label: const Text(
                    'Gift',
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
