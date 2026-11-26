import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';

void main() {
  testWidgets('MyPortfolio app builds successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => AuthState(), child: const MyApp()),
    );

    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
  });
}
