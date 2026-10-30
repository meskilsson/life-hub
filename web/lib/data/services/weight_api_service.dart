import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:life_hub/data/models/weight_entry.dart';

const apiUrl = 'http://localhost:5209/api/WeightEntries';

Future<List<WeightEntry>> getWeight() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode != 200) {
    throw Exception('Kunde inte hämta vikter: ${response.statusCode}');
  }

  final jsonList = jsonDecode(response.body) as List<dynamic>;

  return jsonList.map((item) {
    return WeightEntry.fromJson(item as Map<String, dynamic>);
  }).toList();
}

Future<WeightEntry> createWeight({
  required double weightKg,
  required DateTime recordedAt,
}) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'weightKg': weightKg,
      'recordedAt': recordedAt.toUtc().toIso8601String(),
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Kunde inte skapa vikt: ${response.statusCode}');
  }

  return WeightEntry.fromJson(
    jsonDecode(response.body) as Map<String, dynamic>,
  );
}

Future<void> deleteWeight({required int id}) async {
  final response = await http.delete(
    Uri.parse('$apiUrl/$id'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode != 204) {
    throw Exception('Kunde inte radera vikt: ${response.statusCode}');
  }
}
