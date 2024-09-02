import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/errors/api_errors.dart';
import 'package:fortnite_app/models/players/player_id.dart';
import 'package:fortnite_app/models/players/player_stats.dart';
import 'package:fortnite_app/services/interceptors/interceptors.dart';

class PlayerServices {
  final Dio _dio = Dio()
    ..interceptors.add(AuthorizationInterceptor())
    ..interceptors.add(LanguageIterceptor());
  
  final String _url = dotenv.get("API_LIMITED_URL");
  
  PlayerStatsModel? playerStatsModel;
  PlayerIDmodel? _playerId;

  Future<String> getUserID({required String userName}) async {
    try {
      final String url = '$_url/lookup?username=$userName';
      final Response<dynamic> respose = await _dio.get(url);
      _playerId = PlayerIDmodel.fromJson(respose.data);
      if (_playerId!.result == false) return 'La cuenta ingresada no existe';
      return 'success';
     } catch (e) {
      return throw CustomApiErrors.fromError(e);
    }
  }

  Future<String> getUserStats() async {
    try {
      final String url = '$_url/stats?account=${_playerId!.accountId}';
      final Response<dynamic> response = await _dio.get(url);
      playerStatsModel = PlayerStatsModel.fromJson(response.data);
      return 'success';
    } catch (e) {
      return throw CustomApiErrors.fromError(e);
    }
  }
}