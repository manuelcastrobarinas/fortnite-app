import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/errors/api_errors.dart';
import 'package:fortnite_app/models/items/items.dart';

import '../interceptors/interceptors.dart';

class ItemServices {
  final Dio _dio;
  final String _apiUrl = dotenv.get('API_LIMITED_URL');

  ItemServices() : _dio = Dio()
    ..interceptors.add(AuthorizationInterceptor())
    ..interceptors.add(LanguageIterceptor());

  Future<ItemsModel> getItemsGame() async {
    try {
    final String url = '$_apiUrl/loot/list';
    final response = await _dio.get(url);
    final itemsModel = ItemsModel.fromJson(response.data);
    if (itemsModel.weapons == null || itemsModel.weapons!.isEmpty) throw Exception('No hay información de las Armas');
    return itemsModel;
    } catch (e) {
      throw CustomApiErrors.fromError(e);
    }
  }
}