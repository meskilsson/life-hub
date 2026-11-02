import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:life_hub/data/models/sleep_hours_entry.dart';

const apiUrl = 'http://localhost:5209/api/HourEntries';

Future<List<SleepHoursEntry>> getSleepHours() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode != 200) {
    throw Exception('Kunde inte hämta sömndata: ${response.statusCode}');
  }

  final jsonList = jsonDecode(response.body) as List<dynamic>;

  return jsonList.map((item) {
    return SleepHoursEntry.fromJson(item as Map<String, dynamic>);
  }).toList();
}

Future<SleepHoursEntry> createSleepHours({
  required double sleepHours,
  required DateTime recordedAt,
}) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'hours': sleepHours,
      'recordedAt': recordedAt.toUtc().toIso8601String(),
    }),
  );
  if (response.statusCode != 201) {
    throw Exception('Kunde inte skapa sömndata: ${response.statusCode}');
  }

  return SleepHoursEntry.fromJson(
    jsonDecode(response.body) as Map<String, dynamic>,
  );
}

Future<void> deleteSleepHours({required int id}) async {
  final response = await http.delete(
    Uri.parse('$apiUrl/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 204) {
    throw Exception('Kunde inte radera sömndata: ${response.statusCode}');
  }
}
