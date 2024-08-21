import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/presentation/screens.dart';
import 'package:fortnite_app/presentation/views.dart';
import 'package:fortnite_app/routes/routes.dart';

//CREA APLICACION FAKE -
final MaterialApp fakeApp = MaterialApp(
  home  : const LoadingScreen(),
  routes: routes,
);

void main() {
  // Grupo de pruebas para la pantalla LoadingScreen
  group('LoadingScreen Tests', () {
    testWidgets('deberia renderizar la LoadingScreen with LoadingView', (WidgetTester tester) async {
      await tester.pumpWidget(fakeApp); // Construye el widget LoadingScreen en el entorno de prueba
      expect(find.byType(LoadingView), findsOneWidget); // Busca el widget LoadingView dentro de LoadingScreen
    });
  });

  group('LoadingView Test', () {
    testWidgets('Probar que loadingView contiene los elementos necesarios', (WidgetTester tester) async {
      await tester.pumpWidget(fakeApp);
      expect(find.byType(ButtonComponent), findsOneWidget); // Verifica que el widget ButtonComponent esté presente
    });

    testWidgets('debería renderizar las imágenes en _FortniteImageAndShields', (WidgetTester tester) async {
      await tester.pumpWidget(fakeApp); // Levantamos la fake app
      expect(find.image(const AssetImage("assets/loading/5.png")), findsOneWidget); // Verifica que la imagen principal de fondo se muestra
      expect(find.image(const AssetImage("assets/loading/slurp_bottle.png")), findsOneWidget); // Verifica que la imagen del Slurp Bottle se muestra
      expect(find.image(const AssetImage("assets/loading/big.png")), findsOneWidget); // Verifica que la imagen del Big Shield se muestra
    });

    testWidgets('Encontrar el banner "FORTNITE BATTLE ROYALE"', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(fakeApp);
      const String title = "FORTNITE";
      const String subtitle = "BATTLE ROYALE";
      final findTitle = find.text(title);
      final findSubtitle = find.text(subtitle);
      expect(findTitle, findsOneWidget);
      expect(findSubtitle, findsOneWidget);
    });

    testWidgets('Encontrar botón para iniciar la App', (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(fakeApp);
      const String buttonText = 'PRESS TO START';
      final findStartButton = find.widgetWithText(ButtonComponent, buttonText);
      expect(findStartButton, findsOneWidget);
    });

    testWidgets('Verificar que ButtonComponent navegue a la ruta correcta (main)', (WidgetTester tester) async {
      await tester.pumpWidget(fakeApp);
      final button = find.byType(ButtonComponent);
      expect(button, findsOneWidget);
      await tester.tap(button); // Realiza un tap en el botón
      await tester.pumpAndSettle();
      const text = "Home Page";
      final centerText = find.widgetWithText(Center, text);
      expect(find.text('Home Page'), findsOneWidget); // Verifica que la navegación ocurrió y estamos en la pantalla 'main'
      expect(centerText, findsOneWidget);
    });
  });
}
