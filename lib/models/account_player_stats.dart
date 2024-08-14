import 'dart:convert';

class AccountPlayerStats {
  bool? result;
  String? name;
  Account? account;
  List<Account>? accountLevelHistory;
  GlobalStats? globalStats;
  PerInput? perInput;
  List<int>? seasonsAvailable;

  AccountPlayerStats({
    this.result,
    this.name,
    this.account,
    this.accountLevelHistory,
    this.globalStats,
    this.perInput,
    this.seasonsAvailable,
  });

  factory AccountPlayerStats.fromRawJson(String str) => AccountPlayerStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountPlayerStats.fromJson(Map<String, dynamic> json) => AccountPlayerStats(
    result: json["result"],
    name: json["name"],
    account: json["account"] == null ? null : Account.fromJson(json["account"]),
    accountLevelHistory: json["accountLevelHistory"] == null ? [] : List<Account>.from(json["accountLevelHistory"]!.map((x) => Account.fromJson(x))),
    globalStats: json["global_stats"] == null ? null : GlobalStats.fromJson(json["global_stats"]),
    perInput: json["per_input"] == null ? null : PerInput.fromJson(json["per_input"]),
    seasonsAvailable: json["seasons_available"] == null ? [] : List<int>.from(json["seasons_available"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "name": name,
    "account": account?.toJson(),
    "accountLevelHistory": accountLevelHistory == null ? [] : List<dynamic>.from(accountLevelHistory!.map((x) => x.toJson())),
    "global_stats": globalStats?.toJson(),
    "per_input": perInput?.toJson(),
    "seasons_available": seasonsAvailable == null ? [] : List<dynamic>.from(seasonsAvailable!.map((x) => x)),
  };
}

class Account {
  int? season;
  int? level;
  int? processPct;

  Account({
    this.season,
    this.level,
    this.processPct,
  });

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    season: json["season"],
    level: json["level"],
    processPct: json["process_pct"],
  );

  Map<String, dynamic> toJson() => {
    "season": season,
    "level": level,
    "process_pct": processPct,
  };
}

class GlobalStats {
  Map<String, double>? duo;
  Map<String, double>? squad;
  Map<String, double>? trio;
  Map<String, double>? solo;

  GlobalStats({
    this.duo,
    this.squad,
    this.trio,
    this.solo,
  });

  factory GlobalStats.fromRawJson(String str) => GlobalStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalStats.fromJson(Map<String, dynamic> json) => GlobalStats(
    solo  : Map.from(json["solo"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    duo   : Map.from(json["duo"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    trio  : Map.from(json["trio"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    squad : Map.from(json["squad"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "solo"  : Map.from(solo!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "duo"   : Map.from(duo!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "trio"  : Map.from(trio!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "squad" : Map.from(squad!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class PerInput {
  GlobalStats? keyboardmouse;
  Gamepad? gamepad;

  PerInput({
    this.keyboardmouse,
    this.gamepad,
  });

  factory PerInput.fromRawJson(String str) => PerInput.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PerInput.fromJson(Map<String, dynamic> json) => PerInput(
    keyboardmouse: json["keyboardmouse"] == null ? null : GlobalStats.fromJson(json["keyboardmouse"]),
    gamepad: json["gamepad"] == null ? null : Gamepad.fromJson(json["gamepad"]),
  );

  Map<String, dynamic> toJson() => {
    "keyboardmouse": keyboardmouse?.toJson(),
    "gamepad": gamepad?.toJson(),
  };
}

class Gamepad {
  Map<String, double>? solo;
  Map<String, double>? squad;

  Gamepad({
    this.solo,
    this.squad,
  });

  factory Gamepad.fromRawJson(String str) => Gamepad.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gamepad.fromJson(Map<String, dynamic> json) => Gamepad(
    solo: Map.from(json["solo"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    squad: Map.from(json["squad"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "solo": Map.from(solo!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "squad": Map.from(squad!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
