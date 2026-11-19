// ignore_for_file: constant_identifier_names
import 'dart:convert';

class ItemsModel {
  bool? result;
  String? lang;
  List<Weapon>? weapons;

  ItemsModel({
    this.result,
    this.lang,
    this.weapons,
  });

  factory ItemsModel.fromRawJson(String str) => ItemsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
      result: json["result"],
      lang: json["lang"],
      weapons: json["weapons"] == null ? [] : List<Weapon>.from(json["weapons"]!.map((x) => Weapon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "result": result,
      "lang": lang,
      "weapons": weapons == null ? [] : List<dynamic>.from(weapons!.map((x) => x.toJson())),
  };
}

class Weapon {
  String? id;
  bool? enabled;
  String? name;
  String? description;
  Rarity? rarity;
  Type? type;
  List<String>? gameplayTags;
  String? searchTags;
  Images? images;
  MainStats? mainStats;

  Weapon({
    this.id,
    this.enabled,
    this.name,
    this.description,
    this.rarity,
    this.type,
    this.gameplayTags,
    this.searchTags,
    this.images,
    this.mainStats,
  });

  factory Weapon.fromRawJson(String str) => Weapon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
      id: json["id"],
      enabled: json["enabled"],
      name: json["name"],
      description: json["description"],
      rarity: rarityValues.map[json["rarity"]]!,
      type: typeValues.map[json["type"]]!,
      gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
      searchTags: json["searchTags"],
      images: json["images"] == null ? null : Images.fromJson(json["images"]),
      mainStats: json["mainStats"] == null ? null : MainStats.fromJson(json["mainStats"]),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "enabled": enabled,
      "name": name,
      "description": description,
      "rarity": rarityValues.reverse[rarity],
      "type": typeValues.reverse[type],
      "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
      "searchTags": searchTags,
      "images": images?.toJson(),
      "mainStats": mainStats?.toJson(),
  };
}

class Images {
  String? icon;
  String? background;

  Images({
    this.icon,
    this.background,
  });

  factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    icon: json["icon"],
    background: json["background"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "background": background,
  };
}

class MainStats {
  double? dmgPb;
  double? firingRate;
  int? clipSize;
  double? reloadTime;
  int? bulletsPerCartridge;
  double? spread;
  double? spreadDownsights;
  double? damageZoneCritical;

  MainStats({
    this.dmgPb,
    this.firingRate,
    this.clipSize,
    this.reloadTime,
    this.bulletsPerCartridge,
    this.spread,
    this.spreadDownsights,
    this.damageZoneCritical,
  });

  factory MainStats.fromRawJson(String str) => MainStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainStats.fromJson(Map<String, dynamic> json) => MainStats(
    dmgPb: json["DmgPB"]?.toDouble(),
    firingRate: json["FiringRate"]?.toDouble(),
    clipSize: json["ClipSize"],
    reloadTime: json["ReloadTime"]?.toDouble(),
    bulletsPerCartridge: json["BulletsPerCartridge"],
    spread: json["Spread"]?.toDouble(),
    spreadDownsights: json["SpreadDownsights"]?.toDouble(),
    damageZoneCritical: json["DamageZone_Critical"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "DmgPB": dmgPb,
    "FiringRate": firingRate,
    "ClipSize": clipSize,
    "ReloadTime": reloadTime,
    "BulletsPerCartridge": bulletsPerCartridge,
    "Spread": spread,
    "SpreadDownsights": spreadDownsights,
    "DamageZone_Critical": damageZoneCritical,
  };
}

enum Rarity {
  COMMON,
  EPIC,
  EXOTIC,
  LEGENDARY,
  MYTHIC,
  RARE,
  TRANSCENDENT,
  UNATTAINABLE,
  UNCOMMON
}

final rarityValues = EnumValues({
  "common": Rarity.COMMON,
  "epic": Rarity.EPIC,
  "exotic": Rarity.EXOTIC,
  "legendary": Rarity.LEGENDARY,
  "mythic": Rarity.MYTHIC,
  "rare": Rarity.RARE,
  "transcendent": Rarity.TRANSCENDENT,
  "unattainable": Rarity.UNATTAINABLE,
  "uncommon": Rarity.UNCOMMON
});

enum Type {
  BOSS,
  SEASONAL,
  STANDARD,
  STARWARS,
  SWORD
}

final typeValues = EnumValues({
  "boss": Type.BOSS,
  "seasonal": Type.SEASONAL,
  "standard": Type.STANDARD,
  "starwars": Type.STARWARS,
  "sword": Type.SWORD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
