class WeightEntry {
  final int id;
  final double weightKg;
  final DateTime recordedAt;

  WeightEntry({
    required this.id,
    required this.weightKg,
    required this.recordedAt,
  });

  factory WeightEntry.fromJson(Map<String, dynamic> json) {
    return WeightEntry(
      id: json["id"] as int,
      weightKg: (json['weightKg'] as num).toDouble(),
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );
  }
}
