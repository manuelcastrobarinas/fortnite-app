import 'package:fortnite_app/features/news/domain/entities/news.dart';

/// DTO de la respuesta `/news`. El datasource solo conoce este modelo;
/// el repositorio entrega la entidad [NewsModel].
class NewsResponseModel {
  const NewsResponseModel(this.feed);

  final NewsModel feed;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(NewsModel.fromJson(json));
  }

  NewsModel toEntity() => feed;
}
