import 'package:material_ui/material_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as fl;
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:provider/provider.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          secondary: Colors.amber,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: fl.GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('en'), Locale('id')],
      home: Consumer<AuthState>(
        builder: (context, authState, child) {
          if (authState.isAuthenticated) {
            return MyHomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
