import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/presentation/widgets/home_view.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/domain/repositories/news_repository.dart';
import 'package:fortnite_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:fortnite_app/features/news/presentation/widgets/news_view.dart';
import 'package:fortnite_app/features/players/domain/entities/player_stats.dart';
import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/features/players/presentation/widgets/player_view.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/shop_sections.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/replace_color_shops.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/lotes_view.dart';
import 'package:fortnite_app/features/shop/presentation/widgets/skins_view.dart';

import '../helpers/test_app.dart';

class _EmptyNewsRepository implements NewsRepository {
  @override
  Future<Result<NewsModel>> getNews() async => Ok(NewsModel(news: []));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('la tienda ignora enums, fechas y precios que no puede interpretar', () {
    final shop = Shop.fromJson({
      'storeName': 'tienda-desconocida',
      'displayName': 'Oferta',
      'firstReleaseDate': 'ayer',
      'price': {'finalPrice': 1200.0, 'regularPrice': 'no'},
      'banner': {'intensity': 'ultra'},
      'displayAssets': [
        {'url': 'https://example.com/skin.png', 'primaryMode': 'NuevoModo'},
      ],
    });

    expect(shop.storeName, isNull);
    expect(shop.firstReleaseDate, isNull);
    expect(shop.price?.finalPrice, 1200);
    expect(shop.price?.regularPrice, isNull);
    expect(shop.banner?.intensity, isNull);
    expect(shop.displayAssets?.first.primaryMode, isNull);
    expect(shop.toJson()['firstReleaseDate'], isNull);
  });

  test('un color de tienda inválido usa el siguiente hexadecimal válido', () {
    final color = replaceShopColorWithDartFormat(
      Shop(colors: ColorsItems(color1: 'rojo', color2: '#00ff00')),
    );

    expect(color, const Color(0xFF00FF00));
  });

  test('las secciones de la tienda no mezclan tipos', () {
    final sections = ShopSections.group([
      Shop(displayType: DisplayType.TRAJE, displayName: 'Skin'),
      Shop(displayType: DisplayType.PICOS, displayName: 'Pico'),
      Shop(displayType: DisplayType.LOTE_DE_OBJETOS, displayName: 'Lote'),
    ]);

    expect(sections.skins.single.displayName, 'Skin');
    expect(sections.pickaxes.single.displayName, 'Pico');
    expect(sections.bundles.single.displayName, 'Lote');
    expect(sections.alaDeltas, isEmpty);
  });

  test('un arma con rareza desconocida y clip decimal no lanza', () {
    final weapon = Weapon.fromJson({
      'name': 'Arco',
      'rarity': 'mythic-plus',
      'type': 'bow',
      'mainStats': {
        'ClipSize': 12.8,
        'BulletsPerCartridge': 1.0,
        'DmgPB': 40,
      },
    });

    expect(weapon.rarity, isNull);
    expect(weapon.type, isNull);
    expect(weapon.mainStats?.clipSize, 12);
    expect(weapon.mainStats?.bulletsPerCartridge, 1);
  });

  test('una noticia sin campos obligatorios ni imagen jpeg no lanza', () {
    final news = News.fromJson({
      'title': null,
      'body': null,
      'date': 'no-es-fecha',
      'image': 'https://cdn.example/foto.png?width=200',
    });

    expect(news.title, 'Sin título');
    expect(news.body, isEmpty);
    expect(news.date, isNull);
    expect(
      cleanNewsImageUrl(news.image),
      'https://cdn.example/foto.png',
    );
  });

  test('el bloc de noticias acepta un listado vacío', () async {
    final bloc = NewsBloc(getNews: GetNewsUseCase(_EmptyNewsRepository()));
    addTearDown(bloc.close);

    final loaded = expectLater(
      bloc.stream,
      emits(isA<NewsState>().having((state) => state.news?.news, 'news', isEmpty)),
    );
    await bloc.getNews();
    await loaded;

    expect(bloc.state.newSelected, isNull);
  });

  test('las stats del jugador toleran nivel decimal y valores nulos', () {
    final stats = PlayerStatsModel.fromJson({
      'name': 'ninja',
      'account': {'level': 120.7, 'season': 30},
      'global_stats': {
        'solo': {'kd': null, 'kills': 10},
        'duo': 'no-es-mapa',
      },
    });

    expect(stats.account?.level, 120);
    expect(stats.globalStats?.solo?['kills'], 10);
    expect(stats.globalStats?.duo, isNull);
  });

  testWidgets('home sin arma seleccionada no revienta', (tester) async {
    await tester.pumpWidget(testApp(home: const HomeView()));
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('No registra'), findsWidgets);
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('el jugador sin nombre ni stats no revienta al cambiar de modo', (tester) async {
    await tester.pumpWidget(testApp(home: const Scaffold(body: PlayerView())));
    final bloc = tester.element(find.byType(PlayerView)).read<PlayerBloc>();
    bloc.add(OnGetPlayerAccountEvent(player: PlayerStatsModel()));
    await tester.pump();
    await tester.pump();

    expect(find.text('Sin nombre'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);

    await tester.tap(find.text('Duos'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('noticias vacías muestran un estado vacío', (tester) async {
    await tester.pumpWidget(testApp(home: const NewsView()));
    await tester.pump();

    expect(find.text('No hay noticias disponibles'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('una skin sin imagen no revienta la tienda', (tester) async {
    await tester.pumpWidget(testApp(home: const SkinsView()));
    final bloc = tester.element(find.byType(SkinsView)).read<ShopBloc>();
    bloc.add(OnLoadAllShopsEvent(
      alaDeltasShop: const [],
      envoltoriosShop: const [],
      gestosShop: const [],
      loteDeObjetosShopCompletos: const [],
      musicaShop: const [],
      picosShop: const [],
      playSetProp: const [],
      trajeShop: [Shop(displayName: 'Skin rota')],
    ));
    await tester.pump();
    await tester.pump();

    expect(find.text('No disponible'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('un lote con índice fuera de rango no revienta', (tester) async {
    await tester.pumpWidget(testApp(home: const LotesView()));
    final bloc = tester.element(find.byType(LotesView)).read<ShopBloc>();
    bloc.add(OnLoadAllShopsEvent(
      alaDeltasShop: const [],
      envoltoriosShop: const [],
      gestosShop: const [],
      loteDeObjetosShopCompletos: [Shop(displayName: 'Lote')],
      musicaShop: const [],
      picosShop: const [],
      playSetProp: const [],
      trajeShop: const [],
    ));
    bloc.add(const OnUpdateIndexShopEvent(newIndex: 40));
    await tester.pump();
    await tester.pump();

    expect(find.text('Lote'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pump(const Duration(seconds: 2));
  });
}
