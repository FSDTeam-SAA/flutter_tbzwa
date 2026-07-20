import '../../../core/constants/api_constants.dart';

class LearnerVoiceRoomPage {
  final List<LearnerVoiceRoom> rooms;
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool canAccessPrivateRooms;
  final String? upgradeMessage;

  const LearnerVoiceRoomPage({
    required this.rooms,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.canAccessPrivateRooms,
    required this.upgradeMessage,
  });

  factory LearnerVoiceRoomPage.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic>? meta,
  ) {
    return LearnerVoiceRoomPage(
      rooms: (json['rooms'] as List? ?? const [])
          .whereType<Object?>()
          .map((item) {
            try {
              return LearnerVoiceRoom.fromJson(
                Map<String, dynamic>.from(item as Map),
              );
            } catch (_) {
              return null;
            }
          })
          .whereType<LearnerVoiceRoom>()
          .where((room) => room.id.isNotEmpty)
          .toList(),
      page: (meta?['page'] as num?)?.toInt() ?? 1,
      limit: (meta?['limit'] as num?)?.toInt() ?? 20,
      total: (meta?['total'] as num?)?.toInt() ?? 0,
      totalPages: (meta?['totalPages'] as num?)?.toInt() ?? 1,
      canAccessPrivateRooms: json['isImmersionPlus'] == true,
      upgradeMessage: json['upgradeMessage']?.toString(),
    );
  }
}

class LearnerVoiceRoom {
  final String id;
  final String name;
  final String privacy;
  final String status;
  final bool isActive;
  final bool isLocked;
  final int participantCount;
  final int maxParticipants;
  final String hostName;
  final String hostUserId;
  final String? hostId;
  final String? hostAvatarUrl;
  final String hostCountry;
  final String groupName;
  final String? groupId;
  final String shareLink;
  final List<LearnerVoiceRoomParticipant> participants;
  final DateTime? createdAt;

  const LearnerVoiceRoom({
    required this.id,
    required this.name,
    required this.privacy,
    required this.status,
    required this.isActive,
    required this.isLocked,
    required this.participantCount,
    required this.maxParticipants,
    required this.hostName,
    required this.hostUserId,
    required this.hostId,
    required this.hostAvatarUrl,
    required this.hostCountry,
    required this.groupName,
    required this.groupId,
    required this.shareLink,
    required this.participants,
    required this.createdAt,
  });

  factory LearnerVoiceRoom.fromJson(Map<String, dynamic> json) {
    final host = json['host'] ?? json['hostId'];
    final hostJson = host is Map ? Map<String, dynamic>.from(host) : null;
    final group = json['group'] ?? json['groupId'];
    final groupJson = group is Map ? Map<String, dynamic>.from(group) : null;
    final parsedParticipants = (json['participants'] as List? ?? const [])
        .whereType<Object?>()
        .map((item) {
          try {
            return LearnerVoiceRoomParticipant.fromJson(
              Map<String, dynamic>.from(item as Map),
            );
          } catch (_) {
            return null;
          }
        })
        .whereType<LearnerVoiceRoomParticipant>()
        .toList();
    final active = json['isActive'] != false;

    return LearnerVoiceRoom(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? 'Voice Room').toString(),
      privacy: (json['privacy'] ?? 'public').toString(),
      status: (json['status'] ?? (active ? 'active' : 'ended')).toString(),
      isActive: active,
      isLocked: json['isLocked'] == true,
      participantCount:
          (json['participantCount'] as num?)?.toInt() ??
          parsedParticipants.length,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 20,
      hostName: (hostJson?['fullName'] ?? 'Host').toString(),
      hostUserId: (hostJson?['userId'] ?? '').toString(),
      hostId: (hostJson?['id'] ?? hostJson?['_id'] ?? host)?.toString(),
      hostAvatarUrl: _absoluteUrl(
        hostJson?['profileImageUrl']?.toString() ??
            _imageUrl(hostJson?['profileImage']),
      ),
      hostCountry: (hostJson?['country'] ?? '').toString(),
      groupName: (groupJson?['name'] ?? '').toString(),
      groupId: (groupJson?['id'] ?? groupJson?['_id'] ?? group)?.toString(),
      shareLink: (json['shareLink'] ?? '').toString(),
      participants: parsedParticipants,
      createdAt: DateTime.tryParse(
        (json['createdAt'] ?? '').toString(),
      )?.toLocal(),
    );
  }

  bool get isPublic => privacy != 'private';

  String get statusLabel => isActive ? 'Live' : 'Ended';

  String get privacyLabel => isPublic ? 'Public' : 'Private';

  String get countLabel => '$participantCount/$maxParticipants';

  String get hostInitial {
    final trimmed = hostName.trim();
    return trimmed.isEmpty ? 'T' : trimmed.substring(0, 1).toUpperCase();
  }

  String get hostCountryBadge => _countryBadge(hostCountry);

  LearnerVoiceRoom copyWith({
    String? status,
    bool? isActive,
    int? participantCount,
    List<LearnerVoiceRoomParticipant>? participants,
  }) {
    return LearnerVoiceRoom(
      id: id,
      name: name,
      privacy: privacy,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      isLocked: isLocked,
      participantCount: participantCount ?? this.participantCount,
      maxParticipants: maxParticipants,
      hostName: hostName,
      hostUserId: hostUserId,
      hostId: hostId,
      hostAvatarUrl: hostAvatarUrl,
      hostCountry: hostCountry,
      groupName: groupName,
      groupId: groupId,
      shareLink: shareLink,
      participants: participants ?? this.participants,
      createdAt: createdAt,
    );
  }
}

