import 'package:flutter_test/flutter_test.dart';
import 'package:morvixa/morvixa_app.dart';

void main() {
  testWidgets('MorvixaApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MorvixaApp());
    expect(find.text('Steeping Timer'), findsOneWidget);
    expect(find.text('COMMENCE STEEPING'), findsOneWidget);
  });
}
