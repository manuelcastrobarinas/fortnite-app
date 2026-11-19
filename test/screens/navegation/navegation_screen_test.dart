import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/features/items/presentation/pages/home_screen.dart';
import 'package:fortnite_app/features/news/presentation/pages/news_screen.dart';
import 'package:fortnite_app/features/players/presentation/pages/player_screen.dart';
import 'package:fortnite_app/features/shell/presentation/pages/navigation_screen.dart';
import 'package:fortnite_app/features/shop/presentation/pages/shop_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  group('Navigation Screen', () {
    testWidgets('la primera pantalla es HomeScreen', (tester) async {
      await tester.pumpWidget(testApp(home: const NavegationScreen()));
      await tester.pump();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(CurvedNavigationBar), findsOneWidget);
      expect(find.byType(Icon), findsWidgets);
    });

    testWidgets('navega a NewsScreen', (tester) async {
      await tester.pumpWidget(testApp(home: const NavegationScreen()));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.newspaper_rounded).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(NewsScreen), findsOneWidget);
    });

    testWidgets('navega a ShopScreen', (tester) async {
      await tester.pumpWidget(testApp(home: const NavegationScreen()));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.shopping_bag_rounded).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(ShopScreen), findsOneWidget);
    });

    testWidgets('navega a PlayerScreen', (tester) async {
      await tester.pumpWidget(testApp(home: const NavegationScreen()));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.query_stats_rounded));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byType(PlayerScreen), findsOneWidget);
    });
  });
}
