class SleepHoursEntry {
  final int id;
  final double sleepHours;
  final DateTime recordedAt;

  SleepHoursEntry({
    required this.id,
    required this.sleepHours,
    required this.recordedAt,
  });

  factory SleepHoursEntry.fromJson(Map<String, dynamic> json) {
    return SleepHoursEntry(
      id: json['id'] as int,
      sleepHours: (json['hours'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );
  }
}
