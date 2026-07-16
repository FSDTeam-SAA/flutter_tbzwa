import '../../../core/constants/api_constants.dart';

class CommunityPost {
  final String id;
  final String authorName;
  final String? authorImageUrl;
  final String content;
  final List<CommunityPostMedia> mediaFiles;
  final DateTime createdAt;

  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.content,
    required this.mediaFiles,
    required this.createdAt,
  });

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    final user = json['userId'] as Map?;
    final profileImage = user?['profileImage'] as Map?;

    return CommunityPost(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      authorName: (user?['fullName'] ?? 'TalkBZ User').toString(),
      authorImageUrl: _absoluteUrl(profileImage?['url']?.toString()),
      content: (json['content'] ?? '').toString(),
      mediaFiles: (json['mediaFiles'] as List? ?? const [])
          .map(
            (item) => CommunityPostMedia.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
      createdAt:
          DateTime.tryParse((json['createdAt'] ?? '').toString())?.toLocal() ??
          DateTime.now(),
    );
  }

  CommunityPostMedia? get primaryMedia =>
      mediaFiles.isEmpty ? null : mediaFiles.first;

  String get timeAgo {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} minutes ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
}

class CommunityPostMedia {
  final String url;
  final String type;

  const CommunityPostMedia({required this.url, required this.type});

  factory CommunityPostMedia.fromJson(Map<String, dynamic> json) {
    return CommunityPostMedia(
      url: _absoluteUrl((json['url'] ?? '').toString()) ?? '',
      type: (json['type'] ?? '').toString(),
    );
  }

  String get uiType => type == 'audio' ? 'voice' : type;
}

String? _absoluteUrl(String? url) {
  if (url == null || url.isEmpty) return null;
  if (url.startsWith('/')) return '${ApiConstants.baseDomain}$url';
  return url;
}
