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
 
  NewsModel? newsModel;
  
  Future<String> getNews() async {
    try {
      final String url = '$_apiUrl/news';
      final response = await _dio.get(url);
      newsModel = NewsModel.fromJson(response.data);
      return 'success';
    } catch (e) {
      return throw CustomApiErrors.fromError(e);
    }
  }
}