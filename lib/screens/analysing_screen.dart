// lib/screens/analysing_screen.dart

import 'package:flutter/material.dart';
import 'triage_result_screen.dart';

class AnalysingScreen extends StatefulWidget {
  final String patientName;
  final String ageGender;
  final List<String> symptoms;
  final int symptomDays;
  final String severity;

  const AnalysingScreen({
    super.key,
    required this.patientName,
    required this.ageGender,
    required this.symptoms,
    required this.symptomDays,
    required this.severity,
  });

  @override
  State<AnalysingScreen> createState() => _AnalysingScreenState();
}

class _AnalysingScreenState extends State<AnalysingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _scaleAnim =
        Tween<double>(begin: 0.9, end: 1.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TriageResultScreen(
            patientName: widget.patientName,
            ageGender: widget.ageGender,
            symptoms: widget.symptoms,
            symptomDays: widget.symptomDays,
            severity: widget.severity,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Card(
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Analysing Health Data',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Patient: ${widget.patientName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Symptoms: ${widget.symptoms.join(", ")}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(strokeWidth: 4),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Calculating severity & recommendations…',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
}