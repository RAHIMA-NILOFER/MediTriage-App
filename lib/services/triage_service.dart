class TriageService {
  static String calculateSeverity({
    required int age,
    required String symptoms,
    required int days,
  }) {
    final s = symptoms.toLowerCase();

    if (s.contains('chest') ||
        s.contains('breath') ||
        s.contains('fracture') ||
        s.contains('bleeding') ||
        s.contains('infection') ||
        s.contains('diarrhea') ||
        s.contains('rash') ||
        days >= 5 ||
        age >= 65) {
      return 'Severe';
    }

    if (s.contains('pain') ||
        s.contains('muscle') ||
        s.contains('fatigue') ||
        s.contains('fever') ||
        days >= 3) {
      return 'Moderate';
    }

    return 'Mild';
  }
}
