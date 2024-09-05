import 'dart:convert';

class PlayerIDmodel {
  bool? result;
  String? accountId;

  PlayerIDmodel({
      this.result,
      this.accountId,
  });

  PlayerIDmodel copyWith({
      bool? result,
      String? accountId,
  }) => 
      PlayerIDmodel(
          result: result ?? this.result,
          accountId: accountId ?? this.accountId,
      );

  factory PlayerIDmodel.fromRawJson(String str) => PlayerIDmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerIDmodel.fromJson(Map<String, dynamic> json) => PlayerIDmodel(
      result: json["result"],
      accountId: json["account_id"],
  );

  Map<String, dynamic> toJson() => {
      "result": result,
      "account_id": accountId,
  };
}
