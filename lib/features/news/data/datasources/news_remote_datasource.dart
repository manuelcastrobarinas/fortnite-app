import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/news/data/models/news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponseModel> fetchNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  const NewsRemoteDataSourceImpl(this._client);

  final PublicApiClient _client;

  @override
  Future<NewsResponseModel> fetchNews() async {
    final response = await _client.get(ApiPaths.publicNews);
    throwIfUnsuccessful(response);
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('La respuesta de noticias no es un objeto JSON');
    }
    return NewsResponseModel.fromPublicBody(data);
  }
}
