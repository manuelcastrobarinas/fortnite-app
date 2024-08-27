import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/errors/api_errors.dart';
import 'package:fortnite_app/models/items/items.dart';

import '../interceptors/interceptors.dart';

class ItemServices {
  final Dio _dio;
  final String _apiUrl = dotenv.get('API_LIMITED_URL');
  ItemsModel? itemsModel;

  ItemServices() : _dio = Dio()
    ..interceptors.add(AuthorizationInterceptor())
    ..interceptors.add(LanguageIterceptor());

  Future<String> getItemsGame() async {
    try {
    final String url = '$_apiUrl/loot/list';
    final response = await _dio.get(url);
    itemsModel = ItemsModel.fromJson(response.data);
    return 'success';
    } catch (e) {
      return throw CustomApiErrors.fromError(e);
    }
  }
}