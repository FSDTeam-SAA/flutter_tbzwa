import 'package:flutter/material.dart';
import 'package:flutter_tbzwa/core/constants/assest_const.dart';
import 'package:flutter_tbzwa/features/community/models/community_post_model.dart';
import 'package:flutter_tbzwa/features/community/screens/create_post_screen.dart';
import 'package:flutter_tbzwa/features/community/services/community_api_service.dart';
import 'package:get/get.dart';
import '../../subcribers_flow/subscriber_menu_drawer.dart';
import 'community_messages_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final CommunityApiService _communityApiService = CommunityApiService();
  String selectedFilter = 'Recent';
  String _searchQuery = '';
  List<CommunityPost> _posts = const [];
  String? _errorMessage;
  bool _isLoading = true;
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _communityApiService.getCommunityFeed(
        filter: _apiFilter(selectedFilter),
      );
      if (!mounted) return;
      setState(() {
        _isLocked = result.isLocked;
        _errorMessage = result.isLocked ? result.message : null;
        _posts = result.posts;
      });
    } catch (error) {
      if (!mounted) return;
      setState(
        () => _errorMessage = error.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<CommunityPost> get _visiblePosts {
    if (_searchQuery.isEmpty) return _posts;
    return _posts
        .where(
          (post) =>
              post.content.toLowerCase().contains(_searchQuery) ||
              post.authorName.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FC),
      drawer: const SubscriberMenuDrawer(),
      body: SafeArea(
        child: Column(
          children: [
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
                  _buildHeaders(),
                ],
              ),
            ),

            Divider(color: Color(0xFFD1D1D1)),

            _buildHeader(),
            _buildFilters(),
            Expanded(child: _buildPostList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                onChanged: (value) =>
                    setState(() => _searchQuery = value.trim().toLowerCase()),
                decoration: const InputDecoration(
                  hintText: 'Search notes...',
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF94A3B8),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () async {
              final created = await Get.to(() => CreatePostScreen());
              if (created == true) await _loadPosts();
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFFFFFF),
              ),
              child: const Icon(Icons.edit_outlined, color: Color(0xFF1E293B)),
            ),
          ),

          SizedBox(width: 12),

          GestureDetector(
            onTap: () => Get.to(() => const CommunityMessagesScreen()),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFFFFFF),
              ),
              child: const Icon(Icons.chat, color: Color(0xFF1E293B)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaders() {
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
          const SizedBox(width: 24), // balance spacer
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['Recent', 'Image', 'Voice', 'Video'];
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = selectedFilter == filters[index];
          return GestureDetector(
            onTap: () async {
              setState(() => selectedFilter = filters[index]);
              await _loadPosts();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF22A892)
                    : const Color(0xFFE3E7EE),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
              if (!_isLocked)
                TextButton(
                  onPressed: _loadPosts,
                  child: const Text('Try again'),
                ),
            ],
          ),
        ),
      );
    }

    final posts = _visiblePosts;
    if (posts.isEmpty) {
      return const Center(
        child: Text(
          'No posts found.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ...posts.map((post) {
            final media = post.primaryMedia;
            return _buildPostCard(
              name: post.authorName,
              avatarUrl: post.authorImageUrl,
              time: post.timeAgo,
              content: post.content,
              type: media?.uiType,
              mediaUrl: media?.url,
              duration: media?.uiType == 'voice' ? '0:00' : null,
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPostCard({
    required String name,
    required String time,
    required String content,
    String? avatarUrl,
    String? type,
    String? mediaUrl,
    String? duration,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: avatarUrl?.isNotEmpty == true
                        ? NetworkImage(avatarUrl!)
                        : AssetImage(AssetsConstants.images.profileImage),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.more_horiz, color: Color(0xFF94A3B8)),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 12),
          if (type == 'image' || type == 'video')
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    mediaUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: double.infinity,
                      height: 200,
                      color: const Color(0xFFCFFEF5),
                      child: Icon(
                        type == 'video'
                            ? Icons.videocam_rounded
                            : Icons.image_outlined,
                        color: const Color(0xFF2FBDA3),
                        size: 50,
                      ),
                    ),
                  ),
                ),
                if (type == 'video')
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2FBDA3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
              ],
            ),
          if (type == 'voice')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFCFFEF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2FBDA3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    duration ?? '0:00',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInteraction(Icons.thumb_up_alt_outlined, 'Like'),
              _buildInteraction(Icons.chat_bubble_outline_rounded, 'Comment'),
              _buildInteraction(Icons.share_outlined, 'Share'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteraction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF94A3B8)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _apiFilter(String filter) {
    switch (filter) {
      case 'Image':
        return 'image';
      case 'Voice':
        return 'voice';
      case 'Video':
        return 'video';
      default:
        return 'recent';
    }
  }
}
