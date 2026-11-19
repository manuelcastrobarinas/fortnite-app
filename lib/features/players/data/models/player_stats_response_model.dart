import 'package:fortnite_app/features/players/domain/entities/player_stats.dart';

class PlayerStatsResponseModel {
  const PlayerStatsResponseModel(this.stats);

  final PlayerStatsModel stats;

  factory PlayerStatsResponseModel.fromJson(Map<String, dynamic> json) {
    return PlayerStatsResponseModel(PlayerStatsModel.fromJson(json));
  }

  PlayerStatsModel toEntity() => stats;
}
