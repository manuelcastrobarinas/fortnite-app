import 'package:fortnite_app/features/players/domain/entities/player_stats.dart';

class PlayerStatsResponseModel {
  const PlayerStatsResponseModel(this.stats);

  final PlayerStatsModel stats;

  factory PlayerStatsResponseModel.fromJson(Map<String, dynamic> json) {
    return PlayerStatsResponseModel(PlayerStatsModel.fromJson(json));
  }

  /// fortnite-api.com `/v2/stats/br/v2`. Las claves quedan como las lee la UI.
  factory PlayerStatsResponseModel.fromPublicBody(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map) {
      throw const FormatException('La respuesta de estadísticas no trae data');
    }
    final account = data['account'];
    final battlePass = data['battlePass'];
    final all = data['stats'] is Map ? (data['stats'] as Map)['all'] : null;
    final modes = all is Map ? all : const {};
    return PlayerStatsResponseModel(
      PlayerStatsModel(
        result: true,
        name: account is Map ? account['name']?.toString() : null,
        account: Account(
          level: battlePass is Map ? _asInt(battlePass['level']) : null,
          processPct: battlePass is Map ? _asInt(battlePass['progress']) : null,
        ),
        globalStats: GlobalStats(
          solo: _mode(modes['solo']),
          duo: _mode(modes['duo']),
          trio: _mode(modes['trio']),
          squad: _mode(modes['squad']),
        ),
      ),
    );
  }

  PlayerStatsModel toEntity() => stats;
}

Map<String, double>? _mode(dynamic raw) {
  if (raw is! Map) return null;
  double number(String key) {
    final value = raw[key];
    return value is num ? value.toDouble() : 0;
  }

  return {
    'kd': number('kd'),
    'winrate': number('winRate'),
    'score': number('score'),
    'placetop3': number('top3'),
    'placetop5': number('top5'),
    'placetop10': number('top10'),
    'placetop12': number('top12'),
    'placetop25': number('top25'),
    'kills': number('kills'),
    'matchesplayed': number('matches'),
    'minutesplayed': number('minutesPlayed'),
  };
}

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}
