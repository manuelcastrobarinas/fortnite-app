import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/items/data/models/items_response_model.dart';

abstract class ItemsRemoteDataSource {
  Future<ItemsResponseModel> fetchItems();
}

class ItemsRemoteDataSourceImpl implements ItemsRemoteDataSource {
  const ItemsRemoteDataSourceImpl(this._client);

  final LimitedApiClient _client;

  @override
  Future<ItemsResponseModel> fetchItems() async {
    final response = await _client.get(ApiPaths.lootList);
    throwIfUnsuccessful(response);
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('La respuesta de armas no es un objeto JSON');
    }
    return ItemsResponseModel.fromJson(data);
  }
}
