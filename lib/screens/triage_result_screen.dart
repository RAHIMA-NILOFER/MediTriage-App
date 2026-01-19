// lib/screens/triage_result_screen.dart

import 'package:flutter/material.dart';
import 'osm_map_screen.dart';

class TriageResultScreen extends StatelessWidget {
  final String patientName;
  final String ageGender;
  final List<String> symptoms;
  final int symptomDays;
  final String severity;

  const TriageResultScreen({
    super.key,
    required this.patientName,
    required this.ageGender,
    required this.symptoms,
    required this.symptomDays,
    required this.severity,
  });

  Color _severityColor() {
    switch (severity.toLowerCase()) {
      case 'severe':
        return Colors.redAccent;
      case 'moderate':
        return Colors.orangeAccent;
      default:
        return Colors.green;
    }
  }

  String _severityEmoji() {
    switch (severity.toLowerCase()) {
      case 'severe':
        return '🚨';
      case 'moderate':
        return '⚠️';
      default:
        return '✅';
    }
  }

  String _recommendation() {
    switch (severity.toLowerCase()) {
      case 'severe':
        return 'Go to emergency immediately';
      case 'moderate':
        return 'Visit nearby hospital';
      default:
        return 'Home care / consult doctor if needed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _severityColor();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      appBar: AppBar(
        title: const Text('Triage Result'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ================= SEVERITY HERO CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _severityEmoji(),
                    style: const TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Severity Level',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    severity,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= PATIENT DETAILS =================
            _infoCard(
              title: 'Patient Details',
              icon: Icons.person,
              children: [
                _infoRow('👤 Name', patientName),
                _infoRow('🎂 Age / Gender', ageGender),
              ],
            ),

            const SizedBox(height: 16),

            // ================= SYMPTOMS =================
            _infoCard(
              title: 'Reported Symptoms',
              icon: Icons.medical_information,
              children: [
                _infoRow('🩺 Symptoms', symptoms.join(', ')),
                _infoRow('⏱ Duration', '$symptomDays days'),
              ],
            ),

            const SizedBox(height: 16),

            // ================= RECOMMENDATION =================
            _infoCard(
              title: 'Recommended Action',
              icon: Icons.info_outline,
              children: [
                Text(
                  _recommendation(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ================= CTA BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.local_hospital),
                label: const Text(
                  'Find Nearby Hospitals',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 6,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OsmMapScreen(
                        patientName: patientName,
                        ageGender: ageGender,
                        symptoms: symptoms,
                        symptomDays: symptomDays,
                        severity: severity,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _infoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
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
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}