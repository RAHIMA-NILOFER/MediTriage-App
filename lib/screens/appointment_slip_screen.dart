import 'package:flutter/material.dart';

class AppointmentSlipScreen extends StatelessWidget {
  final String hospitalName;
  final String patientName;
  final String ageGender;
  final String appointmentNo;
  final String roomNo;
  final String doctorName;
  final String timeSlot;

  const AppointmentSlipScreen({
    super.key,
    required this.hospitalName,
    required this.patientName,
    required this.ageGender,
    required this.appointmentNo,
    required this.roomNo,
    required this.doctorName,
    required this.timeSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Appointment Slip'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ================= HOSPITAL NAME =================
                  Text(
                    hospitalName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Divider(thickness: 1.2),

                  const SizedBox(height: 12),

                  // ================= DETAILS =================
                  _row('Patient Name', patientName),
                  _row('Age / Gender', ageGender),
                  _row('Appointment No', appointmentNo),
                  _row('Room No', roomNo),
                  _row('Doctor', doctorName),
                  _row('Time Slot', timeSlot),

                  const SizedBox(height: 20),

                  const Divider(thickness: 1.2),

                  const SizedBox(height: 16),

                  // ================= CONFIRMATION MESSAGE =================
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Text(
                      '✅ Appointment Fixed Successfully\n\nPlease arrive 15 minutes early and carry a valid ID.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ================= DONE BUTTON =================
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 16),
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

  // ================= ROW WIDGET =================
  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}