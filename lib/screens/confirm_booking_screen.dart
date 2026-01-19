import 'dart:math';
import 'package:flutter/material.dart';

class ConfirmBookingScreen extends StatelessWidget {
  final String hospital, patient, age, gender;

  const ConfirmBookingScreen({
    super.key,
    required this.hospital,
    required this.patient,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final rnd = Random();

    return Scaffold(
      appBar: AppBar(title: const Text("Appointment Slip")),
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(hospital,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const Divider(),
                _row("Patient", patient),
                _row("Age / Gender", "$age / $gender"),
                _row("Appointment No", "APT-${rnd.nextInt(9999)}"),
                _row("Room No", "${rnd.nextInt(20) + 1}"),
                _row("Doctor", "General Physician"),
                _row("Time", "10:30 – 11:00"),
                const SizedBox(height: 16),
                const Text(
                  "✅ Appointment Fixed Successfully",
                  style: TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 8),
                const Text("🙏 Thank you for booking"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String l, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(l), Text(v)],
      ),
    );
  }
}