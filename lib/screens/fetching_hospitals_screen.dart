// lib/screens/fetching_hospitals_screen.dart

import 'package:flutter/material.dart';
import 'osm_map_screen.dart';

class FetchingHospitalsScreen extends StatelessWidget {
  final String patientName;
  final String ageGender;
  final List<String> symptoms;
  final int symptomDays;
  final String severity;

  const FetchingHospitalsScreen({
    super.key,
    required this.patientName,
    required this.ageGender,
    required this.symptoms,
    required this.symptomDays,
    required this.severity,
  });

  Color _severityColor() {
    if (severity.toLowerCase() == 'severe') return Colors.red;
    if (severity.toLowerCase() == 'moderate') return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FD),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 36,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ICON + ANIMATION FEEL
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _severityColor().withOpacity(0.15),
                    ),
                    child: Icon(
                      Icons.local_hospital,
                      size: 64,
                      color: _severityColor(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Finding Nearby Hospitals',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Based on your symptoms and severity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DETAILS CHIP ROW
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _chip('👤 $patientName'),
                      _chip('⚠ $severity'),
                      _chip('⏱ $symptomDays days'),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // LOADER
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(strokeWidth: 4),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _severityColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
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
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}