import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/players/domain/entities/player_profile.dart';

abstract class PlayerRepository {
  Future<Result<PlayerProfile>> getByUsername(String username);
}
