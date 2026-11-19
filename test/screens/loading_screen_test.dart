import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/core/widgets/widgets.dart';
import 'package:fortnite_app/features/shell/presentation/pages/loading_screen.dart';
import 'package:fortnite_app/features/shell/presentation/pages/navigation_screen.dart';
import 'package:fortnite_app/features/shell/presentation/widgets/loading_view.dart';

import 'package:flutter/material.dart';

import '../helpers/test_app.dart';

void main() {
  group('LoadingScreen Tests', () {
    testWidgets('deberia renderizar la LoadingScreen with LoadingView', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      expect(find.byType(LoadingView), findsOneWidget);
    });
  });

  group('LoadingView Test', () {
    testWidgets('Probar que loadingView contiene los elementos necesarios', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      expect(find.byType(ButtonComponent), findsOneWidget);
    });

    testWidgets('debería renderizar las imágenes en _FortniteImageAndShields', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      expect(find.image(const AssetImage('assets/loading/5.png')), findsOneWidget);
      expect(find.image(const AssetImage('assets/loading/slurp_bottle.png')), findsOneWidget);
      expect(find.image(const AssetImage('assets/loading/big.png')), findsOneWidget);
    });

    testWidgets('Encontrar el banner "FORTNITE BATTLE ROYALE"', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      expect(find.text('FORTNITE'), findsOneWidget);
      expect(find.text('BATTLE ROYALE'), findsOneWidget);
    });

    testWidgets('Encontrar botón para iniciar la App', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      expect(find.widgetWithText(ButtonComponent, 'PRESIONA INICIAR'), findsOneWidget);
    });

    testWidgets('Verificar que ButtonComponent navegue a la ruta principal', (tester) async {
      await tester.pumpWidget(testApp(home: const LoadingScreen()));
      await tester.tap(find.byType(ButtonComponent));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(NavegationScreen), findsOneWidget);
    });
  });
}
