// lib/screens/consultation_screen.dart

import 'package:flutter/material.dart';
import 'analysing_screen.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageGenderController = TextEditingController();
  final TextEditingController otherSymptomController = TextEditingController();

  final List<String> allSymptoms = [
    'Headache',
    'Body Pain',
    'Vomiting',
    'Breathing Issue',
  ];

  final Set<String> selectedSymptoms = {};
  bool otherSelected = false;

  int symptomDays = 1;
  String severity = 'Mild';

  void _calculateSeverity() {
    if (symptomDays > 5) {
      severity = 'Severe';
      return;
    }
    if (symptomDays > 2) {
      severity = 'Moderate';
      return;
    }

    int score = 0;
    for (final s in selectedSymptoms) {
      if (s == 'Breathing Issue') {
        score += 3;
      } else if (s == 'Vomiting') {
        score += 2;
      } else {
        score += 1;
      }
    }

    if (otherSelected && otherSymptomController.text.trim().isNotEmpty) {
      score += 2;
    }

    severity = score >= 4 ? 'Moderate' : 'Mild';
  }

  Color _severityColor() {
    if (severity == 'Severe') return Colors.red;
    if (severity == 'Moderate') return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    _calculateSeverity();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FC),
      appBar: AppBar(
        title: const Text('Consultation'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PATIENT CARD
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: ageGenderController,
                      decoration: const InputDecoration(
                        labelText: 'Age / Gender (eg: 25 / M)',
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SYMPTOMS CARD
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Symptoms',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    ...allSymptoms.map(
                      (s) => CheckboxListTile(
                        value: selectedSymptoms.contains(s),
                        title: Text(s),
                        activeColor: Colors.redAccent,
                        onChanged: (v) {
                          setState(() {
                            v == true
                                ? selectedSymptoms.add(s)
                                : selectedSymptoms.remove(s);
                          });
                        },
                      ),
                    ),
                    CheckboxListTile(
                      value: otherSelected,
                      title: const Text('Other'),
                      activeColor: Colors.deepPurple,
                      onChanged: (v) {
                        setState(() {
                          otherSelected = v ?? false;
                          if (!otherSelected) {
                            otherSymptomController.clear();
                          }
                        });
                      },
                    ),
                    if (otherSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          controller: otherSymptomController,
                          decoration: const InputDecoration(
                            labelText: 'Describe other symptom',
                            prefixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // DAYS + SEVERITY CARD
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 12),
                        const Text(
                          'Symptom Duration',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        DropdownButton<int>(
                          value: symptomDays,
                          items: List.generate(
                            14,
                            (i) => DropdownMenuItem(
                              value: i + 1,
                              child: Text('${i + 1} days'),
                            ),
                          ),
                          onChanged: (v) {
                            setState(() {
                              symptomDays = v!;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      children: [
                        const Icon(Icons.warning_amber),
                        const SizedBox(width: 12),
                        const Text(
                          'Calculated Severity',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: _severityColor().withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            severity,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _severityColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // CONTINUE BUTTON
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  final finalSymptoms =
                      List<String>.from(selectedSymptoms);

                  if (otherSelected &&
                      otherSymptomController.text.trim().isNotEmpty) {
                    finalSymptoms.add(otherSymptomController.text.trim());
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnalysingScreen(
                        patientName: nameController.text,
                        ageGender: ageGenderController.text,
                        symptoms: finalSymptoms,
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
}