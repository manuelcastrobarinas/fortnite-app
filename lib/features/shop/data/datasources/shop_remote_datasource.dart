import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/shop/data/models/shop_limited_response_model.dart';

abstract class ShopRemoteDataSource {
  Future<ShopLimitedResponseModel> fetchShop();
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  const ShopRemoteDataSourceImpl(this._client);

  final ShopApiClient _client;

  @override
  Future<ShopLimitedResponseModel> fetchShop() async {
    final response = await _client.get(ApiPaths.shop);
    throwIfUnsuccessful(response);
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('La respuesta de la tienda no es un objeto JSON');
    }
    return ShopLimitedResponseModel.fromJson(data);
  }
}
