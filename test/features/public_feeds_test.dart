import 'package:flutter_test/flutter_test.dart';
import 'package:fortnite_app/features/items/data/models/public_weapons_mapper.dart';
import 'package:fortnite_app/features/news/data/models/news_response_model.dart';
import 'package:fortnite_app/features/players/data/models/player_stats_response_model.dart';
import 'package:fortnite_app/features/shop/data/models/public_shop_mapper.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/shop_sections.dart';

void main() {
  test('las noticias públicas arman el feed de Battle Royale y Salvar el mundo', () {
    final feed = NewsResponseModel.fromPublicBody({
      'data': {
        'br': {
          'date': '2026-11-19T00:00:00.000Z',
          'motds': [
            {
              'id': 'br-1',
              'title': 'Frutas del diablo',
              'body': 'Han aparecido por el mapa',
              'image': 'https://cdn.example/noticia.jpeg?width=1920',
              'hidden': false,
            },
            {'id': 'oculta', 'title': 'No mostrar', 'hidden': true},
          ],
        },
        'stw': {
          'messages': [
            {'title': 'Salvar el mundo', 'body': 'Mensaje', 'image': 'https://cdn.example/stw.png'},
          ],
        },
      },
    }).toEntity();

    expect(feed.news, hasLength(2));
    expect(feed.news!.first.title, 'Frutas del diablo');
    expect(feed.news!.first.date, isNotNull);
    expect(feed.news!.last.id, 'stw-0');
  });

  test('la tienda pública separa skins, lotes y pistas', () {
    final catalog = shopFromPublicBody({
      'data': {
        'date': '2026-11-20T00:00:00Z',
        'entries': [
          {
            'finalPrice': 1200,
            'regularPrice': 1500,
            'colors': {'color1': '6e03d8ff'},
            'brItems': [
              {
                'id': 'skin',
                'name': 'Recirculador',
                'description': 'Caracola',
                'type': {'value': 'outfit'},
                'images': {'icon': 'https://cdn.example/skin.png'},
              },
            ],
          },
          {
            'finalPrice': 2000,
            'brItems': [
              {
                'name': 'Skin del lote',
                'type': {'value': 'outfit'},
                'images': {'icon': 'https://cdn.example/a.png'},
              },
              {
                'name': 'Mochila',
                'type': {'value': 'backpack'},
                'images': {'icon': 'https://cdn.example/b.png'},
              },
              {
                'name': 'Pico',
                'type': {'value': 'pickaxe'},
                'images': {'icon': 'https://cdn.example/c.png'},
              },
            ],
          },
          {
            'finalPrice': 500,
            'tracks': [
              {
                'id': 'track',
                'title': 'As Alive',
                'artist': 'Nine Inch Nails',
                'albumArt': 'https://cdn.example/art.jpg',
              },
            ],
          },
          {
            'brItems': [
              {
                'name': 'Mascota',
                'type': {'value': 'sidekick'},
                'images': {'icon': 'https://cdn.example/pet.png'},
              },
            ],
          },
        ],
      },
    });

    final sections = ShopSections.group(catalog.shop);
    expect(sections.skins.single.displayName, 'Recirculador');
    expect(sections.skins.single.price?.finalPrice, 1200);
    expect(sections.skins.single.colors?.color1, '#ff6e03d8');
    expect(sections.bundles.single.displayName, 'Skin del lote y 2 más');
    expect(sections.music.single.displayName, 'As Alive');
    expect(sections.music.single.displayType, DisplayType.MUSICA);
  });

  test('las armas públicas copian daño, cadencia y descartan clips imposibles', () {
    final catalog = weaponsFromPublicBody({
      'data': [
        {
          'id': 'rifle',
          'name': 'Rifle de asalto',
          'rarity': 'Rare',
          'category': 'Assault',
          'images': {'icon': 'https://cdn.example/rifle.png'},
          'stats': {
            'damage': {'close': 30},
            'firingRate': 5.5,
            'clipSize': 30,
            'reloadTime': 2.2,
            'bulletsPerCartridge': 1,
            'headshotMultiplier': 1.5,
          },
        },
        {
          'id': 'energia',
          'name': 'Bláster',
          'rarity': 'Common',
          'images': {'icon': 'https://cdn.example/blaster.png'},
          'stats': {
            'damage': {'close': 27},
            'clipSize': 1000000,
            'firingRate': 4,
          },
        },
        {
          'id': 'sin-dano',
          'name': 'Vacío',
          'images': {'icon': 'https://cdn.example/empty.png'},
          'stats': {'damage': {'close': 0}},
        },
      ],
    });

    expect(catalog.weapons, hasLength(2));
    expect(catalog.weapons!.first.mainStats?.dmgPb, 27);
    expect(catalog.weapons!.first.mainStats?.clipSize, isNull);
    expect(catalog.weapons!.last.rarity, isNotNull);
    expect(catalog.weapons!.last.mainStats?.clipSize, 30);
  });

  test('las estadísticas públicas usan las claves que pinta el perfil', () {
    final stats = PlayerStatsResponseModel.fromPublicBody({
      'data': {
        'account': {'name': 'Ninja'},
        'battlePass': {'level': 40, 'progress': 12},
        'stats': {
          'all': {
            'solo': {'kd': 2.5, 'winRate': 8, 'kills': 100, 'matches': 40, 'top10': 9, 'top25': 20, 'score': 1500, 'minutesPlayed': 300},
          },
        },
      },
    }).toEntity();

    expect(stats.name, 'Ninja');
    expect(stats.account?.level, 40);
    expect(stats.globalStats?.solo?['kd'], 2.5);
    expect(stats.globalStats?.solo?['winrate'], 8);
    expect(stats.globalStats?.solo?['placetop10'], 9);
    expect(stats.globalStats?.solo?['matchesplayed'], 40);
  });
}
