// lib/screens/osm_map_screen.dart

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'appointment_slip_screen.dart';

class OsmMapScreen extends StatefulWidget {
  final String patientName;
  final String ageGender;
  final List<String> symptoms;
  final int symptomDays;
  final String severity;

  const OsmMapScreen({
    super.key,
    required this.patientName,
    required this.ageGender,
    required this.symptoms,
    required this.symptomDays,
    required this.severity,
  });

  @override
  State<OsmMapScreen> createState() => _OsmMapScreenState();
}

class _OsmMapScreenState extends State<OsmMapScreen> {
  LatLng? currentLocation;
  List<Map<String, dynamic>> hospitals = [];
  bool loading = true;
  bool showLegend = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _getLocation();
    await _fetchHospitals();
    setState(() => loading = false);
  }

  Future<void> _getLocation() async {
    await Geolocator.requestPermission();
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation = LatLng(pos.latitude, pos.longitude);
  }

  Future<void> _fetchHospitals() async {
    final query = '''
[out:json][timeout:25];
(
  node["amenity"="hospital"](around:30000,${currentLocation!.latitude},${currentLocation!.longitude});
);
out tags center;
''';

    final res = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: {'data': query},
    );

    final data = json.decode(res.body);
    hospitals = (data['elements'] as List)
        .where((e) => e['lat'] != null && e['lon'] != null)
        .map((e) => {
              'name': e['tags']?['name'] ?? 'Unnamed Hospital',
              'lat': e['lat'],
              'lon': e['lon'],
            })
        .toList();
  }

  Color _hospitalColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('government') || n.contains('govt') || n.contains('gh')) {
      return Colors.red;
    }
    if (n.contains('college') || n.contains('medical')) {
      return Colors.amber;
    }
    return Colors.green;
  }

  void _showBookingPopup(String hospitalName) {
    final rand = Random();
    final apptNo = 'APT${1000 + rand.nextInt(9000)}';
    final roomNo = 'Room ${1 + rand.nextInt(25)}';

    final doctorMap = {
      'mild': 'Dr. General Physician',
      'moderate': 'Dr. Internal Medicine',
      'severe': 'Dr. Emergency Specialist',
    };

    final doctorName =
        doctorMap[widget.severity.toLowerCase()] ?? 'Dr. Physician';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hospitalName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _infoRow('👤 Patient', widget.patientName),
            _infoRow('🎂 Age / Gender', widget.ageGender),
            _infoRow('🩺 Symptoms', widget.symptoms.join(', ')),
            _infoRow('⏱ Duration', '${widget.symptomDays} days'),
            _infoRow('⚠ Severity', widget.severity),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AppointmentSlipScreen(
                            hospitalName: hospitalName,
                            patientName: widget.patientName,
                            ageGender: widget.ageGender,
                            doctorName: doctorName,
                            roomNo: roomNo,
                            appointmentNo: apptNo,
                            timeSlot: '10:30 AM - 11:00 AM',
                          ),
                        ),
                      );
                    },
                    child: const Text('Confirm Booking'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child:
                  Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(
              child: Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading || currentLocation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Hospitals'),
        elevation: 4,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: currentLocation!,
              zoom: 11,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLocation!,
                    width: 44,
                    height: 44,
                    child: const Icon(Icons.my_location,
                        color: Colors.blue, size: 40),
                  ),
                  ...hospitals.map(
                    (h) => Marker(
                      point: LatLng(h['lat'], h['lon']),
                      width: 44,
                      height: 44,
                      child: GestureDetector(
                        onTap: () => _showBookingPopup(h['name']),
                        child: Icon(
                          Icons.location_on,
                          color: _hospitalColor(h['name']),
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // LEGEND POPUP
          if (showLegend)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Hospital Map Legend',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _legendRow('📍', 'Private Hospital', Colors.green),
                      _legendRow('📍', 'Government / Free Hospital', Colors.red),
                      _legendRow('📍', 'Medical College', Colors.amber),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() => showLegend = false);
                          },
                          child: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _legendRow(String emoji, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.location_on, color: color),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}