import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/island/data/datasources/island_remote_datasource.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';
import 'package:fortnite_app/features/island/domain/repositories/island_repository.dart';

class IslandRepositoryImpl implements IslandRepository {
  const IslandRepositoryImpl(this._remote);

  final IslandRemoteDataSource _remote;

  @override
  Future<Result<BrMap>> getMap() => _run(() async {
        final map = await _remote.fetchMap();
        if (map.displayImageUrl == null && map.pois.isEmpty) {
          throw const BusinessException('EMPTY_MAP');
        }
        return map;
      });

  @override
  Future<Result<List<GameMode>>> getModes() => _run(() async {
        final modes = await _remote.fetchModes();
        if (modes.isEmpty) throw const BusinessException('EMPTY_MODES');
        return modes;
      });

  @override
  Future<Result<List<NewCosmetic>>> getNewCosmetics() => _run(() async {
        final cosmetics = await _remote.fetchNewCosmetics();
        if (cosmetics.isEmpty) {
          throw const BusinessException('EMPTY_NEW_COSMETICS');
        }
        return cosmetics;
      });

  @override
  Future<Result<CreatorCode>> getCreatorCode(String name) => _run(() async {
        final code = name.trim();
        if (code.isEmpty) throw const BusinessException('CREATOR_CODE_EMPTY');
        return _remote.fetchCreatorCode(code);
      });

  Future<Result<T>> _run<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } catch (error) {
      return Err(FailureMapper.fromError(error));
    }
  }
}
