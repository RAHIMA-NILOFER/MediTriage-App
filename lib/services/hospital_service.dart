import 'dart:convert';
import 'package:http/http.dart' as http;

class HospitalService {
  static Future<List<Map<String, dynamic>>> fetchGovernmentHospitals(
      double lat, double lon) async {
    final query = '''
[out:json];
(
  node["amenity"="hospital"](around:8000,$lat,$lon);
  way["amenity"="hospital"](around:8000,$lat,$lon);
);
out center tags;
''';

    final res = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: {'data': query},
    );

    final data = json.decode(res.body);
    final List<Map<String, dynamic>> hospitals = [];

    for (var e in data['elements']) {
      final tags = e['tags'] ?? {};
      final name = (tags['name'] ?? '').toString().toLowerCase();

      // ✅ GOVERNMENT KEYWORD FILTER
      final isGovernment = name.contains('government') ||
          name.contains('govt') ||
          name.contains('district') ||
          name.contains('general hospital') ||
          name.contains('medical college') ||
          name.contains('esi') ||
          name.contains('primary health') ||
          name.contains('phc') ||
          name.contains('chc');

      if (!isGovernment) continue;

      final latVal = e['lat'] ?? e['center']?['lat'];
      final lonVal = e['lon'] ?? e['center']?['lon'];

      if (latVal == null || lonVal == null) continue;

      hospitals.add({
        'name': tags['name'],
        'lat': latVal,
        'lon': lonVal,
      });
    }

    return hospitals;
  }
}
