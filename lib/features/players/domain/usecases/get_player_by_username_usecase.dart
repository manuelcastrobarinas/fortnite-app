import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/players/domain/entities/player_profile.dart';
import 'package:fortnite_app/features/players/domain/repositories/player_repository.dart';

class GetPlayerByUsernameUseCase {
  const GetPlayerByUsernameUseCase(this._repository);

  final PlayerRepository _repository;

  Future<Result<PlayerProfile>> call(String username) =>
      _repository.getByUsername(username);
}
