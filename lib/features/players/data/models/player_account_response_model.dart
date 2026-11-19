import 'package:fortnite_app/features/players/domain/entities/player_account.dart';

class PlayerAccountResponseModel {
  const PlayerAccountResponseModel(this.account);

  final PlayerIDmodel account;

  factory PlayerAccountResponseModel.fromJson(Map<String, dynamic> json) {
    return PlayerAccountResponseModel(PlayerIDmodel.fromJson(json));
  }

  PlayerIDmodel toEntity() => account;
}
