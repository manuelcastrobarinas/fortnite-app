import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/core/errors/failures.dart';
import 'package:fortnite_app/features/island/data/datasources/island_remote_datasource.dart';
import 'package:fortnite_app/features/island/data/repositories/island_repository_impl.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';
import 'package:fortnite_app/features/island/domain/usecases/island_usecases.dart';
import 'package:fortnite_app/features/island/presentation/bloc/island_bloc.dart';
import 'package:fortnite_app/features/island/presentation/pages/island_screen.dart';

void main() {
  test('el mapa conserva la imagen con nombres y omite puntos vacíos', () {
    final map = BrMap.fromJson({
      'images': {
        'blank': 'https://example.com/map.png',
        'pois': 'https://example.com/map_es.png',
      },
      'pois': [
        {'id': 'b', 'name': '  '},
        {
          'id': 'a',
          'name': 'Frontera Farol',
          'location': {'x': 1, 'y': 2, 'z': 3},
        },
        {'name': 'Aguja'},
      ],
    });

    expect(map.displayImageUrl, 'https://example.com/map_es.png');
    expect(map.pois.map((poi) => poi.name), ['Aguja', 'Frontera Farol']);
  });

  test('los modos sin imagen no se muestran', () {
    final modes = GameMode.fromApiList([
      {'id': 'interno', 'name': 'beantest', 'description': 'test'},
      {
        'id': 'Playlist_DefaultDuo',
        'name': 'Dúos',
        'description': 'Juega con un amigo',
        'maxTeamSize': 2,
        'images': {
          'showcase': 'https://example.com/duo.png',
        },
      },
      {
        'id': 'Playlist_DefaultDuo',
        'name': 'Dúos repetido',
        'images': {'showcase': 'https://example.com/duo.png'},
      },
    ]);

    expect(modes, hasLength(1));
    expect(modes.single.name, 'Dúos');
    expect(modes.single.teamSize, 2);
  });

  test('las novedades juntan los grupos y leen el icono', () {
    final cosmetics = NewCosmetic.fromGroups({
      'br': [
        {
          'id': 'skin',
          'name': 'Pearto',
          'type': {'displayValue': 'Mochila'},
          'rarity': {'displayValue': 'Rara'},
          'images': {
            'smallIcon': 'https://example.com/small.png',
            'icon': 'https://example.com/icon.png',
          },
        },
      ],
      'lego': [
        {'id': 'skin', 'name': 'Pearto otra vez'},
        {'id': 'coche', 'name': ''},
      ],
    });

    expect(cosmetics, hasLength(1));
    expect(cosmetics.single.imageUrl, 'https://example.com/icon.png');
    expect(cosmetics.single.typeLabel, 'Mochila');
    expect(cosmetics.single.groupLabel, 'Battle Royale');
  });

  test('un mapa sin imagen ni puntos es un fallo de no encontrado', () async {
    final repository = IslandRepositoryImpl(_EmptyRemote());
    final result = await repository.getMap();

    expect(result.isOk, isFalse);
    expect(result.failure, isA<NotFoundFailure>());
  });

  testWidgets('la isla muestra los puntos del mapa aunque no haya imagen', (tester) async {
    final repository = IslandRepositoryImpl(_MapRemote());
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => IslandBloc(
          getMap: GetBrMapUseCase(repository),
          getModes: GetGameModesUseCase(repository),
          getNewCosmetics: GetNewCosmeticsUseCase(repository),
          getCreatorCode: GetCreatorCodeUseCase(repository),
        ),
        child: const MaterialApp(home: IslandScreen()),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Frontera Farol'), findsOneWidget);
    expect(find.text('Sin imagen del mapa'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('un código activo muestra la cuenta y el estado en español', () {
    final code = CreatorCode.fromJson({
      'code': 'ninja',
      'account': {'id': '4735', 'name': 'Ninja'},
      'status': 'ACTIVE',
      'verified': false,
    });

    expect(code.accountName, 'Ninja');
    expect(code.statusLabel, 'Activo');
    expect(code.verified, isFalse);
  });

  test('un código vacío no llama a la red', () async {
    final repository = IslandRepositoryImpl(_EmptyRemote());
    final result = await repository.getCreatorCode('   ');

    expect(result.isOk, isFalse);
    expect(result.failure, isA<ValidationFailure>());
    expect(result.failure.message, 'Escribe un código de creador');
  });

  testWidgets('la búsqueda de creador muestra la cuenta', (tester) async {
    final repository = IslandRepositoryImpl(_MapRemote());
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => IslandBloc(
          getMap: GetBrMapUseCase(repository),
          getModes: GetGameModesUseCase(repository),
          getNewCosmetics: GetNewCosmeticsUseCase(repository),
          getCreatorCode: GetCreatorCodeUseCase(repository),
        ),
        child: const MaterialApp(home: IslandScreen()),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('Creador'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'ninja');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();
    await tester.pump();

    expect(find.text('Ninja'), findsOneWidget);
    expect(find.text('Estado: Activo'), findsOneWidget);
    expect(find.text('No verificado'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _EmptyRemote implements IslandRemoteDataSource {
  @override
  Future<BrMap> fetchMap() async => const BrMap();

  @override
  Future<List<GameMode>> fetchModes() async => const [];

  @override
  Future<List<NewCosmetic>> fetchNewCosmetics() async => const [];

  @override
  Future<CreatorCode> fetchCreatorCode(String name) async {
    throw UnimplementedError();
  }
}

class _MapRemote implements IslandRemoteDataSource {
  @override
  Future<BrMap> fetchMap() async => const BrMap(
        pois: [MapPoi(id: 'faro', name: 'Frontera Farol')],
      );

  @override
  Future<List<GameMode>> fetchModes() async => const [];

  @override
  Future<List<NewCosmetic>> fetchNewCosmetics() async => const [];

  @override
  Future<CreatorCode> fetchCreatorCode(String name) async {
    return CreatorCode(
      code: name,
      accountId: '4735',
      accountName: 'Ninja',
      status: 'ACTIVE',
      verified: false,
    );
  }
}
