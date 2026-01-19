import 'dart:math';
import 'package:flutter/material.dart';

class AppointmentResultScreen extends StatelessWidget {
  final String hospitalName;
  final String patientName;
  final String category; // Heart, Bone, Muscle etc.

  const AppointmentResultScreen({
    super.key,
    required this.hospitalName,
    required this.patientName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    final apptNo = 'APT-${1000 + random.nextInt(9000)}';
    final roomNo = random.nextInt(30) + 1;

    final doctorMap = {
      'Heart': 'Cardiologist',
      'Lungs': 'Pulmonologist',
      'Muscle': 'Orthopedic',
      'Bone': 'Orthopedic',
      'Teeth': 'Dentist',
      'Infection / Fever': 'General Physician',
      'General / Other': 'General Physician',
    };

    final treatment = doctorMap[category] ?? 'General Physician';
    final doctorName = 'Dr. ${['Ravi', 'Priya', 'Arjun', 'Meena'][random.nextInt(4)]}';

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF0F766E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🏥 Hospital Name
                    Text(
                      hospitalName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Divider(thickness: 1.2),
                    const SizedBox(height: 12),

                    _infoRow('Patient Name', patientName),
                    _infoRow('Appointment No', apptNo),
                    _infoRow('Room No', roomNo.toString()),
                    _infoRow('Doctor', doctorName),
                    _infoRow('Treatment', treatment),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Show this slip at the hospital room',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )),
          Text(value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
