import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/presentation/screens.dart';
import 'package:fortnite_app/presentation/screens/navegation/main_screen.dart';
import 'package:fortnite_app/presentation/views.dart';


final fakeApp = MaterialApp(
  home  : const LoadingScreen(),
  routes: {
    'loading': (_) => const LoadingScreen(),
    'main'   : (_) => const MainScreen()
  },
);

void main() {

  // Grupo de pruebas para la pantalla LoadingScreen
  group('LoadingScreen Tests', () {
    testWidgets('Should render LoadingScreen with LoadingView', (WidgetTester tester) async {     // Prueba para verificar que LoadingScreen se construye correctamente
      await tester.pumpWidget(fakeApp); // Construye el widget LoadingScreen en el entorno de prueba
      expect(find.byType(LoadingView), findsOneWidget); // Busca el widget LoadingView dentro de LoadingScreen
    });
  });
  

  group('LoadingView Test', () { 
    testWidgets('Probar que loadingView contiene los elementos necesarios', (WidgetTester tester) async { // Prueba para verificar que LoadingView contiene los elementos necesarios
      await tester.pumpWidget(fakeApp);
      expect(find.byType(ButtonComponent), findsOneWidget); // Verifica que el widget ButtonComponent esté presente
    });

    testWidgets('deberia renderizar las imagenes in _FortniteImageAndShields', (WidgetTester tester) async { // Prueba para verificar que las imágenes dentro de _FortniteImageAndShields se muestran correctamente
      //ARRAGE
      await tester.pumpWidget(fakeApp); //LEVANTAMOS LA FAKE APP
      //ASSERT
      expect(find.image(const AssetImage("assets/loading/5.png")), findsOneWidget); // Verifica que la imagen principal de fondo se muestra
      expect(find.image(const AssetImage("assets/loading/slurp_bottle.png")), findsOneWidget);  // Verifica que la imagen del Slurp Bottle se muestra
      expect(find.image(const AssetImage("assets/loading/big.png")), findsOneWidget);  // Verifica que la imagen del Big Shield se muestra
    });
        
    testWidgets('Encontrar el banner "FORTNITE BATTLE ROYALE"', (WidgetTester widgetTester) async { // Prueba para verificar que el texto en el widget _Banner se muestra correctamente
      //arrage
      await widgetTester.pumpWidget(fakeApp);
      const String title    = "FORTNITE";
      const String subtitle = "BATTLE ROYALE";
      //act
      final findTitle     = find.text(title);
      final findSubtitle  = find.text(subtitle);
      //assert
      expect(findTitle, findsOneWidget);
      expect(findSubtitle, findsOneWidget);
    });
 
    testWidgets('Encontrar boton para iniciar la App', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(fakeApp);
      const String buttonText = 'PRESS TO START'; 
      //ACT
      final findStartButton = find.widgetWithText(ButtonComponent, buttonText);
      //ASSERT
      expect(findStartButton, findsOneWidget);
    });

    testWidgets('verificar que ButtonComponent navegue a la ruta correcta(main)', (WidgetTester tester) async { // Prueba para verificar que el botón ButtonComponent navega a la ruta correcta
      await tester.pumpWidget(fakeApp);

      final button = find.byType(ButtonComponent); // Encuentra el widget ButtonComponent      
      expect(button, findsOneWidget); // Verifica que el botón está presente

      
      await tester.tap(button); // Realiza un tap en el botón
      await tester.pumpAndSettle();

      const text =  "Home Page";
      final centerText = find.widgetWithText(Center, text);
      expect(find.text('Home Page'), findsOneWidget); // Verifica que la navegación ocurrió y estamos en la pantalla 'main'
      expect(centerText, findsOneWidget);
    });

  });

}