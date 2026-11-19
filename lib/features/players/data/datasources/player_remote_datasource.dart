import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/players/data/models/player_account_response_model.dart';
import 'package:fortnite_app/features/players/data/models/player_stats_response_model.dart';

abstract class PlayerRemoteDataSource {
  Future<PlayerAccountResponseModel> lookup(String username);
  Future<PlayerStatsResponseModel> fetchStats(String accountId);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  const PlayerRemoteDataSourceImpl(this._client);

  final LimitedApiClient _client;

  @override
  Future<PlayerAccountResponseModel> lookup(String username) async {
    final response = await _client.get(
      ApiPaths.lookup,
      queryParameters: {'username': username},
    );
    throwIfUnsuccessful(response);
    return PlayerAccountResponseModel.fromJson(_asMap(response.data, 'cuenta'));
  }

  @override
  Future<PlayerStatsResponseModel> fetchStats(String accountId) async {
    final response = await _client.get(
      ApiPaths.stats,
      queryParameters: {'account': accountId},
    );
    throwIfUnsuccessful(response);
    return PlayerStatsResponseModel.fromJson(_asMap(response.data, 'estadísticas'));
  }

  Map<String, dynamic> _asMap(dynamic data, String resource) {
    if (data is Map<String, dynamic>) return data;
    throw FormatException('La respuesta de $resource no es un objeto JSON');
  }
}