class LearnerVoiceRoomParticipant {
  final String userId;
  final String name;
  final String? avatarUrl;
  final String country;
  final bool isOnStage;

  const LearnerVoiceRoomParticipant({
    required this.userId,
    required this.name,
    required this.avatarUrl,
    required this.country,
    required this.isOnStage,
  });

  factory LearnerVoiceRoomParticipant.fromJson(Map<String, dynamic> json) {
    final user = json['userId'];
    final userJson = user is Map ? Map<String, dynamic>.from(user) : null;
    return LearnerVoiceRoomParticipant(
      userId: (userJson?['id'] ?? userJson?['_id'] ?? user ?? '').toString(),
      name: (userJson?['fullName'] ?? 'Listener').toString(),
      avatarUrl: _absoluteUrl(
        userJson?['profileImageUrl']?.toString() ??
            _imageUrl(userJson?['profileImage']),
      ),
      country: (userJson?['country'] ?? '').toString(),
      isOnStage: json['isOnStage'] == true,
    );
  }
}

class VoiceRoomCreateEligibility {
  final bool allowed;
  final String reason;
  final bool upgradeRequired;
  final String requiredPlan;
  final String plan;
  final String subscriptionStatus;
  final DateTime? endDate;
  final bool isLifetime;

  const VoiceRoomCreateEligibility({
    required this.allowed,
    required this.reason,
    required this.upgradeRequired,
    required this.requiredPlan,
    required this.plan,
    required this.subscriptionStatus,
    required this.endDate,
    required this.isLifetime,
  });

  factory VoiceRoomCreateEligibility.fromJson(Map<String, dynamic> json) {
    final source = json['eligibility'] is Map
        ? Map<String, dynamic>.from(json['eligibility'] as Map)
        : json;
    return VoiceRoomCreateEligibility(
      allowed: source['allowed'] == true,
      reason: (source['reason'] ?? '').toString(),
      upgradeRequired: source['upgradeRequired'] != false,
      requiredPlan: (source['requiredPlan'] ?? 'immersion_plus_plus')
          .toString(),
      plan: (source['plan'] ?? 'none').toString(),
      subscriptionStatus: (source['subscriptionStatus'] ?? 'pending')
          .toString(),
      endDate: DateTime.tryParse(
        (source['endDate'] ?? '').toString(),
      )?.toLocal(),
      isLifetime: source['isLifetime'] == true,
    );
  }

  String get displayReason => reason.trim().isEmpty
      ? 'An active subscription is required to create a voice room.'
      : reason.trim();
}

String? _imageUrl(dynamic image) {
  if (image == null) return null;
  if (image is String) return image;
  if (image is Map) {
    return (image['url'] ?? image['secure_url'])?.toString();
  }
  return null;
}

String? _absoluteUrl(String? url) {
  if (url == null || url.trim().isEmpty) return null;
  final value = url.trim();
  if (value.startsWith('/')) return '${ApiConstants.baseDomain}$value';
  final uri = Uri.tryParse(value);
  if (uri == null || !uri.hasScheme) return value;
  if (_isLocalBackendHost(uri.host) && uri.path.isNotEmpty) {
    final base = Uri.parse(ApiConstants.baseDomain);
    return base
        .replace(path: uri.path, query: uri.query.isEmpty ? null : uri.query)
        .toString();
  }
  return value;
}

bool _isLocalBackendHost(String host) {
  if (host == 'localhost' || host == '127.0.0.1') return true;
  if (host.startsWith('10.')) return true;
  if (host.startsWith('192.168.')) return true;
  final parts = host.split('.');
  if (parts.length == 4 && parts.first == '172') {
    final second = int.tryParse(parts[1]);
    return second != null && second >= 16 && second <= 31;
  }
  return false;
}

String _countryBadge(String country) {
  final trimmed = country.trim();
  if (trimmed.isEmpty) return '';
  final upper = trimmed.toUpperCase();
  if (upper.length == 2 && RegExp(r'^[A-Z]{2}$').hasMatch(upper)) {
    const base = 0x1F1E6;
    final first = upper.codeUnitAt(0) - 65 + base;
    final second = upper.codeUnitAt(1) - 65 + base;
    return String.fromCharCodes([first, second]);
  }
  final letters = trimmed
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .map((part) => part.substring(0, 1).toUpperCase())
      .join();
  return letters.length >= 2
      ? letters.substring(0, 2)
      : trimmed.substring(0, 1).toUpperCase();
}
