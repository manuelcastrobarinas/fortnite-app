import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/components/selectors/choise_chips_component.dart';

final _listTest = ['uno','dos','tres','cuatro'];

final MaterialApp fakeComponentApp = MaterialApp(
  home: Scaffold(
    body: ChoiceChipComponent(choisesList: _listTest),
  ),
);

void main() {
  group('Probar el componente de Choise Chip', () {

    testWidgets('probar que tenga todos los elementos', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(fakeComponentApp);
      //ACT
      final findInitialPadding  = find.byType(Padding);
      final widgetCenter        = find.byType(Center);
      final itHaveWrap          = find.byType(Wrap);
      final findChoiceChip      = find.byType(ChoiceChip);
      //ASSERT
      expect(findInitialPadding, findsWidgets);
      expect(widgetCenter, findsWidgets);
      expect(itHaveWrap, findsOneWidget);
      expect(findChoiceChip, findsWidgets);
    });

    testWidgets('Verificar que List.generate cree correctamente el numero de ChoiseChips', (WidgetTester widgetTester) async {
      //ARRAGE
      await widgetTester.pumpWidget(
      MaterialApp(
          home: Scaffold(
            body: ChoiceChipComponent(choisesList: _listTest),
          ),
        ),
      );
      //ACT AND ASSERTS
      for (final choice in _listTest) {
        expect(find.text(choice), findsOneWidget);
      }
      expect(find.byType(ChoiceChip), findsNWidgets(_listTest.length));


      // Ensure the initial state is correct
      expect(find.byWidgetPredicate((widget) {
        return widget is ChoiceChip && widget.selected && widget.label is Text && (widget.label as Text).data == 'uno';
      }), findsOneWidget);

      // Simulate tapping on the second ChoiceChip
      await widgetTester.tap(find.text('dos').last);
      await widgetTester.pumpAndSettle(); // Wait for state changes

      // Verify that the onSelected callback updated the selection correctly
      expect(find.byWidgetPredicate((widget) {
        return widget is ChoiceChip && widget.selected && widget.label is Text && (widget.label as Text).data == 'dos';
      }), findsOneWidget);

      // Verify that the previously selected chip is no longer selected
      expect(find.byWidgetPredicate((widget) {
        return widget is ChoiceChip && !widget.selected && widget.label is Text && (widget.label as Text).data == 'uno';
      }), findsOneWidget);
    });
  });
}