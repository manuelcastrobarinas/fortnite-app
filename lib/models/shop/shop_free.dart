// ignore_for_file: constant_identifier_names

import 'dart:convert';

class TiendaGratis {
    int? status;
    Data? data;

    TiendaGratis({
        this.status,
        this.data,
    });

    factory TiendaGratis.fromRawJson(String str) => TiendaGratis.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TiendaGratis.fromJson(Map<String, dynamic> json) => TiendaGratis(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? hash;
    DateTime? date;
    String? vbuckIcon;
    List<Entry>? entries;

    Data({
        this.hash,
        this.date,
        this.vbuckIcon,
        this.entries,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        hash: json["hash"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        vbuckIcon: json["vbuckIcon"],
        entries: json["entries"] == null ? [] : List<Entry>.from(json["entries"]!.map((x) => Entry.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "hash": hash,
        "date": date?.toIso8601String(),
        "vbuckIcon": vbuckIcon,
        "entries": entries == null ? [] : List<dynamic>.from(entries!.map((x) => x.toJson())),
    };
}

class Entry {
    int? regularPrice;
    int? finalPrice;
    String? devName;
    String? offerId;
    DateTime? inDate;
    DateTime? outDate;
    Bundle? bundle;
    Banner? banner;
    OfferTag? offerTag;
    bool? giftable;
    bool? refundable;
    int? sortPriority;
    String? layoutId;
    Layout? layout;
    TileSize? tileSize;
    String? displayAssetPath;
    String? newDisplayAssetPath;
    NewDisplayAsset? newDisplayAsset;
    List<BrItem>? brItems;
    List<Track>? tracks;
    List<Instrument>? instruments;
    List<Car>? cars;
    List<LegoKit>? legoKits;

    Entry({
        this.regularPrice,
        this.finalPrice,
        this.devName,
        this.offerId,
        this.inDate,
        this.outDate,
        this.bundle,
        this.banner,
        this.offerTag,
        this.giftable,
        this.refundable,
        this.sortPriority,
        this.layoutId,
        this.layout,
        this.tileSize,
        this.displayAssetPath,
        this.newDisplayAssetPath,
        this.newDisplayAsset,
        this.brItems,
        this.tracks,
        this.instruments,
        this.cars,
        this.legoKits,
    });

    factory Entry.fromRawJson(String str) => Entry.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        regularPrice: json["regularPrice"],
        finalPrice: json["finalPrice"],
        devName: json["devName"],
        offerId: json["offerId"],
        inDate: json["inDate"] == null ? null : DateTime.parse(json["inDate"]),
        outDate: json["outDate"] == null ? null : DateTime.parse(json["outDate"]),
        bundle: json["bundle"] == null ? null : Bundle.fromJson(json["bundle"]),
        banner: json["banner"] == null ? null : Banner.fromJson(json["banner"]),
        offerTag: json["offerTag"] == null ? null : OfferTag.fromJson(json["offerTag"]),
        giftable: json["giftable"],
        refundable: json["refundable"],
        sortPriority: json["sortPriority"],
        layoutId: json["layoutId"],
        layout: json["layout"] == null ? null : Layout.fromJson(json["layout"]),
        tileSize: tileSizeValues.map[json["tileSize"]]!,
        displayAssetPath: json["displayAssetPath"],
        newDisplayAssetPath: json["newDisplayAssetPath"],
        newDisplayAsset: json["newDisplayAsset"] == null ? null : NewDisplayAsset.fromJson(json["newDisplayAsset"]),
        brItems: json["brItems"] == null ? [] : List<BrItem>.from(json["brItems"]!.map((x) => BrItem.fromJson(x))),
        tracks: json["tracks"] == null ? [] : List<Track>.from(json["tracks"]!.map((x) => Track.fromJson(x))),
        instruments: json["instruments"] == null ? [] : List<Instrument>.from(json["instruments"]!.map((x) => Instrument.fromJson(x))),
        cars: json["cars"] == null ? [] : List<Car>.from(json["cars"]!.map((x) => Car.fromJson(x))),
        legoKits: json["legoKits"] == null ? [] : List<LegoKit>.from(json["legoKits"]!.map((x) => LegoKit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "regularPrice": regularPrice,
        "finalPrice": finalPrice,
        "devName": devName,
        "offerId": offerId,
        "inDate": inDate?.toIso8601String(),
        "outDate": outDate?.toIso8601String(),
        "bundle": bundle?.toJson(),
        "banner": banner?.toJson(),
        "offerTag": offerTag?.toJson(),
        "giftable": giftable,
        "refundable": refundable,
        "sortPriority": sortPriority,
        "layoutId": layoutId,
        "layout": layout?.toJson(),
        "tileSize": tileSizeValues.reverse[tileSize],
        "displayAssetPath": displayAssetPath,
        "newDisplayAssetPath": newDisplayAssetPath,
        "newDisplayAsset": newDisplayAsset?.toJson(),
        "brItems": brItems == null ? [] : List<dynamic>.from(brItems!.map((x) => x.toJson())),
        "tracks": tracks == null ? [] : List<dynamic>.from(tracks!.map((x) => x.toJson())),
        "instruments": instruments == null ? [] : List<dynamic>.from(instruments!.map((x) => x.toJson())),
        "cars": cars == null ? [] : List<dynamic>.from(cars!.map((x) => x.toJson())),
        "legoKits": legoKits == null ? [] : List<dynamic>.from(legoKits!.map((x) => x.toJson())),
    };
}

class Banner {
    String? value;
    Intensity? intensity;
    String? backendValue;

    Banner({
        this.value,
        this.intensity,
        this.backendValue,
    });

    factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        value: json["value"],
        intensity: intensityValues.map[json["intensity"]]!,
        backendValue: json["backendValue"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "intensity": intensityValues.reverse[intensity],
        "backendValue": backendValue,
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

class BrItem {
    String? id;
    String? name;
    String? description;
    Rarity? type;
    Rarity? rarity;
    Series? series;
    Set? brItemSet;
    Introduction? introduction;
    BrItemImages? images;
    List<Variant>? variants;
    dynamic searchTags;
    List<String>? gameplayTags;
    List<String>? metaTags;
    String? showcaseVideo;
    String? dynamicPakId;
    String? displayAssetPath;
    String? definitionPath;
    String? path;
    DateTime? added;
    List<DateTime>? shopHistory;
    String? itemPreviewHeroPath;
    List<String>? builtInEmoteIds;

    BrItem({
        this.id,
        this.name,
        this.description,
        this.type,
        this.rarity,
        this.series,
        this.brItemSet,
        this.introduction,
        this.images,
        this.variants,
        this.searchTags,
        this.gameplayTags,
        this.metaTags,
        this.showcaseVideo,
        this.dynamicPakId,
        this.displayAssetPath,
        this.definitionPath,
        this.path,
        this.added,
        this.shopHistory,
        this.itemPreviewHeroPath,
        this.builtInEmoteIds,
    });

    factory BrItem.fromRawJson(String str) => BrItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BrItem.fromJson(Map<String, dynamic> json) => BrItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
        rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
        series: json["series"] == null ? null : Series.fromJson(json["series"]),
        brItemSet: json["set"] == null ? null : Set.fromJson(json["set"]),
        introduction: json["introduction"] == null ? null : Introduction.fromJson(json["introduction"]),
        images: json["images"] == null ? null : BrItemImages.fromJson(json["images"]),
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        searchTags: json["searchTags"],
        gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
        metaTags: json["metaTags"] == null ? [] : List<String>.from(json["metaTags"]!.map((x) => x)),
        showcaseVideo: json["showcaseVideo"],
        dynamicPakId: json["dynamicPakId"],
        displayAssetPath: json["displayAssetPath"],
        definitionPath: json["definitionPath"],
        path: json["path"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        shopHistory: json["shopHistory"] == null ? [] : List<DateTime>.from(json["shopHistory"]!.map((x) => DateTime.parse(x))),
        itemPreviewHeroPath: json["itemPreviewHeroPath"],
        builtInEmoteIds: json["builtInEmoteIds"] == null ? [] : List<String>.from(json["builtInEmoteIds"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type?.toJson(),
        "rarity": rarity?.toJson(),
        "series": series?.toJson(),
        "set": brItemSet?.toJson(),
        "introduction": introduction?.toJson(),
        "images": images?.toJson(),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "searchTags": searchTags,
        "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
        "metaTags": metaTags == null ? [] : List<dynamic>.from(metaTags!.map((x) => x)),
        "showcaseVideo": showcaseVideo,
        "dynamicPakId": dynamicPakId,
        "displayAssetPath": displayAssetPath,
        "definitionPath": definitionPath,
        "path": path,
        "added": added?.toIso8601String(),
        "shopHistory": shopHistory == null ? [] : List<dynamic>.from(shopHistory!.map((x) => x.toIso8601String())),
        "itemPreviewHeroPath": itemPreviewHeroPath,
        "builtInEmoteIds": builtInEmoteIds == null ? [] : List<dynamic>.from(builtInEmoteIds!.map((x) => x)),
    };
}

class Set {
    String? value;
    String? text;
    String? backendValue;

    Set({
        this.value,
        this.text,
        this.backendValue,
    });

    factory Set.fromRawJson(String str) => Set.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Set.fromJson(Map<String, dynamic> json) => Set(
        value: json["value"],
        text: json["text"],
        backendValue: json["backendValue"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
        "backendValue": backendValue,
    };
}

class BrItemImages {
    String? smallIcon;
    String? icon;
    String? featured;
    LegoClass? lego;
    BeanClass? bean;
    Other? other;

    BrItemImages({
        this.smallIcon,
        this.icon,
        this.featured,
        this.lego,
        this.bean,
        this.other,
    });

    factory BrItemImages.fromRawJson(String str) => BrItemImages.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BrItemImages.fromJson(Map<String, dynamic> json) => BrItemImages(
        smallIcon: json["smallIcon"],
        icon: json["icon"],
        featured: json["featured"],
        lego: json["lego"] == null ? null : LegoClass.fromJson(json["lego"]),
        bean: json["bean"] == null ? null : BeanClass.fromJson(json["bean"]),
        other: json["other"] == null ? null : Other.fromJson(json["other"]),
    );

    Map<String, dynamic> toJson() => {
        "smallIcon": smallIcon,
        "icon": icon,
        "featured": featured,
        "lego": lego?.toJson(),
        "bean": bean?.toJson(),
        "other": other?.toJson(),
    };
}

class BeanClass {
    String? small;
    String? large;

    BeanClass({
        this.small,
        this.large,
    });

    factory BeanClass.fromRawJson(String str) => BeanClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BeanClass.fromJson(Map<String, dynamic> json) => BeanClass(
        small: json["small"],
        large: json["large"],
    );

    Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
    };
}

class LegoClass {
    String? small;
    String? large;
    dynamic wide;

    LegoClass({
        this.small,
        this.large,
        this.wide,
    });

    factory LegoClass.fromRawJson(String str) => LegoClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LegoClass.fromJson(Map<String, dynamic> json) => LegoClass(
        small: json["small"],
        large: json["large"],
        wide: json["wide"],
    );

    Map<String, dynamic> toJson() => {
        "small": small,
        "large": large,
        "wide": wide,
    };
}

class Other {
    String? decal;
    String? background;

    Other({
        this.decal,
        this.background,
    });

    factory Other.fromRawJson(String str) => Other.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Other.fromJson(Map<String, dynamic> json) => Other(
        decal: json["decal"],
        background: json["background"],
    );

    Map<String, dynamic> toJson() => {
        "decal": decal,
        "background": background,
    };
}

class Introduction {
    String? chapter;
    String? season;
    String? text;
    int? backendValue;

    Introduction({
        this.chapter,
        this.season,
        this.text,
        this.backendValue,
    });

    factory Introduction.fromRawJson(String str) => Introduction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Introduction.fromJson(Map<String, dynamic> json) => Introduction(
        chapter: json["chapter"],
        season: json["season"],
        text: json["text"],
        backendValue: json["backendValue"],
    );

    Map<String, dynamic> toJson() => {
        "chapter": chapter,
        "season": season,
        "text": text,
        "backendValue": backendValue,
    };
}

class Rarity {
    String? value;
    String? displayValue;
    String? backendValue;

    Rarity({
        this.value,
        this.displayValue,
        this.backendValue,
    });

    factory Rarity.fromRawJson(String str) => Rarity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Rarity.fromJson(Map<String, dynamic> json) => Rarity(
        value: json["value"],
        displayValue: json["displayValue"],
        backendValue: json["backendValue"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "displayValue": displayValue,
        "backendValue": backendValue,
    };
}

class Series {
    Value? value;
    String? image;
    List<String>? colors;
    BackendValue? backendValue;

    Series({
        this.value,
        this.image,
        this.colors,
        this.backendValue,
    });

    factory Series.fromRawJson(String str) => Series.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Series.fromJson(Map<String, dynamic> json) => Series(
        value: valueValues.map[json["value"]]!,
        image: json["image"],
        colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
        backendValue: backendValueValues.map[json["backendValue"]]!,
    );

    Map<String, dynamic> toJson() => {
        "value": valueValues.reverse[value],
        "image": image,
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "backendValue": backendValueValues.reverse[backendValue],
    };
}

enum BackendValue {
    CREATOR_COLLAB_SERIES,
    CUBE_SERIES,
    MARVEL_SERIES,
    SERIES_ALAN_WALKER,
    SERIES_TESLA
}

final backendValueValues = EnumValues({
    "CreatorCollabSeries": BackendValue.CREATOR_COLLAB_SERIES,
    "CUBESeries": BackendValue.CUBE_SERIES,
    "MarvelSeries": BackendValue.MARVEL_SERIES,
    "Series_Alan_Walker": BackendValue.SERIES_ALAN_WALKER,
    "Series_Tesla": BackendValue.SERIES_TESLA
});

enum Value {
    SERIE_ALAN_WALKER,
    SERIE_DE_DOLOS,
    SERIE_DE_MARVEL,
    SERIE_OSCURA,
    SERIE_TESLA
}

final valueValues = EnumValues({
    "SERIE ALAN WALKER": Value.SERIE_ALAN_WALKER,
    "Serie de ídolos": Value.SERIE_DE_DOLOS,
    "SERIE DE MARVEL": Value.SERIE_DE_MARVEL,
    "SERIE OSCURA": Value.SERIE_OSCURA,
    "SERIE TESLA": Value.SERIE_TESLA
});

class Variant {
    Channel? channel;
    String? type;
    List<Option>? options;

    Variant({
        this.channel,
        this.type,
        this.options,
    });

    factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        channel: channelValues.map[json["channel"]]!,
        type: json["type"],
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "channel": channelValues.reverse[channel],
        "type": type,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    };
}

enum Channel {
    CORRUPTION,
    MATERIAL,
    MESH,
    PARTICLE,
    PARTS,
    PATTERN,
    PROGRESSIVE,
    RICH_COLOR
}

final channelValues = EnumValues({
    "Corruption": Channel.CORRUPTION,
    "Material": Channel.MATERIAL,
    "Mesh": Channel.MESH,
    "Particle": Channel.PARTICLE,
    "Parts": Channel.PARTS,
    "Pattern": Channel.PATTERN,
    "Progressive": Channel.PROGRESSIVE,
    "RichColor": Channel.RICH_COLOR
});

class Option {
    String? tag;
    String? name;
    String? image;
    String? unlockRequirements;

    Option({
        this.tag,
        this.name,
        this.image,
        this.unlockRequirements,
    });

    factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        tag: json["tag"],
        name: json["name"],
        image: json["image"],
        unlockRequirements: json["unlockRequirements"],
    );

    Map<String, dynamic> toJson() => {
        "tag": tag,
        "name": name,
        "image": image,
        "unlockRequirements": unlockRequirements,
    };
}

class Bundle {
    String? name;
    Info? info;
    String? image;

    Bundle({
        this.name,
        this.info,
        this.image,
    });

    factory Bundle.fromRawJson(String str) => Bundle.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        name: json["name"],
        info: infoValues.map[json["info"]]!,
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "info": infoValues.reverse[info],
        "image": image,
    };
}

enum Info {
    LOTE
}

final infoValues = EnumValues({
    "Lote": Info.LOTE
});

class Car {
    String? id;
    String? vehicleId;
    String? name;
    String? description;
    Rarity? type;
    Rarity? rarity;
    BeanClass? images;
    Series? series;
    List<String>? gameplayTags;
    String? path;
    dynamic showcaseVideo;
    DateTime? added;
    List<DateTime>? shopHistory;

    Car({
        this.id,
        this.vehicleId,
        this.name,
        this.description,
        this.type,
        this.rarity,
        this.images,
        this.series,
        this.gameplayTags,
        this.path,
        this.showcaseVideo,
        this.added,
        this.shopHistory,
    });

    factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        vehicleId: json["vehicleId"],
        name: json["name"],
        description: json["description"],
        type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
        rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
        images: json["images"] == null ? null : BeanClass.fromJson(json["images"]),
        series: json["series"] == null ? null : Series.fromJson(json["series"]),
        gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
        path: json["path"],
        showcaseVideo: json["showcaseVideo"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        shopHistory: json["shopHistory"] == null ? [] : List<DateTime>.from(json["shopHistory"]!.map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "vehicleId": vehicleId,
        "name": name,
        "description": description,
        "type": type?.toJson(),
        "rarity": rarity?.toJson(),
        "images": images?.toJson(),
        "series": series?.toJson(),
        "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
        "path": path,
        "showcaseVideo": showcaseVideo,
        "added": added?.toIso8601String(),
        "shopHistory": shopHistory == null ? [] : List<dynamic>.from(shopHistory!.map((x) => x.toIso8601String())),
    };
}

class Instrument {
    String? id;
    String? name;
    String? description;
    Rarity? type;
    Rarity? rarity;
    BeanClass? images;
    Series? series;
    List<String>? gameplayTags;
    String? path;
    dynamic showcaseVideo;
    DateTime? added;
    List<DateTime>? shopHistory;

    Instrument({
        this.id,
        this.name,
        this.description,
        this.type,
        this.rarity,
        this.images,
        this.series,
        this.gameplayTags,
        this.path,
        this.showcaseVideo,
        this.added,
        this.shopHistory,
    });

    factory Instrument.fromRawJson(String str) => Instrument.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Instrument.fromJson(Map<String, dynamic> json) => Instrument(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
        rarity: json["rarity"] == null ? null : Rarity.fromJson(json["rarity"]),
        images: json["images"] == null ? null : BeanClass.fromJson(json["images"]),
        series: json["series"] == null ? null : Series.fromJson(json["series"]),
        gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
        path: json["path"],
        showcaseVideo: json["showcaseVideo"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        shopHistory: json["shopHistory"] == null ? [] : List<DateTime>.from(json["shopHistory"]!.map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type?.toJson(),
        "rarity": rarity?.toJson(),
        "images": images?.toJson(),
        "series": series?.toJson(),
        "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
        "path": path,
        "showcaseVideo": showcaseVideo,
        "added": added?.toIso8601String(),
        "shopHistory": shopHistory == null ? [] : List<dynamic>.from(shopHistory!.map((x) => x.toIso8601String())),
    };
}

class Layout {
    LayoutId? id;
    Name? name;
    Category? category;
    int? index;
    ShowIneligibleOffers? showIneligibleOffers;
    dynamic background;
    bool? useWidePreview;
    DisplayType? displayType;
    List<Metadatum>? textureMetadata;
    List<Metadatum>? stringMetadata;
    List<Metadatum>? textMetadata;

    Layout({
        this.id,
        this.name,
        this.category,
        this.index,
        this.showIneligibleOffers,
        this.background,
        this.useWidePreview,
        this.displayType,
        this.textureMetadata,
        this.stringMetadata,
        this.textMetadata,
    });

    factory Layout.fromRawJson(String str) => Layout.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Layout.fromJson(Map<String, dynamic> json) => Layout(
        id: layoutIdValues.map[json["id"]]!,
        name: nameValues.map[json["name"]]!,
        category: categoryValues.map[json["category"]]!,
        index: json["index"],
        showIneligibleOffers: showIneligibleOffersValues.map[json["showIneligibleOffers"]]!,
        background: json["background"],
        useWidePreview: json["useWidePreview"],
        displayType: displayTypeValues.map[json["displayType"]]!,
        textureMetadata: json["textureMetadata"] == null ? [] : List<Metadatum>.from(json["textureMetadata"]!.map((x) => Metadatum.fromJson(x))),
        stringMetadata: json["stringMetadata"] == null ? [] : List<Metadatum>.from(json["stringMetadata"]!.map((x) => Metadatum.fromJson(x))),
        textMetadata: json["textMetadata"] == null ? [] : List<Metadatum>.from(json["textMetadata"]!.map((x) => Metadatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": layoutIdValues.reverse[id],
        "name": nameValues.reverse[name],
        "category": categoryValues.reverse[category],
        "index": index,
        "showIneligibleOffers": showIneligibleOffersValues.reverse[showIneligibleOffers],
        "background": background,
        "useWidePreview": useWidePreview,
        "displayType": displayTypeValues.reverse[displayType],
        "textureMetadata": textureMetadata == null ? [] : List<dynamic>.from(textureMetadata!.map((x) => x.toJson())),
        "stringMetadata": stringMetadata == null ? [] : List<dynamic>.from(stringMetadata!.map((x) => x.toJson())),
        "textMetadata": textMetadata == null ? [] : List<dynamic>.from(textMetadata!.map((x) => x.toJson())),
    };
}

enum Category {
    CALIENTA_MOTORES,
    CONSTRUYE_CON_KITS_DE_LEGO,
    DESTACADOS,
    ORIGINALES_MAGISTRALES,
    SPOTLIGHT,
    SUBE_AL_ESCENARIO
}

final categoryValues = EnumValues({
    "Calienta motores": Category.CALIENTA_MOTORES,
    "Construye con kits de LEGO®": Category.CONSTRUYE_CON_KITS_DE_LEGO,
    "Destacados": Category.DESTACADOS,
    "Originales magistrales": Category.ORIGINALES_MAGISTRALES,
    "Spotlight": Category.SPOTLIGHT,
    "Sube al escenario": Category.SUBE_AL_ESCENARIO
});

enum DisplayType {
    BILLBOARD,
    EXPANDABLE_LIST,
    TILE_GRID
}

final displayTypeValues = EnumValues({
    "billboard": DisplayType.BILLBOARD,
    "expandableList": DisplayType.EXPANDABLE_LIST,
    "tileGrid": DisplayType.TILE_GRID
});

enum LayoutId {
    ALAN_WALKER,
    BILLIE_EILISH_RED_EXTENSION,
    DEADPOOL_AND_WOLVERINE,
    DRAGON_BALL_Z,
    GEAR_FOR_FESTIVAL_EXTENSION,
    INSIDIO,
    JAM_TRACKS,
    MAX_AIRPHORIAN,
    METALLICA3,
    PIRATE_LIFESTYLE,
    SIGNATURE_STYLE,
    SIGNATURE_STYLE_EXTENSION,
    SPARKS_INSTRUMENTS11,
    TESLA,
    VEGETTA777_EXTENSION
}

final layoutIdValues = EnumValues({
    "AlanWalker": LayoutId.ALAN_WALKER,
    "BillieEilishRedExtension": LayoutId.BILLIE_EILISH_RED_EXTENSION,
    "DeadpoolAndWolverine": LayoutId.DEADPOOL_AND_WOLVERINE,
    "DragonBallZ": LayoutId.DRAGON_BALL_Z,
    "GearForFestivalExtension": LayoutId.GEAR_FOR_FESTIVAL_EXTENSION,
    "Insidio": LayoutId.INSIDIO,
    "JamTracks": LayoutId.JAM_TRACKS,
    "MaxAirphorian": LayoutId.MAX_AIRPHORIAN,
    "Metallica3": LayoutId.METALLICA3,
    "PirateLifestyle": LayoutId.PIRATE_LIFESTYLE,
    "SignatureStyle": LayoutId.SIGNATURE_STYLE,
    "SignatureStyleExtension": LayoutId.SIGNATURE_STYLE_EXTENSION,
    "SparksInstruments11": LayoutId.SPARKS_INSTRUMENTS11,
    "Tesla": LayoutId.TESLA,
    "Vegetta777Extension": LayoutId.VEGETTA777_EXTENSION
});

enum Name {
    ALAN_WALKER,
    BILLIE_EILISH,
    DEADPOOL_Y_WOLVERINE,
    DRAGON_BALL,
    EQUPATE_PARA_EL_FESTIVAL,
    ESTILO_DE_VIDA_PIRATA,
    INSIDIO,
    LOTE_DE_TAQUILLA_DE_VEGETTA777,
    METALLICA,
    NIKE,
    PISTAS_DE_IMPROVISACIN,
    TESLA,
    TOQUE_CARACTERSTICO
}

final nameValues = EnumValues({
    "Alan Walker": Name.ALAN_WALKER,
    "Billie Eilish": Name.BILLIE_EILISH,
    "Deadpool y Wolverine": Name.DEADPOOL_Y_WOLVERINE,
    "Dragon Ball": Name.DRAGON_BALL,
    "Equípate para el Festival": Name.EQUPATE_PARA_EL_FESTIVAL,
    "Estilo de vida pirata": Name.ESTILO_DE_VIDA_PIRATA,
    "Insidio": Name.INSIDIO,
    "Lote de taquilla de Vegetta777": Name.LOTE_DE_TAQUILLA_DE_VEGETTA777,
    "Metallica": Name.METALLICA,
    "NIKE": Name.NIKE,
    "Pistas de improvisación": Name.PISTAS_DE_IMPROVISACIN,
    "Tesla": Name.TESLA,
    "Toque característico": Name.TOQUE_CARACTERSTICO
});

enum ShowIneligibleOffers {
    ALWAYS
}

final showIneligibleOffersValues = EnumValues({
    "Always": ShowIneligibleOffers.ALWAYS
});

class Metadatum {
    String? key;
    String? value;

    Metadatum({
        this.key,
        this.value,
    });

    factory Metadatum.fromRawJson(String str) => Metadatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Metadatum.fromJson(Map<String, dynamic> json) => Metadatum(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}

class LegoKit {
    String? id;
    String? name;
    Rarity? type;
    dynamic series;
    List<String>? gameplayTags;
    LegoClass? images;
    String? path;
    DateTime? added;
    List<DateTime>? shopHistory;

    LegoKit({
        this.id,
        this.name,
        this.type,
        this.series,
        this.gameplayTags,
        this.images,
        this.path,
        this.added,
        this.shopHistory,
    });

    factory LegoKit.fromRawJson(String str) => LegoKit.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LegoKit.fromJson(Map<String, dynamic> json) => LegoKit(
        id: json["id"],
        name: json["name"],
        type: json["type"] == null ? null : Rarity.fromJson(json["type"]),
        series: json["series"],
        gameplayTags: json["gameplayTags"] == null ? [] : List<String>.from(json["gameplayTags"]!.map((x) => x)),
        images: json["images"] == null ? null : LegoClass.fromJson(json["images"]),
        path: json["path"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        shopHistory: json["shopHistory"] == null ? [] : List<DateTime>.from(json["shopHistory"]!.map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type?.toJson(),
        "series": series,
        "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => x)),
        "images": images?.toJson(),
        "path": path,
        "added": added?.toIso8601String(),
        "shopHistory": shopHistory == null ? [] : List<dynamic>.from(shopHistory!.map((x) => x.toIso8601String())),
    };
}

class NewDisplayAsset {
    String? id;
    String? cosmeticId;
    List<MaterialInstance>? materialInstances;

    NewDisplayAsset({
        this.id,
        this.cosmeticId,
        this.materialInstances,
    });

    factory NewDisplayAsset.fromRawJson(String str) => NewDisplayAsset.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewDisplayAsset.fromJson(Map<String, dynamic> json) => NewDisplayAsset(
        id: json["id"],
        cosmeticId: json["cosmeticId"],
        materialInstances: json["materialInstances"] == null ? [] : List<MaterialInstance>.from(json["materialInstances"]!.map((x) => MaterialInstance.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cosmeticId": cosmeticId,
        "materialInstances": materialInstances == null ? [] : List<dynamic>.from(materialInstances!.map((x) => x.toJson())),
    };
}

class MaterialInstance {
    String? id;
    PrimaryMode? primaryMode;
    ProductTag? productTag;
    MaterialInstanceImages? images;
    Colors? colors;
    Map<String, double>? scalings;
    dynamic flags;

    MaterialInstance({
        this.id,
        this.primaryMode,
        this.productTag,
        this.images,
        this.colors,
        this.scalings,
        this.flags,
    });

    factory MaterialInstance.fromRawJson(String str) => MaterialInstance.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MaterialInstance.fromJson(Map<String, dynamic> json) => MaterialInstance(
        id: json["id"],
        primaryMode: primaryModeValues.map[json["primaryMode"]]!,
        productTag: productTagValues.map[json["productTag"]]!,
        images: json["images"] == null ? null : MaterialInstanceImages.fromJson(json["images"]),
        colors: json["colors"] == null ? null : Colors.fromJson(json["colors"]),
        scalings: Map.from(json["scalings"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        flags: json["flags"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "primaryMode": primaryModeValues.reverse[primaryMode],
        "productTag": productTagValues.reverse[productTag],
        "images": images?.toJson(),
        "colors": colors?.toJson(),
        "scalings": Map.from(scalings!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "flags": flags,
    };
}

class Colors {
    String? backgroundColorA;
    String? backgroundColorB;
    String? fallOffColor;
    String? mfRadialCoordinates;
    String? colorCircuitBackground;
    String? colorCircuitBackground2;
    String? rgb3;
    String? rgb4;
    String? rgb5;
    String? textilePanSpeed;
    String? textilePerspective;
    String? textileScale;
    String? raritySetTo0ForColor;
    String? accentColor;
    String? floorRadialAngle;
    String? floorRadialOffset;

    Colors({
        this.backgroundColorA,
        this.backgroundColorB,
        this.fallOffColor,
        this.mfRadialCoordinates,
        this.colorCircuitBackground,
        this.colorCircuitBackground2,
        this.rgb3,
        this.rgb4,
        this.rgb5,
        this.textilePanSpeed,
        this.textilePerspective,
        this.textileScale,
        this.raritySetTo0ForColor,
        this.accentColor,
        this.floorRadialAngle,
        this.floorRadialOffset,
    });

    factory Colors.fromRawJson(String str) => Colors.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Colors.fromJson(Map<String, dynamic> json) => Colors(
        backgroundColorA: json["Background_Color_A"],
        backgroundColorB: json["Background_Color_B"],
        fallOffColor: json["FallOff_Color"],
        mfRadialCoordinates: json["MF_RadialCoordinates"],
        colorCircuitBackground: json["ColorCircuitBackground"],
        colorCircuitBackground2: json["ColorCircuitBackground2"],
        rgb3: json["RGB3"],
        rgb4: json["RGB4"],
        rgb5: json["RGB5"],
        textilePanSpeed: json["TextilePanSpeed"],
        textilePerspective: json["TextilePerspective"],
        textileScale: json["TextileScale"],
        raritySetTo0ForColor: json["Rarity [set to 0 for color]"],
        accentColor: json["AccentColor"],
        floorRadialAngle: json["Floor Radial Angle"],
        floorRadialOffset: json["Floor Radial Offset"],
    );

    Map<String, dynamic> toJson() => {
        "Background_Color_A": backgroundColorA,
        "Background_Color_B": backgroundColorB,
        "FallOff_Color": fallOffColor,
        "MF_RadialCoordinates": mfRadialCoordinates,
        "ColorCircuitBackground": colorCircuitBackground,
        "ColorCircuitBackground2": colorCircuitBackground2,
        "RGB3": rgb3,
        "RGB4": rgb4,
        "RGB5": rgb5,
        "TextilePanSpeed": textilePanSpeed,
        "TextilePerspective": textilePerspective,
        "TextileScale": textileScale,
        "Rarity [set to 0 for color]": raritySetTo0ForColor,
        "AccentColor": accentColor,
        "Floor Radial Angle": floorRadialAngle,
        "Floor Radial Offset": floorRadialOffset,
    };
}

class MaterialInstanceImages {
    String? offerImage;
    String? background;
    String? texture;
    String? imageBackground;
    String? fnmTexture;
    String? flipbook;
    String? the2OfferImage;
    String? bundleTexture;
    String? carTexture;
    String? carUtil;

    MaterialInstanceImages({
        this.offerImage,
        this.background,
        this.texture,
        this.imageBackground,
        this.fnmTexture,
        this.flipbook,
        this.the2OfferImage,
        this.bundleTexture,
        this.carTexture,
        this.carUtil,
    });

    factory MaterialInstanceImages.fromRawJson(String str) => MaterialInstanceImages.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MaterialInstanceImages.fromJson(Map<String, dynamic> json) => MaterialInstanceImages(
        offerImage: json["OfferImage"],
        background: json["Background"],
        texture: json["Texture"],
        imageBackground: json["ImageBackground"],
        fnmTexture: json["FNMTexture"],
        flipbook: json["Flipbook"],
        the2OfferImage: json["2-OfferImage"],
        bundleTexture: json["BundleTexture"],
        carTexture: json["CarTexture"],
        carUtil: json["CarUtil"],
    );

    Map<String, dynamic> toJson() => {
        "OfferImage": offerImage,
        "Background": background,
        "Texture": texture,
        "ImageBackground": imageBackground,
        "FNMTexture": fnmTexture,
        "Flipbook": flipbook,
        "2-OfferImage": the2OfferImage,
        "BundleTexture": bundleTexture,
        "CarTexture": carTexture,
        "CarUtil": carUtil,
    };
}

enum PrimaryMode {
    E_COSMETIC_COMPATIBLE_MODE_LEGACY_MAX
}

final primaryModeValues = EnumValues({
    "ECosmeticCompatibleModeLegacy::MAX": PrimaryMode.E_COSMETIC_COMPATIBLE_MODE_LEGACY_MAX
});

enum ProductTag {
    PRODUCT_BR,
    PRODUCT_DEL_MAR,
    PRODUCT_JUNO,
    PRODUCT_MAX,
    PRODUCT_SPARKS
}

final productTagValues = EnumValues({
    "Product.BR": ProductTag.PRODUCT_BR,
    "Product.DelMar": ProductTag.PRODUCT_DEL_MAR,
    "Product.Juno": ProductTag.PRODUCT_JUNO,
    "Product.MAX": ProductTag.PRODUCT_MAX,
    "Product.Sparks": ProductTag.PRODUCT_SPARKS
});

class OfferTag {
    OfferTagId? id;
    String? text;

    OfferTag({
        this.id,
        this.text,
    });

    factory OfferTag.fromRawJson(String str) => OfferTag.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OfferTag.fromJson(Map<String, dynamic> json) => OfferTag(
        id: offerTagIdValues.map[json["id"]]!,
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": offerTagIdValues.reverse[id],
        "text": text,
    };
}

enum OfferTagId {
    FUTURE,
    JUMPSUITBUNDLEDESC,
    JUMPSUITDESC,
    LASTVOICEGEAR,
    MARIONETTEDESC,
    PEACH,
    PROMODESC114,
    SPARKSJAMLOOP
}

final offerTagIdValues = EnumValues({
    "future": OfferTagId.FUTURE,
    "jumpsuitbundledesc": OfferTagId.JUMPSUITBUNDLEDESC,
    "jumpsuitdesc": OfferTagId.JUMPSUITDESC,
    "lastvoicegear": OfferTagId.LASTVOICEGEAR,
    "marionettedesc": OfferTagId.MARIONETTEDESC,
    "peach": OfferTagId.PEACH,
    "promodesc114": OfferTagId.PROMODESC114,
    "sparksjamloop": OfferTagId.SPARKSJAMLOOP
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

class Track {
    String? id;
    String? devName;
    String? title;
    String? artist;
    String? album;
    int? releaseYear;
    int? bpm;
    int? duration;
    Difficulty? difficulty;
    List<GameplayTag>? gameplayTags;
    List<Genre>? genres;
    String? albumArt;
    DateTime? added;
    List<DateTime>? shopHistory;

    Track({
        this.id,
        this.devName,
        this.title,
        this.artist,
        this.album,
        this.releaseYear,
        this.bpm,
        this.duration,
        this.difficulty,
        this.gameplayTags,
        this.genres,
        this.albumArt,
        this.added,
        this.shopHistory,
    });

    factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        devName: json["devName"],
        title: json["title"],
        artist: json["artist"],
        album: json["album"],
        releaseYear: json["releaseYear"],
        bpm: json["bpm"],
        duration: json["duration"],
        difficulty: json["difficulty"] == null ? null : Difficulty.fromJson(json["difficulty"]),
        gameplayTags: json["gameplayTags"] == null ? [] : List<GameplayTag>.from(json["gameplayTags"]!.map((x) => gameplayTagValues.map[x]!)),
        genres: json["genres"] == null ? [] : List<Genre>.from(json["genres"]!.map((x) => genreValues.map[x]!)),
        albumArt: json["albumArt"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        shopHistory: json["shopHistory"] == null ? [] : List<DateTime>.from(json["shopHistory"]!.map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "devName": devName,
        "title": title,
        "artist": artist,
        "album": album,
        "releaseYear": releaseYear,
        "bpm": bpm,
        "duration": duration,
        "difficulty": difficulty?.toJson(),
        "gameplayTags": gameplayTags == null ? [] : List<dynamic>.from(gameplayTags!.map((x) => gameplayTagValues.reverse[x])),
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => genreValues.reverse[x])),
        "albumArt": albumArt,
        "added": added?.toIso8601String(),
        "shopHistory": shopHistory == null ? [] : List<dynamic>.from(shopHistory!.map((x) => x.toIso8601String())),
    };
}

class Difficulty {
    int? vocals;
    int? guitar;
    int? bass;
    int? plasticBass;
    int? drums;
    int? plasticDrums;

    Difficulty({
        this.vocals,
        this.guitar,
        this.bass,
        this.plasticBass,
        this.drums,
        this.plasticDrums,
    });

    factory Difficulty.fromRawJson(String str) => Difficulty.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Difficulty.fromJson(Map<String, dynamic> json) => Difficulty(
        vocals: json["vocals"],
        guitar: json["guitar"],
        bass: json["bass"],
        plasticBass: json["plasticBass"],
        drums: json["drums"],
        plasticDrums: json["plasticDrums"],
    );

    Map<String, dynamic> toJson() => {
        "vocals": vocals,
        "guitar": guitar,
        "bass": bass,
        "plasticBass": plasticBass,
        "drums": drums,
        "plasticDrums": plasticDrums,
    };
}

enum GameplayTag {
    JAM_LOOP_IS_UNPITCHED_BEAT,
    SPARKS_SONG_FORCE_CMS_ALBUM_ART
}

final gameplayTagValues = EnumValues({
    "Jam-LoopIsUnpitched-Beat": GameplayTag.JAM_LOOP_IS_UNPITCHED_BEAT,
    "Sparks-Song-ForceCMSAlbumArt": GameplayTag.SPARKS_SONG_FORCE_CMS_ALBUM_ART
});

enum Genre {
    DANCE_ELECTRONIC,
    POP,
    RAP_HIP_HOP,
    RN_B,
    ROCK
}

final genreValues = EnumValues({
    "DanceElectronic": Genre.DANCE_ELECTRONIC,
    "Pop": Genre.POP,
    "RapHipHop": Genre.RAP_HIP_HOP,
    "RnB": Genre.RN_B,
    "Rock": Genre.ROCK
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
