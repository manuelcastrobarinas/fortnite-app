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
  
  Future<PlayerIDmodel> getUserID({required String userName}) async {
    try {
      final String url = '$_url/lookup?username=$userName';
      final Response<dynamic> respose = await _dio.get(url);
      final PlayerIDmodel playerId = PlayerIDmodel.fromJson(respose.data);
      if (playerId.result == false) throw Exception('La cuenta ingresada no existe');
      return playerId;
     } catch (e) {
      throw CustomApiErrors.fromError(e);
    }
  }

  Future<PlayerStatsModel> getUserStats({required String accountId}) async {
    try {
      final String url = '$_url/stats?account=$accountId';
      final Response<dynamic> response = await _dio.get(url);
      final PlayerStatsModel playerStats = PlayerStatsModel.fromJson(response.data);
      return playerStats;
    } catch (e) {
      throw CustomApiErrors.fromError(e);
    }
  }
}