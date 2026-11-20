import 'dart:convert';

class PlayerIDmodel {
  bool? result;
  String? accountId;
  String? name;

  PlayerIDmodel({
      this.result,
      this.accountId,
      this.name,
  });

  PlayerIDmodel copyWith({
      bool? result,
      String? accountId,
      String? name,
  }) => 
      PlayerIDmodel(
          result: result ?? this.result,
          accountId: accountId ?? this.accountId,
          name: name ?? this.name,
      );

  factory PlayerIDmodel.fromRawJson(String str) => PlayerIDmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerIDmodel.fromJson(Map<String, dynamic> json) => PlayerIDmodel(
      result: json["result"],
      accountId: json["account_id"],
      name: json["name"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
      "result": result,
      "account_id": accountId,
      "name": name,
  };
}
