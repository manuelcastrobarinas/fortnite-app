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
    season: _asInt(json["season"]),
    level: _asInt(json["level"]),
    processPct: _asInt(json["process_pct"]),
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
    duo: _statMap(json["duo"]),
    squad: _statMap(json["squad"]),
    trio: _statMap(json["trio"]),
    solo: _statMap(json["solo"]),
  );

  Map<String, dynamic> toJson() => {
    "duo": duo,
    "squad": squad,
    "trio": trio,
    "solo": solo,
  };
}

int? _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return null;
}

Map<String, double>? _statMap(dynamic raw) {
  if (raw is! Map) return null;
  final stats = <String, double>{};
  raw.forEach((key, value) {
    if (value is num) stats[key.toString()] = value.toDouble();
  });
  return stats;
}
