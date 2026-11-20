import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/players/data/models/player_account_response_model.dart';
import 'package:fortnite_app/features/players/data/models/player_stats_response_model.dart';
import 'package:fortnite_app/features/players/domain/entities/player_account.dart';

abstract class PlayerRemoteDataSource {
  Future<PlayerAccountResponseModel> lookup(String username);

  /// Null cuando no hay llave de fortnite-api.com. La cuenta igual se puede mostrar.
  Future<PlayerStatsResponseModel?> fetchStats(String username);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  const PlayerRemoteDataSourceImpl(
    this._catalog,
    this._stats, {
    this.statsApiKey,
  });

  final CatalogApiClient _catalog;
  final PublicApiClient _stats;
  final String? statsApiKey;

  @override
  Future<PlayerAccountResponseModel> lookup(String username) async {
    final response = await _catalog.get(
      ApiPaths.accountLookup,
      queryParameters: {'name': username},
    );
    throwIfUnsuccessful(response);
    final data = response.data;
    if (data is! Map) {
      throw const FormatException('La respuesta de cuenta no es un objeto JSON');
    }
    final exact = data['exact'];
    if (exact is! List || exact.isEmpty || exact.first is! Map) {
      throw const BusinessException('ACCOUNT_NOT_FOUND');
    }
    final account = Map<String, dynamic>.from(exact.first as Map);
    final accountId = account['accountId']?.toString() ?? '';
    final displayName = account['displayName']?.toString().trim();
    if (accountId.isEmpty) {
      throw const BusinessException('ACCOUNT_NOT_FOUND');
    }
    return PlayerAccountResponseModel(
      PlayerIDmodel(
        result: true,
        accountId: accountId,
        name: (displayName == null || displayName.isEmpty) ? username : displayName,
      ),
    );
  }

  @override
  Future<PlayerStatsResponseModel?> fetchStats(String username) async {
    final key = statsApiKey;
    if (key == null || key.isEmpty) return null;
    final response = await _stats.get(
      ApiPaths.publicStats,
      queryParameters: {'name': username},
      headers: {'Authorization': key},
    );
    throwIfUnsuccessful(response);
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('La respuesta de estadísticas no es un objeto JSON');
    }
    return PlayerStatsResponseModel.fromPublicBody(data);
  }
}
