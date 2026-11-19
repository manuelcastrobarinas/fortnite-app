import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this._remote);

  final NewsRemoteDataSource _remote;

  @override
  Future<Result<NewsModel>> getNews() => _run(() async {
        final model = await _remote.fetchNews();
        final feed = model.toEntity();
        if (feed.news == null || feed.news!.isEmpty) {
          throw const BusinessException('EMPTY_NEWS');
        }
        return feed;
      });

  Future<Result<T>> _run<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } catch (error) {
      return Err(FailureMapper.fromError(error));
    }
  }
}
