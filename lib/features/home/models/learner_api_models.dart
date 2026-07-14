class LearnerProfile {
  final String id;
  final String fullName;
  final String userId;
  final String? profileImageUrl;
  final String level;
  final String plan;
  final int currentStreak;

  const LearnerProfile({
    required this.id,
    required this.fullName,
    required this.userId,
    required this.profileImageUrl,
    required this.level,
    required this.plan,
    required this.currentStreak,
  });

  factory LearnerProfile.fromJson(Map<String, dynamic> json) {
    final subscription = json['subscription'] as Map<String, dynamic>? ?? {};
    final profileImage = json['profileImage'] as Map<String, dynamic>?;
    return LearnerProfile(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      profileImageUrl: profileImage?['url']?.toString(),
      level: (json['level'] ?? 'none').toString(),
      plan: (subscription['plan'] ?? 'none').toString(),
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
    );
  }
}

class DailyMissionSummary {
  final int overallProgress;
  final int completedCount;
  final int totalCount;
  final Map<String, MissionProgress> missions;

  const DailyMissionSummary({
    required this.overallProgress,
    required this.completedCount,
    required this.totalCount,
    required this.missions,
  });

  factory DailyMissionSummary.fromJson(Map<String, dynamic> json) {
    final values = <String, MissionProgress>{};
    for (final item in (json['missions'] as List? ?? const [])) {
      final map = Map<String, dynamic>.from(item as Map);
      final key = map['key'].toString();
      values[key] = MissionProgress.fromJson(
        map,
        minimumTarget: key == 'voiceRecordings' || key == 'immersion'
            ? 3
            : null,
      );
    }
    return DailyMissionSummary(
      overallProgress: (json['overallProgress'] as num?)?.toInt() ?? 0,
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      missions: values,
    );
  }
}

class MissionProgress {
  final int completed;
  final int target;

  const MissionProgress({required this.completed, required this.target});

  factory MissionProgress.fromJson(
    Map<String, dynamic> json, {
    int? minimumTarget,
  }) {
    final parsedTarget = json['target'] is bool
        ? 1
        : (json['target'] as num?)?.toInt() ?? 1;
    return MissionProgress(
      completed: json['completed'] is bool
          ? (json['completed'] == true ? 1 : 0)
          : (json['completed'] as num?)?.toInt() ?? 0,
      target: minimumTarget != null && parsedTarget < minimumTarget
          ? minimumTarget
          : parsedTarget,
    );
  }
}

class WeeklyProgress {
  final int average;
  final List<int> scores;
  final List<WeeklyDayProgress> days;

  const WeeklyProgress({
    required this.average,
    required this.scores,
    required this.days,
  });

  factory WeeklyProgress.fromJson(Map<String, dynamic> json) {
    final days = (json['consistency'] as List? ?? const [])
        .map(
          (item) => WeeklyDayProgress.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
    return WeeklyProgress(
      average: (json['weeklyAverage'] as num?)?.toInt() ?? 0,
      scores: days.map((day) => day.score).toList(),
      days: days,
    );
  }
}

class WeeklyDayProgress {
  final DateTime date;
  final int score;
  final bool hasActivity;

  const WeeklyDayProgress({
    required this.date,
    required this.score,
    required this.hasActivity,
  });

  factory WeeklyDayProgress.fromJson(Map<String, dynamic> json) {
    return WeeklyDayProgress(
      date:
          DateTime.tryParse((json['date'] ?? '').toString())?.toLocal() ??
          DateTime.now(),
      score: ((json['score'] as num?)?.toInt() ?? 0).clamp(0, 100),
      hasActivity: json['hasActivity'] == true,
    );
  }

  String get dayLabel {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return labels[date.weekday - 1];
  }

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

class VocabularyWord {
  final String id;
  final String word;
  final String definition;
  final List<String> exampleSentences;
  final DateTime? missionDate;
  final DateTime? createdAt;

  const VocabularyWord({
    required this.id,
    required this.word,
    required this.definition,
    required this.exampleSentences,
    required this.missionDate,
    required this.createdAt,
  });

  factory VocabularyWord.fromJson(Map<String, dynamic> json) {
    return VocabularyWord(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      word: (json['word'] ?? '').toString(),
      definition: (json['definition'] ?? '').toString(),
      exampleSentences: (json['exampleSentences'] as List? ?? const [])
          .map((item) => item.toString())
          .toList(),
      missionDate: DateTime.tryParse(
        (json['missionDate'] ?? '').toString(),
      )?.toLocal(),
      createdAt: DateTime.tryParse(
        (json['createdAt'] ?? '').toString(),
      )?.toLocal(),
    );
  }
}

class TodayVocabulary {
  final List<VocabularyWord> words;
  final MissionProgress progress;

