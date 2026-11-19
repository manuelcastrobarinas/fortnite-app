import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/domain/repositories/news_repository.dart';

class GetNewsUseCase {
  const GetNewsUseCase(this._repository);

  final NewsRepository _repository;

  Future<Result<NewsModel>> call() => _repository.getNews();
}
