import 'package:fortnite_app/core/constants/api_paths.dart';
import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/core/network/response_guard.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';

abstract class IslandRemoteDataSource {
  Future<BrMap> fetchMap();

  Future<List<GameMode>> fetchModes();

  Future<List<NewCosmetic>> fetchNewCosmetics();

  Future<CreatorCode> fetchCreatorCode(String name);
}

class IslandRemoteDataSourceImpl implements IslandRemoteDataSource {
  const IslandRemoteDataSourceImpl(this._client);

  final PublicApiClient _client;

  @override
  Future<BrMap> fetchMap() async {
    final response = await _client.get(ApiPaths.publicMap);
    throwIfUnsuccessful(response);
    return BrMap.fromJson(_objectData(response.data, 'mapa'));
  }

  @override
  Future<List<GameMode>> fetchModes() async {
    final response = await _client.get(ApiPaths.publicPlaylists);
    throwIfUnsuccessful(response);
    return GameMode.fromApiList(_listData(response.data, 'modos'));
  }

  @override
  Future<List<NewCosmetic>> fetchNewCosmetics() async {
    final response = await _client.get(ApiPaths.publicNewCosmetics);
    throwIfUnsuccessful(response);
    final data = _objectData(response.data, 'novedades');
    final items = data['items'];
    if (items is! Map) {
      throw const FormatException('La respuesta de novedades no trae items');
    }
    return NewCosmetic.fromGroups(Map<String, dynamic>.from(items));
  }

  @override
  Future<CreatorCode> fetchCreatorCode(String name) async {
    final response = await _client.get(
      ApiPaths.publicCreatorCode,
      queryParameters: {'name': name},
    );
    if (response.statusCode == 404) {
      throw const BusinessException('CREATOR_CODE_NOT_FOUND');
    }
    throwIfUnsuccessful(response);
    final code = CreatorCode.fromJson(
      _objectData(response.data, 'código de creador'),
    );
    if (code.code.isEmpty) {
      throw const BusinessException('CREATOR_CODE_NOT_FOUND');
    }
    return code;
  }
}

Map<String, dynamic> _objectData(dynamic body, String label) {
  final data = _unwrap(body, label);
  if (data is! Map) {
    throw FormatException('La respuesta de $label no es un objeto');
  }
  return Map<String, dynamic>.from(data);
}

List<dynamic> _listData(dynamic body, String label) {
  final data = _unwrap(body, label);
  if (data is! List) {
    throw FormatException('La respuesta de $label no es una lista');
  }
  return data;
}

dynamic _unwrap(dynamic body, String label) {
  if (body is! Map) {
    throw FormatException('La respuesta de $label no es JSON');
  }
  final map = Map<String, dynamic>.from(body);
  if (!map.containsKey('data')) {
    throw FormatException('La respuesta de $label no trae data');
  }
  return map['data'];
}