  const TodayVocabulary({required this.words, required this.progress});

  factory TodayVocabulary.fromJson(Map<String, dynamic> json) {
    return TodayVocabulary(
      words: (json['words'] as List? ?? const [])
          .map(
            (item) =>
                VocabularyWord.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
      progress: MissionProgress.fromJson(
        Map<String, dynamic>.from(json['progress'] as Map? ?? const {}),
        minimumTarget: 2,
      ),
    );
  }
}

class ImmersionLogEntry {
  final String id;
  final String title;
  final String summary;
  final DateTime? missionDate;
  final DateTime? createdAt;

  const ImmersionLogEntry({
    required this.id,
    required this.title,
    required this.summary,
    required this.missionDate,
    required this.createdAt,
  });

  factory ImmersionLogEntry.fromJson(Map<String, dynamic> json) {
    return ImmersionLogEntry(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      summary: (json['summary'] ?? '').toString(),
      missionDate: DateTime.tryParse(
        (json['missionDate'] ?? '').toString(),
      )?.toLocal(),
      createdAt: DateTime.tryParse(
        (json['createdAt'] ?? '').toString(),
      )?.toLocal(),
    );
  }
}

class TodayImmersion {
  final ImmersionLogEntry? log;
  final List<ImmersionLogEntry> logs;
  final MissionProgress progress;
  final bool isComplete;

  const TodayImmersion({
    required this.log,
    required this.logs,
    required this.progress,
    required this.isComplete,
  });

  factory TodayImmersion.fromJson(Map<String, dynamic> json) {
    final rawLog = json['log'];
    final logs = (json['logs'] as List? ?? const [])
        .map(
          (item) => ImmersionLogEntry.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
    return TodayImmersion(
      log: rawLog is Map
          ? ImmersionLogEntry.fromJson(Map<String, dynamic>.from(rawLog))
          : null,
      logs: logs,
      progress: MissionProgress.fromJson(
        Map<String, dynamic>.from(json['missionProgress'] as Map? ?? const {}),
        minimumTarget: 3,
      ),
      isComplete: json['isComplete'] == true,
    );
  }
}

class LiveClassInfo {
  final String id;
  final String title;
  final DateTime scheduledAt;
  final int duration;
  final String status;
  final String description;
  final List<String> objectives;
  final String myRsvp;
  final String instructorName;
  final String? instructorImageUrl;
  final String groupName;

  const LiveClassInfo({
    required this.id,
    required this.title,
    required this.scheduledAt,
    required this.duration,
    required this.status,
    required this.description,
    required this.objectives,
    required this.myRsvp,
    required this.instructorName,
    required this.instructorImageUrl,
    required this.groupName,
  });

  factory LiveClassInfo.fromJson(Map<String, dynamic> json) {
    final instructor = json['instructorId'] as Map<String, dynamic>? ?? {};
    final image = instructor['profileImage'] as Map<String, dynamic>?;
    final group = json['groupId'] as Map<String, dynamic>? ?? {};
    return LiveClassInfo(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      scheduledAt:
          DateTime.tryParse(
            (json['scheduledAt'] ?? '').toString(),
          )?.toLocal() ??
          DateTime.now(),
      duration: (json['duration'] as num?)?.toInt() ?? 60,
      status: (json['status'] ?? 'scheduled').toString(),
      description: (json['description'] ?? '').toString(),
      objectives: (json['objectives'] as List? ?? const [])
          .map((e) => e.toString())
          .toList(),
      myRsvp: (json['myRsvp'] ?? 'no_response').toString(),
      instructorName: (instructor['fullName'] ?? '').toString(),
      instructorImageUrl: image?['url']?.toString(),
      groupName: (group['name'] ?? '').toString(),
    );
  }
}

class LearnerLiveClasses {
  final List<LiveClassInfo> today;
  final List<LiveClassInfo> upcoming;
  final List<LiveClassInfo> past;

  const LearnerLiveClasses({
    required this.today,
    required this.upcoming,
    required this.past,
  });

  factory LearnerLiveClasses.fromJson(Map<String, dynamic> json) {
    List<LiveClassInfo> parse(String key) => (json[key] as List? ?? const [])
        .map(
          (item) =>
              LiveClassInfo.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
    return LearnerLiveClasses(
      today: parse('today'),
      upcoming: parse('upcoming'),
      past: parse('past'),
    );
  }
}
