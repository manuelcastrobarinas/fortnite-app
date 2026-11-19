import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';

abstract class NewsRepository {
  Future<Result<NewsModel>> getNews();
}
