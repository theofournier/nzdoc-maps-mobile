import 'package:json_annotation/json_annotation.dart';

part 'campsite_api_model.g.dart';

@JsonSerializable()
class CampsiteProperties {
  @JsonKey(name: 'OBJECTID')
  final int objectId;
  final String name;
  final String? place;
  final String? region;
  final String? introduction;
  final String? campsiteCategory;
  final int? numberOfPoweredSites;
  final int? numberOfUnpoweredSites;
  final String? bookable;
  final bool? free;
  final String? facilities;
  final String? activities;
  final String? dogsAllowed;
  final String? landscape;
  final String? access;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? staticLink;
  final String? locationString;
  final double? x;
  final double? y;
  final int assetId;
  @JsonKey(name: 'dateLoadedToGIS')
  final String? dateLoadedToGis;
  @JsonKey(name: 'GlobalID')
  final String? globalId;

  CampsiteProperties({
    required this.objectId,
    required this.name,
    this.place,
    this.region,
    this.introduction,
    this.campsiteCategory,
    this.numberOfPoweredSites,
    this.numberOfUnpoweredSites,
    this.bookable,
    this.free,
    this.facilities,
    this.activities,
    this.dogsAllowed,
    this.landscape,
    this.access,
    this.hasAlerts,
    this.introductionThumbnail,
    this.staticLink,
    this.locationString,
    this.x,
    this.y,
    required this.assetId,
    this.dateLoadedToGis,
    this.globalId,
  });

  factory CampsiteProperties.fromJson(Map<String, dynamic> json) =>
      _$CampsitePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$CampsitePropertiesToJson(this);
}

@JsonSerializable()
class CampsiteGeometry {
  final String type;
  final List<double> coordinates;

  CampsiteGeometry({required this.type, required this.coordinates});

  factory CampsiteGeometry.fromJson(Map<String, dynamic> json) =>
      _$CampsiteGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$CampsiteGeometryToJson(this);

  double get longitude => coordinates[0];
  double get latitude => coordinates[1];
}

@JsonSerializable()
class CampsiteFeature {
  final String type;
  final int id;
  final CampsiteGeometry geometry;
  final CampsiteProperties properties;

  CampsiteFeature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory CampsiteFeature.fromJson(Map<String, dynamic> json) =>
      _$CampsiteFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$CampsiteFeatureToJson(this);
}

@JsonSerializable()
class CampsiteFeatureCollection {
  final String type;
  final List<CampsiteFeature> features;

  CampsiteFeatureCollection({required this.type, required this.features});

  factory CampsiteFeatureCollection.fromJson(Map<String, dynamic> json) =>
      _$CampsiteFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CampsiteFeatureCollectionToJson(this);
}
