import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/items/data/models/items_response_model.dart';
import 'package:fortnite_app/features/items/data/models/public_weapons_mapper.dart';

abstract class ItemsRemoteDataSource {
  Future<ItemsResponseModel> fetchItems();
}

class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  const ItemsRemoteDataSourceImpl(this._client);

  final CatalogApiClient _client;

  static const _categories = ['Assault', 'Shotgun', 'Sniper', 'SMG', 'Pistol'];

  @override
  Future<ItemsResponseModel> fetchItems() async {
    final pages = await Future.wait(
      _categories.map(
        (category) => _client.get(
          ApiPaths.weapons,
          queryParameters: {
            'category': category,
            'hasStats': true,
            'hasIcon': true,
            'limit': 40,
            'sort': 'name',
          },
        ),
      ),
    );

    final weapons = <Map<String, dynamic>>[];
    for (final response in pages) {
      throwIfUnsuccessful(response);
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const FormatException('La respuesta de armas no es un objeto JSON');
      }
      final list = data['data'];
      if (list is! List) {
        throw const FormatException('La respuesta de armas no trae data');
      }
      for (final item in list) {
        if (item is Map) weapons.add(Map<String, dynamic>.from(item));
      }
    }
    return ItemsResponseModel(
      weaponsFromPublicBody({'data': weapons}),
    );
  }
}
