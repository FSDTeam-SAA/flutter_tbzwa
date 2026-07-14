import '../../../core/api/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../models/instructor_message_model.dart';

class InstructorMessagesService {
  final ApiClient _api = ApiClient();

  Future<InstructorConversationPage> getConversations({
    required int page,
    required int limit,
    required String search,
  }) async {
    final query = <String, dynamic>{
      'page': page,
      'limit': limit,
      'includeGroups': true,
      if (search.trim().isNotEmpty) 'search': search.trim(),
    };

    final result = await _api.get<Map<String, dynamic>>(
      endpoint: ApiConstants.chat.getMyConversations,
      queryParameters: query,
      fromJsonT: (json) => Map<String, dynamic>.from(json as Map),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) =>
          InstructorConversationPage.fromJson(success.data, success.meta),
    );
  }

  Future<InstructorConversation> getConversation(String conversationId) async {
    final result = await _api.get<InstructorConversation>(
      endpoint: ApiConstants.chat.getConversationByID(conversationId),
      fromJsonT: (json) {
        final data = Map<String, dynamic>.from(json as Map);
        return InstructorConversation.fromJson(
          Map<String, dynamic>.from(data['conversation'] as Map? ?? const {}),
        );
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<InstructorMessagePage> getMessages({
    required InstructorConversation conversation,
    required int page,
    required int limit,
    required String currentUserId,
  }) async {
    final result = await _api.get<Map<String, dynamic>>(
      endpoint: conversation.isGroup
          ? ApiConstants.group.discussion(conversation.id)
          : ApiConstants.chat.getChatMessages(conversation.id),
      queryParameters: {'page': page, 'limit': limit},
      fromJsonT: (json) => Map<String, dynamic>.from(json as Map),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => InstructorMessagePage.fromJson(
        success.data,
        success.meta,
        currentUserId,
      ),
    );
  }

  Future<InstructorChatMessage> sendTextMessage({
    required InstructorConversation conversation,
    required String content,
    required String currentUserId,
  }) async {
    final result = await _api.post<InstructorChatMessage>(
      endpoint: conversation.isGroup
          ? ApiConstants.group.discussion(conversation.id)
          : ApiConstants.chat.sendDirectMessage(conversation.id),
      data: conversation.isGroup
          ? {'content': content.trim()}
          : {'conversationId': conversation.id, 'content': content.trim()},
      fromJsonT: (json) {
        final data = Map<String, dynamic>.from(json as Map);
        return InstructorChatMessage.fromJson(
          Map<String, dynamic>.from(data['message'] as Map? ?? const {}),
          currentUserId,
        );
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<void> markConversationRead(String conversationId) async {
    final result = await _api.patch<void>(
      endpoint: ApiConstants.chat.markConversationRead(conversationId),
      fromJsonT: (_) {},
    );
    result.fold((failure) => throw Exception(failure.message), (_) {});
  }
}
