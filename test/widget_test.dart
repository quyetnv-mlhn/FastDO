import 'package:flutter_test/flutter_test.dart';
import 'package:fastdo/app.dart';
import 'package:fastdo/core/services/injection.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  testWidgets('FastDO App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pump();
    expect(find.text('FastDO'), findsWidgets);
  });
}
