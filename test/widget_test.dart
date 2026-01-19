import 'package:flutter_test/flutter_test.dart';
import 'package:meditrage_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MediTriageApp());

    // Just checks that app builds without crashing
    expect(find.byType(MediTriageApp), findsOneWidget);
  });
}
