import 'package:flutter_test/flutter_test.dart';
import 'package:fastdo/main.dart';

void main() {
  testWidgets('FastDO app initial smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FastDoApp());
    expect(find.text('FastDO'), findsWidgets);
  });
}
