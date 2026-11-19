// ignore_for_file: constant_identifier_names

import 'dart:convert';

class ShopLimited {
  bool? result;   //RESULTADO POSITIVO O NEGATIVO
  bool? fullShop; //SABER SI ES TODA LA TIENDA
  LastUpdate? lastUpdate; //ULTIMA ACTUALIZACION EN LA TIENDA
  List<Shop>? shop; //INFORMACION DE LA TIENDA

  ShopLimited({
    this.result,
    this.fullShop,
    this.lastUpdate,
    this.shop,
  });

  factory ShopLimited.fromRawJson(String str) => ShopLimited.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopLimited.fromJson(Map<String, dynamic> json) => ShopLimited(
    result: json["result"],
    fullShop: json["fullShop"],
    lastUpdate: json["lastUpdate"] == null ? null : LastUpdate.fromJson(json["lastUpdate"]),
    shop: json["shop"] == null ? [] : List<Shop>.from(json["shop"]!.map((x) => Shop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "fullShop": fullShop,
    "lastUpdate": lastUpdate?.toJson(),
    "shop": shop == null ? [] : List<dynamic>.from(shop!.map((x) => x.toJson())),
  };
}

class LastUpdate {
  DateTime? date;
  String? uid;

  LastUpdate({
    this.date,
    this.uid,
  });

  factory LastUpdate.fromRawJson(String str) => LastUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastUpdate.fromJson(Map<String, dynamic> json) => LastUpdate(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "uid": uid,
  };
}

class Shop {
  String? mainId; //ID
  String? displayName; //NOMBRE
  String? displayDescription; //DESCRIPCION
  DisplayType? displayType;
  String? mainType;
  String? offerId;
  String? devName;
  OfferDates? offerDates;
  ColorsItems? colors;
  List<DisplayAsset>? displayAssets;
  DateTime? firstReleaseDate;
  DateTime? previousReleaseDate;
  bool? giftAllowed;
  bool? buyAllowed;
  Price? price;
  Rarity? rarity; //CALIDAD DE LOS OBJETOS
  Rarity? series; //SERIE A LA QUE PERTENECE
  Banner? banner; 
  OfferTag? offerTag;
  List<Granted>? granted; //OBJETOS QUE TRAE
  int? priority;
  Section? section;
  int? groupIndex;
  StoreName? storeName;
  List<dynamic>? categories;

  Shop({
    this.mainId,
    this.section, //TIENE LLA INFORMACION DE LOS PAQUETES, EL ID AL QUE PARTENENCE EL NOMBRE, LA CATEGORIA
    this.displayName,
    this.displayDescription,
    this.displayType,
    this.mainType,
    this.offerId,
    this.devName,
    this.offerDates,
    this.colors,
    this.displayAssets,
    this.firstReleaseDate,
    this.previousReleaseDate,
    this.giftAllowed,
    this.buyAllowed,
    this.price,
    this.rarity,
    this.series,
    this.banner,
    this.offerTag,
    this.granted,
    this.priority,
    this.groupIndex,
    this.storeName,
    this.categories,
  });

  factory Shop.fromRawJson(String str) => Shop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    mainId: json["mainId"],
    displayName: json["displayName"],
    displayDescription: json["displayDescription"],
    displayType: displayTypeValues.map[json["displayType"]],
    mainType: json["mainType"],
    offerId: json["offerId"],
    devName: json["devName"],
    offerDates: json["offerDates"] == null ? null : OfferDates.fromJson(json["offerDates"]),
    colors: json["colors"] == null ? null : ColorsItems.fromJson(json["colors"]),
    displayAssets: json["displayAssets"] == null ? [] : List<DisplayAsset>.from(json["displayAssets"]!.map((x) => DisplayAsset.fromJson(x))),
    firstReleaseDate: json["firstReleaseDate"] == null ? null : DateTime.parse(json["firstReleaseDate"]),
    previousReleaseDate: json["previousReleaseDate"] == null ? null : DateTime.parse(json["previousReleaseDate"]),
    giftAllowed: json["giftAllowed"],
    buyAllowed: json["buyAllowed"],
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
    series: json["series"] == null ? null : Rarity.fromJson(json["series"]),
    banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
    offerTag: json["offerTag"] == null ? null : OfferTag.fromJson(json["offerTag"]),
    granted: json["granted"] == null ? [] : List<Granted>.from(json["granted"]!.map((x) => Granted.fromJson(x))),
    priority: json["priority"],
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    groupIndex: json["groupIndex"],
    storeName: storeNameValues.map[json["storeName"]]!,
    categories: json["categories"] == null ? [] : List<dynamic>.from(json["categories"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mainId": mainId,
    "displayName": displayName,
    "displayDescription": displayDescription,
    "displayType": displayTypeValues.reverse[displayType],
    "mainType": mainType,
    "offerId": offerId,
    "devName": devName,
    "offerDates": offerDates?.toJson(),
    "displayAssets": displayAssets == null ? [] : List<dynamic>.from(displayAssets!.map((x) => x.toJson())),
    "firstReleaseDate": "${firstReleaseDate!.year.toString().padLeft(4, '0')}-${firstReleaseDate!.month.toString().padLeft(2, '0')}-${firstReleaseDate!.day.toString().padLeft(2, '0')}",
    "previousReleaseDate": "${previousReleaseDate!.year.toString().padLeft(4, '0')}-${previousReleaseDate!.month.toString().padLeft(2, '0')}-${previousReleaseDate!.day.toString().padLeft(2, '0')}",
    "giftAllowed": giftAllowed,
    "buyAllowed": buyAllowed,
    "price": price?.toJson(),
    "rarity": rarity?.toJson(),
    "series": series?.toJson(),
    "banner": banner?.toJson(),
    "offerTag": offerTag?.toJson(),
    "granted": granted == null ? [] : List<dynamic>.from(granted!.map((x) => x.toJson())),
    "priority": priority,
    "section": section?.toJson(),
    "groupIndex": groupIndex,
    "storeName": storeNameValues.reverse[storeName],
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
  };
}

class Banner {
    String? id;
    String? name;
    Intensity? intensity;

    Banner({
      this.id,
      this.name,
      this.intensity,
    });

    factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
      id: json["id"],
      name: json["name"],
      intensity: intensityValues.map[json["intensity"]]!,
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "intensity": intensityValues.reverse[intensity],
    };
}

  class ColorsItems {
    String? color1;
    String? color2;
    String? color3;
    String? textBackgroundColor;

    ColorsItems({
      this.color1,
      this.color2,
      this.color3,
      this.textBackgroundColor,
    });

    factory ColorsItems.fromRawJson(String str) => ColorsItems.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ColorsItems.fromJson(Map<String, dynamic> json) => ColorsItems(
      color1: json["color1"],
      color2: json["color2"],
      color3: json["color3"],
      textBackgroundColor: json["textBackgroundColor"],
    );

    Map<String, dynamic> toJson() => {
      "color1": color1,
      "color2": color2,
      "color3": color3,
      "textBackgroundColor": textBackgroundColor,
    };
  }

enum Intensity {
  HIGH,
  LOW
}

final intensityValues = EnumValues({
  "High": Intensity.HIGH,
  "Low": Intensity.LOW
});

class DisplayAsset {
  String? displayAsset;
  String? materialInstance;
  PrimaryMode? primaryMode;
  String? productTag;
  String? url;
  Flipbook? flipbook;
  String? backgroundTexture;
  String? background;
  String? fullBackground;

  DisplayAsset({
    this.displayAsset,
    this.materialInstance,
    this.primaryMode,
    this.productTag,
    this.url,
    this.flipbook,
    this.backgroundTexture,
    this.background,
    this.fullBackground,
  });

  factory DisplayAsset.fromRawJson(String str) => DisplayAsset.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisplayAsset.fromJson(Map<String, dynamic> json) => DisplayAsset(
    displayAsset: json["displayAsset"],
    materialInstance: json["materialInstance"],
    primaryMode: primaryModeValues.map[json["primaryMode"]]!,
    productTag: json["productTag"],
    url: json["url"],
    flipbook: json["flipbook"] == null ? null : Flipbook.fromJson(json["flipbook"]),
    backgroundTexture: json["background_texture"],
    background: json["background"],
    fullBackground: json["full_background"],
  );

  Map<String, dynamic> toJson() => {
    "displayAsset": displayAsset,
    "materialInstance": materialInstance,
    "primaryMode": primaryModeValues.reverse[primaryMode],
    "productTag": productTag,
    "url": url,
    "flipbook": flipbook?.toJson(),
    "background_texture": backgroundTexture,
    "background": background,
    "full_background": fullBackground,
  };
}

class Flipbook {
  String? url;
  int? pages;

  Flipbook({
    this.url,
    this.pages,
  });

  factory Flipbook.fromRawJson(String str) => Flipbook.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Flipbook.fromJson(Map<String, dynamic> json) => Flipbook(
    url: json["url"],
    pages: json["pages"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "pages": pages,
  };
}

enum PrimaryMode {
  BATTLE_ROYALE,
  MAX
}

final primaryModeValues = EnumValues({
  "BattleRoyale": PrimaryMode.BATTLE_ROYALE,
  "MAX": PrimaryMode.MAX
});

enum ProductTag {
  PRODUCT_BR,
  PRODUCT_DEL_MAR,
  PRODUCT_JUNO,
  PRODUCT_SPARKS
}

enum DisplayType {
  ACCESORIO_MOCHILERO,
  ALA_DELTA,
  ENVOLTORIO,
  ESTELA,
  GESTO,
  LOTE_DE_4_OBJETO_S,
  LOTE_DE_5_OBJETO_S,
  LOTE_DE_OBJETOS,
  MUSICA,
  PICOS,
  PLAYSET_PROP,
  TRAJE
}

final displayTypeValues = EnumValues({
  "Accesorio mochilero": DisplayType.ACCESORIO_MOCHILERO,
  "Ala delta": DisplayType.ALA_DELTA,
  "Envoltorio": DisplayType.ENVOLTORIO,
  "Estela": DisplayType.ESTELA,
  "Gesto": DisplayType.GESTO,
  "Lote de 4 objeto(s)": DisplayType.LOTE_DE_4_OBJETO_S,
  "Lote de 5 objeto(s)": DisplayType.LOTE_DE_5_OBJETO_S,
  "Lote de objetos": DisplayType.LOTE_DE_OBJETOS,
  "Música": DisplayType.MUSICA,
  "Picos": DisplayType.PICOS,
  "Playset Prop": DisplayType.PLAYSET_PROP,
  "Traje": DisplayType.TRAJE
});

final Map<DisplayType, String> displayTypeMap = {
  DisplayType.ACCESORIO_MOCHILERO: "Accesorio mochilero",
  DisplayType.ALA_DELTA: "Ala delta",
  DisplayType.ENVOLTORIO: "Envoltorio",
  DisplayType.ESTELA: "Estela",
  DisplayType.GESTO: "Gesto",
  DisplayType.LOTE_DE_4_OBJETO_S: "Lote de 4 objeto(s)",
  DisplayType.LOTE_DE_5_OBJETO_S: "Lote de 5 objeto(s)",
  DisplayType.LOTE_DE_OBJETOS: "Lote de objetos",
  DisplayType.MUSICA: "Música",
  DisplayType.PICOS: "Picos",
  DisplayType.PLAYSET_PROP: "Playset Prop",
  DisplayType.TRAJE: "Traje",
};

class Granted {
  String? id;
  Rarity? type;
  String? name;
  String? description;
  Rarity? rarity;
  Rarity? series;
  Images? images;
  Beans? juno;
  Beans? beans;
  dynamic video;
  dynamic audio;
  List<String>? gameplayTags;
  Set? grantedSet;

  Granted({
    this.id,
    this.type,
    this.name,
    this.description,
    this.rarity,
    this.series,
    this.images,
    this.juno,
    this.beans,
    this.video,
    this.audio,
    this.gameplayTags,
    this.grantedSet,
  });

  factory Granted.fromRawJson(String str) => Granted.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Granted.fromJson(Map<String, dynamic> json) => Granted(
      id: json["id"],
      type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
      name: json["name"],
      description: json["description"],
      rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
      series: json["series"] == null ? null : Rarity.fromJson(json["series"]),
      images: json["images"] == null ? null : Images.fromJson(json["images"]),
      juno: json["juno"] == null ? null : Beans.fromJson(json["juno"]),
      beans: json["beans"] == null ? null : Beans.fromJson(json["beans"]),
      video: json["video"],
      audio: json["audio"],
      gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
      grantedSet: json["set"] == null ? null : Set.fromJson(json["set"]),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "type": type?.toJson(),
      "name": name,
      "description": description,
      "rarity": rarity?.toJson(),
      "series": series?.toJson(),
      "images": images?.toJson(),
      "juno": juno?.toJson(),
      "beans": beans?.toJson(),
      "video": video,
      "audio": audio,
      "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
      "set": grantedSet?.toJson(),
  };
}

class Beans {
    String? icon;

    Beans({
        this.icon,
    });

    factory Beans.fromRawJson(String str) => Beans.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Beans.fromJson(Map<String, dynamic> json) => Beans(
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "icon": icon,
    };
}

class Set {
    String? id;
    String? name;
    String? partOf;

    Set({
        this.id,
        this.name,
        this.partOf,
    });

    factory Set.fromRawJson(String str) => Set.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Set.fromJson(Map<String, dynamic> json) => Set(
        id: json["id"],
        name: json["name"],
        partOf: json["partOf"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "partOf": partOf,
    };
}

class Images {
    String? icon;
    String? featured;
    String? background;
    String? iconBackground;
    String? fullBackground;

    Images({
        this.icon,
        this.featured,
        this.background,
        this.iconBackground,
        this.fullBackground,
    });

    factory Images.fromRawJson(String str) => Images.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Images.fromJson(Map<String, dynamic> json) => Images(
        icon: json["icon"],
        featured: json["featured"],
        background: json["background"],
        iconBackground: json["icon_background"],
        fullBackground: json["full_background"],
    );

    Map<String, dynamic> toJson() => {
        "icon": icon,
        "featured": featured,
        "background": background,
        "icon_background": iconBackground,
        "full_background": fullBackground,
    };
}

class Rarity {
    String? id;
    String? name;

    Rarity({
      this.id,
      this.name,
    });

    factory Rarity.fromRawJson(String str) => Rarity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Rarity.fromJson(Map<String, dynamic> json) => Rarity(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

enum Name {
    ACCESORIO_MOCHILERO,
    ALA_DELTA,
    BAJO,
    BATERA,
    CALCOMANA,
    COMN,
    DECORACIN,
    EMOTICONO,
    ENVOLTORIO,
    ESTELA,
    ESTILO,
    GESTO,
    GRAFITI,
    GUITARRA,
    KIT_DE_LEGO,
    LEGENDARIA,
    MICRFONO,
    NONE,
    PANTALLA_DE_CARGA,
    PERFECCIN_A_REACCIN_QUE_JUEGA_EN_SU_PROPIA_LIGA,
    PICO,
    PICOS,
    PISTA_DE_IMPROVISACIN,
    POCO_COMN,
    POTENCIADOR,
    RARA,
    RUEDA,
    SERIES_ALAN_WALKER,
    SERIES_TESLA,
    SERIE_DE_DOLOS,
    SERIE_DE_MARVEL,
    SERIE_OSCURA,
    TRAJE
}

final nameValues = EnumValues({
    "Accesorio mochilero": Name.ACCESORIO_MOCHILERO,
    "Ala delta": Name.ALA_DELTA,
    "Bajo": Name.BAJO,
    "Batería": Name.BATERA,
    "Calcomanía": Name.CALCOMANA,
    "COMÚN": Name.COMN,
    "Decoración": Name.DECORACIN,
    "Emoticono": Name.EMOTICONO,
    "Envoltorio": Name.ENVOLTORIO,
    "Estela": Name.ESTELA,
    "Estilo": Name.ESTILO,
    "Gesto": Name.GESTO,
    "Grafiti": Name.GRAFITI,
    "Guitarra": Name.GUITARRA,
    "Kit de LEGO®": Name.KIT_DE_LEGO,
    "LEGENDARIA": Name.LEGENDARIA,
    "Micrófono": Name.MICRFONO,
    "None": Name.NONE,
    "Pantalla de carga": Name.PANTALLA_DE_CARGA,
    "Perfección a reacción que juega en su propia liga.": Name.PERFECCIN_A_REACCIN_QUE_JUEGA_EN_SU_PROPIA_LIGA,
    "Épico": Name.PICO,
    "Picos": Name.PICOS,
    "Pista de improvisación": Name.PISTA_DE_IMPROVISACIN,
    "POCO COMÚN": Name.POCO_COMN,
    "Potenciador": Name.POTENCIADOR,
    "RARA": Name.RARA,
    "Rueda": Name.RUEDA,
    "Series_Alan_Walker": Name.SERIES_ALAN_WALKER,
    "Series_Tesla": Name.SERIES_TESLA,
    "Serie de ídolos": Name.SERIE_DE_DOLOS,
    "SERIE DE MARVEL": Name.SERIE_DE_MARVEL,
    "SERIE OSCURA": Name.SERIE_OSCURA,
    "Traje": Name.TRAJE
});

class OfferDates {
    DateTime? offerDatesIn;
    DateTime? out;

    OfferDates({
        this.offerDatesIn,
        this.out,
    });

    factory OfferDates.fromRawJson(String str) => OfferDates.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OfferDates.fromJson(Map<String, dynamic> json) => OfferDates(
        offerDatesIn: json["in"] == null ? null : DateTime.parse(json["in"]),
        out: json["out"] == null ? null : DateTime.parse(json["out"]),
    );

    Map<String, dynamic> toJson() => {
        "in": offerDatesIn?.toIso8601String(),
        "out": out?.toIso8601String(),
    };
}

class OfferTag {
    String? id;
    String? text;

    OfferTag({
        this.id,
        this.text,
    });

    factory OfferTag.fromRawJson(String str) => OfferTag.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OfferTag.fromJson(Map<String, dynamic> json) => OfferTag(
        id: json["id"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
    };
}

class Price {
    int? regularPrice;
    int? finalPrice;
    int? floorPrice;

    Price({
        this.regularPrice,
        this.finalPrice,
        this.floorPrice,
    });

    factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        regularPrice: json["regularPrice"],
        finalPrice: json["finalPrice"],
        floorPrice: json["floorPrice"],
    );

    Map<String, dynamic> toJson() => {
        "regularPrice": regularPrice,
        "finalPrice": finalPrice,
        "floorPrice": floorPrice,
    };
}

class Section {
    String? id; //identificador del item en algun paquete al que pertenece
    String? name;  //Nombre del paquete o la seccion a la que pertenece
    String? category; //Categoria del item
    int? landingPriority;

    Section({
      this.id,
      this.name,
      this.category,
      this.landingPriority,
    });

    factory Section.fromRawJson(String str) => Section.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        landingPriority: json["landingPriority"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "landingPriority": landingPriority,
    };
}

enum StoreName {
    BR_DAILY_STOREFRONT,
    BR_STARTER_KITS,
    BR_WEEKLY_STOREFRONT
}

final storeNameValues = EnumValues({
    "BRDailyStorefront": StoreName.BR_DAILY_STOREFRONT,
    "BRStarterKits": StoreName.BR_STARTER_KITS,
    "BRWeeklyStorefront": StoreName.BR_WEEKLY_STOREFRONT
});

enum TileSize {
    SIZE_1_X_1,
    SIZE_1_X_2,
    SIZE_2_X_2,
    SIZE_3_X_2,
    SIZE_5_X_2
}

final tileSizeValues = EnumValues({
    "Size_1_x_1": TileSize.SIZE_1_X_1,
    "Size_1_x_2": TileSize.SIZE_1_X_2,
    "Size_2_x_2": TileSize.SIZE_2_X_2,
    "Size_3_x_2": TileSize.SIZE_3_X_2,
    "Size_5_x_2": TileSize.SIZE_5_X_2
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
