import 'package:fortnite_app/features/players/domain/entities/player_account.dart';
import 'package:fortnite_app/features/players/domain/entities/player_stats.dart';

/// Cuenta resuelta junto con sus estadísticas. Es lo que el caso de uso
/// entrega a presentation después de las dos llamadas (lookup + stats).
class PlayerProfile {
  const PlayerProfile({required this.account, required this.stats});

  final PlayerIDmodel account;
  final PlayerStatsModel stats;
}
