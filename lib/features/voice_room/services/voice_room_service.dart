import '../../../core/api/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../models/voice_room_model.dart';

class LearnerVoiceRoomService {
  final ApiClient _api = ApiClient();

  Future<LearnerVoiceRoomPage> getRooms({
    required int page,
    required int limit,
    String search = '',
  }) async {
    final query = <String, dynamic>{
      'status': 'active',
      'page': page,
      'limit': limit,
      if (search.trim().isNotEmpty) 'search': search.trim(),
    };

    final result = await _api.get<Map<String, dynamic>>(
      endpoint: ApiConstants.voiceRoom.rooms,
      queryParameters: query,
      fromJsonT: (json) => Map<String, dynamic>.from(json as Map),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => LearnerVoiceRoomPage.fromJson(success.data, success.meta),
    );
  }

  Future<VoiceRoomCreateEligibility> getCreateEligibility() async {
    final result = await _api.get<VoiceRoomCreateEligibility>(
      endpoint: ApiConstants.voiceRoom.createEligibility,
      fromJsonT: (json) => VoiceRoomCreateEligibility.fromJson(
        Map<String, dynamic>.from(json as Map),
      ),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<LearnerVoiceRoom> createRoom({
    required String name,
    required String privacy,
    required int maxParticipants,
  }) async {
    final result = await _api.post<LearnerVoiceRoom>(
      endpoint: ApiConstants.voiceRoom.rooms,
      data: {
        'name': name.trim(),
        'privacy': privacy.toLowerCase(),
        'maxParticipants': maxParticipants,
      },
      fromJsonT: (json) {
        final data = Map<String, dynamic>.from(json as Map);
        return LearnerVoiceRoom.fromJson(
          Map<String, dynamic>.from(data['room'] as Map? ?? const {}),
        );
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<LearnerVoiceRoom> getRoom(String roomId) async {
    final result = await _api.get<LearnerVoiceRoom>(
      endpoint: ApiConstants.voiceRoom.room(roomId),
      fromJsonT: (json) {
        final data = Map<String, dynamic>.from(json as Map);
        return LearnerVoiceRoom.fromJson(
          Map<String, dynamic>.from(data['room'] as Map? ?? const {}),
        );
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<LearnerVoiceRoom> joinRoom(String roomId) async {
    final result = await _api.post<LearnerVoiceRoom>(
      endpoint: ApiConstants.voiceRoom.join(roomId),
      data: const {},
      fromJsonT: (json) {
        final data = Map<String, dynamic>.from(json as Map);
        return LearnerVoiceRoom.fromJson(
          Map<String, dynamic>.from(data['room'] as Map? ?? const {}),
        );
      },
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (success) => success.data,
    );
  }

  Future<void> leaveRoom(String roomId) async {
    final result = await _api.post<void>(
      endpoint: ApiConstants.voiceRoom.leave(roomId),
      data: const {},
      fromJsonT: (_) {},
    );
    result.fold((failure) => throw Exception(failure.message), (_) {});
  }
}
