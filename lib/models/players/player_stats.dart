import 'dart:convert';

class PlayerStatsModel {
  bool? result;
  String? name;
  Account? account;
  List<Account>? accountLevelHistory;
  GlobalStats? globalStats;
  List<int>? seasonsAvailable;

  PlayerStatsModel({
    this.result,
    this.name,
    this.account,
    this.accountLevelHistory,
    this.globalStats,
    this.seasonsAvailable,
  });

  PlayerStatsModel copyWith({
    bool? result,
    String? name,
    Account? account,
    List<Account>? accountLevelHistory,
    GlobalStats? globalStats,
    List<int>? seasonsAvailable,
  }) => 
  PlayerStatsModel(
    result: result ?? this.result,
    name: name ?? this.name,
    account: account ?? this.account,
    accountLevelHistory: accountLevelHistory ?? this.accountLevelHistory,
    globalStats: globalStats ?? this.globalStats,
    seasonsAvailable: seasonsAvailable ?? this.seasonsAvailable,
  );

  factory PlayerStatsModel.fromRawJson(String str) => PlayerStatsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerStatsModel.fromJson(Map<String, dynamic> json) => PlayerStatsModel(
    result: json["result"],
    name: json["name"],
    account: json["account"] == null ? null : Account.fromJson(json["account"]),
    accountLevelHistory: json["accountLevelHistory"] == null ? [] : List<Account>.from(json["accountLevelHistory"]!.map((x) => Account.fromJson(x))),
    globalStats: json["global_stats"] == null ? null : GlobalStats.fromJson(json["global_stats"]),
    seasonsAvailable: json["seasons_available"] == null ? [] : List<int>.from(json["seasons_available"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "name": name,
    "account": account?.toJson(),
    "accountLevelHistory": accountLevelHistory == null ? [] : List<dynamic>.from(accountLevelHistory!.map((x) => x.toJson())),
    "global_stats": globalStats?.toJson(),
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

  Account copyWith({
    int? season,
    int? level,
    int? processPct,
  }) => 
  Account(
    season: season ?? this.season,
    level: level ?? this.level,
    processPct: processPct ?? this.processPct,
  );

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

  GlobalStats copyWith({
    Map<String, double>? duo,
    Map<String, double>? squad,
    Map<String, double>? trio,
    Map<String, double>? solo,
  }) => 
  GlobalStats(
    duo: duo ?? this.duo,
    squad: squad ?? this.squad,
    trio: trio ?? this.trio,
    solo: solo ?? this.solo,
  );

  factory GlobalStats.fromRawJson(String str) => GlobalStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlobalStats.fromJson(Map<String, dynamic> json) => GlobalStats(
    duo:   json["duo"] == null ? null : Map.from(json["duo"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    squad: json["squad"] == null ? null : Map.from(json["squad"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    trio:  json["trio"] == null ? null : Map.from(json["trio"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    solo:  json["solo"] == null ? null : Map.from(json["solo"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "duo": Map.from(duo!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "squad": Map.from(squad!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "trio": Map.from(trio!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "solo": Map.from(solo!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
