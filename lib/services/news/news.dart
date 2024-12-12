import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/errors/api_errors.dart';
import 'package:fortnite_app/services/interceptors/interceptors.dart';

import '../../models/news/news.dart';

class NewsServices {

  final Dio _dio =  Dio()
    ..interceptors.add(AuthorizationInterceptor())
    ..interceptors.add(LanguageIterceptor());
  final String _apiUrl = dotenv.get("API_LIMITED_URL");
 
  Future<NewsModel> getNews() async {
    try {
      final String url = '$_apiUrl/news';
      final response = await _dio.get(url);
      return NewsModel.fromJson(response.data);
    } catch (e) {
      throw CustomApiErrors.fromError(e);
    }
  }
}