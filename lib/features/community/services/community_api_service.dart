import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../models/community_post_model.dart';

class CommunityApiService {
  final ApiClient _api = ApiClient();

  Future<CommunityFeedResult> getCommunityFeed({
    String filter = 'recent',
  }) async {
    final result = await _api.get<CommunityFeedResult>(
      endpoint: ApiConstants.post.posts,
      queryParameters: {'filter': filter, 'page': 1, 'limit': 50},
      fromJsonT: (json) =>
          CommunityFeedResult.fromJson(Map<String, dynamic>.from(json as Map)),
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<CommunityPost> createPost({
    required String content,
    File? mediaFile,
  }) async {
    final formData = FormData.fromMap({
      'content': content.trim(),
      if (mediaFile != null)
        'media': await MultipartFile.fromFile(
          mediaFile.path,
          filename: mediaFile.uri.pathSegments.last,
        ),
    });

    final result = await _api.post<CommunityPost>(
      endpoint: ApiConstants.post.posts,
      formData: formData,
      fromJsonT: (json) => CommunityPost.fromJson(
        Map<String, dynamic>.from(json['post'] as Map),
      ),
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }
}

class CommunityFeedResult {
  final bool isLocked;
  final String? message;
  final List<CommunityPost> posts;

  const CommunityFeedResult({
    required this.isLocked,
    required this.message,
    required this.posts,
  });

  factory CommunityFeedResult.fromJson(Map<String, dynamic> json) {
    return CommunityFeedResult(
      isLocked: json['isLocked'] == true,
      message: json['message']?.toString(),
      posts: (json['posts'] as List? ?? const [])
          .map(
            (item) =>
                CommunityPost.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
    );
  }
}
