import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/voice_room_controller.dart';
import '../models/voice_room_model.dart';

class VoiceRoomDetailsScreen extends StatefulWidget {
  final LearnerVoiceRoom room;

  const VoiceRoomDetailsScreen({super.key, required this.room});

  @override
  State<VoiceRoomDetailsScreen> createState() => _VoiceRoomDetailsScreenState();
}

class _VoiceRoomDetailsScreenState extends State<VoiceRoomDetailsScreen> {
  late final LearnerVoiceRoomController controller;
  bool _leftRoom = false;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<LearnerVoiceRoomController>()
        ? Get.find<LearnerVoiceRoomController>()
        : Get.put(LearnerVoiceRoomController());
  }

  @override
  void dispose() {
    if (!_leftRoom) {
      unawaited(controller.leaveRoom(widget.room.id));
    }
    super.dispose();
  }

  Future<void> _leaveAndClose() async {
    if (_leftRoom) return;
    _leftRoom = true;
    await controller.leaveRoom(widget.room.id);
    if (mounted) Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final participants = widget.room.participants;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 58,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: _leaveAndClose,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF1E293B),
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 56),
                    child: Text(
                      widget.room.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshRooms,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
                  children: [
                    _buildRoomSummary(),
                    const SizedBox(height: 24),
                    const Text(
                      'Listening now',
                      style: TextStyle(
                        color: Color(0xFF374151),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (participants.isEmpty)
                      _buildEmptyListeners()
                    else
                      _buildParticipantGrid(participants),
                    const SizedBox(height: 24),
                    _buildListenerModePanel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildAvatar(
                widget.room.hostAvatarUrl,
                radius: 26,
                fallbackText: widget.room.hostInitial,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.room.hostName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.room.groupName.trim().isEmpty
                          ? 'Room host'
                          : widget.room.groupName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _buildChip(widget.room.statusLabel, const Color(0xFF26A69A)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildMetric(
                Icons.people_outline_rounded,
                widget.room.countLabel,
              ),
              _buildMetric(
                widget.room.isPublic
                    ? Icons.public_rounded
                    : Icons.lock_outline_rounded,
                widget.room.privacyLabel,
              ),
              if (widget.room.hostCountryBadge.isNotEmpty)
                _buildMetric(
                  Icons.location_on_outlined,
                  widget.room.hostCountryBadge,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantGrid(List<LearnerVoiceRoomParticipant> participants) {
    return GridView.builder(
      itemCount: participants.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final participant = participants[index];
        final initial = participant.name.trim().isEmpty
            ? 'L'
            : participant.name.trim()[0].toUpperCase();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildAvatar(
                  participant.avatarUrl,
                  radius: 26,
                  fallbackText: initial,
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: participant.isOnStage
                          ? const Color(0xFF26A69A)
                          : const Color(0xFF94A3B8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(
                      participant.isOnStage
                          ? Icons.mic_rounded
                          : Icons.hearing_rounded,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              participant.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyListeners() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Text(
          'No listeners are in this room yet.',
          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
      ),
    );
  }

  Widget _buildListenerModePanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFE6F7F4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.hearing_rounded, color: Color(0xFF168A7E)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listener mode',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'You are in this room as a listener.',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildMetric(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF64748B)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    String? url, {
    required double radius,
    required String fallbackText,
  }) {
    final size = radius * 2;
    final fallback = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFE8EAF0),
        shape: BoxShape.circle,
      ),
      child: Text(
        fallbackText,
        style: TextStyle(
          color: const Color(0xFF64748B),
          fontSize: radius * 0.72,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    if (url == null || url.trim().isEmpty) {
      return fallback;
    }

    return ClipOval(
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => fallback,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return fallback;
        },
      ),
    );
  }
}
