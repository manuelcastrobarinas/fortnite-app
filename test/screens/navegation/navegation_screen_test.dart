import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/presentation/screens.dart';
import 'package:fortnite_app/routes/routes.dart';

void main() {

  final MaterialApp fakeApp = MaterialApp(
    home  : const NavegationScreen(),
    routes: routes,
  );
  
  group('verificar Navigation Screen y Probarar que encuentre los widgets y navegue a otras pantallas', () {

    testWidgets('Verificar que la primera pantalla (HomeScreen) es visible por defecto', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(fakeApp);
      //ACT AND ASSERT
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(CurvedNavigationBar), findsOneWidget);
      expect(find.byType(Icon), findsWidgets);
   });
  
    testWidgets('navegar a la segunda pantalla (NewsScreen)', (WidgetTester widgetTester) async {
    //ARRAGE
      await widgetTester.pumpWidget(fakeApp);
      //ACT AND ASSERT
      await widgetTester.tap(find.byIcon(Icons.newspaper_rounded).first); // Tap en el segundo ícono de navegación
      await widgetTester.pumpAndSettle();  // Espera que los cambios se establezcan
      // Verificar que se ha navegado a la segunda pantalla
      expect(find.byType(NewsScreen), findsOneWidget);
    });

    testWidgets('Navegar a la tercera pantalla (ShopScreen)', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(fakeApp);
      //ACT
      await widgetTester.tap(find.byIcon(Icons.shopping_bag_rounded).first);
      await widgetTester.pumpAndSettle();
      //ASSERT
      expect(find.byType(ShopScreen), findsOneWidget);
    });

    testWidgets('Navegar a la cuarta pantalla (PlayerScreen)', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(fakeApp);
      //ACT
      await widgetTester.tap(find.byIcon(Icons.query_stats_rounded));
      await widgetTester.pumpAndSettle();
      //ASSERT
      expect(find.byType(PlayerScreen), findsOneWidget);
    });
  });
}