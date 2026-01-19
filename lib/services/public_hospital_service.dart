import 'package:cloud_firestore/cloud_firestore.dart';

class PublicHospitalService {
  static Future<List<Map<String, dynamic>>> fetchAllGovernmentHospitals() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('hospitals')
        .where('type', isEqualTo: 'government')
        .where('service_type', isEqualTo: 'free')
        .get();

    return snapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'lat': doc['latitude'],
        'lon': doc['longitude'],
      };
    }).toList();
  }
}
