import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/errors/api_errors.dart';
import 'package:fortnite_app/models/shop/shop_limited.dart';
import 'package:fortnite_app/services/interceptors/interceptors.dart';

class ShopServices {

  final Dio _dio = Dio()
    ..interceptors.add(AuthorizationInterceptor())
    ..interceptors.add(LanguageIterceptor());

  ShopLimited? shopLimited;
  final String _url = dotenv.get("API_LIMITED_URL_V2");
  
  
  Future<String> getShop() async {
    try {
      final String url = '$_url/shop';
      final Response<dynamic> response = await _dio.get(url);
      shopLimited = ShopLimited.fromJson(response.data);
      return 'success';
    } catch (e) {
      return throw CustomApiErrors.fromError(e);
    }
  }
}