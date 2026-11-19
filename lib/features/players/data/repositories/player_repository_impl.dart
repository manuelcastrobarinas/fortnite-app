import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/errors/failure_mapper.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/players/data/datasources/player_remote_datasource.dart';
import 'package:fortnite_app/features/players/domain/entities/player_profile.dart';
import 'package:fortnite_app/features/players/domain/repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  const PlayerRepositoryImpl(this._remote);

  final PlayerRemoteDataSource _remote;

  @override
  Future<Result<PlayerProfile>> getByUsername(String username) => _run(() async {
        final accountModel = await _remote.lookup(username);
        final account = accountModel.toEntity();
        if (account.result == false) {
          throw const BusinessException('ACCOUNT_NOT_FOUND');
        }
        final accountId = account.accountId;
        if (accountId == null || accountId.isEmpty) {
          throw const BusinessException('ACCOUNT_ID_MISSING');
        }
        final stats = (await _remote.fetchStats(accountId)).toEntity();
        return PlayerProfile(account: account, stats: stats);
      });

  Future<Result<T>> _run<T>(Future<T> Function() body) async {
    try {
      return Ok(await body());
    } catch (error) {
      return Err(FailureMapper.fromError(error));
    }
  }
}
