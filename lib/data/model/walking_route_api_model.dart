import 'package:json_annotation/json_annotation.dart';

part 'walking_route_api_model.g.dart';

@JsonSerializable()
class WalkingRouteProperties {
  @JsonKey(name: 'OBJECTID')
  final int objectId;
  final String? name;
  final String? introduction;
  final String? difficulty;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  @JsonKey(name: 'dateLoadedToGIS')
  final String? dateLoadedToGis;

  WalkingRouteProperties({
    required this.objectId,
    this.name,
    this.introduction,
    this.difficulty,
    this.completionTime,
    this.hasAlerts,
    this.introductionThumbnail,
    this.walkingAndTrampingWebPage,
    this.dateLoadedToGis,
  });

  factory WalkingRouteProperties.fromJson(Map<String, dynamic> json) =>
      _$WalkingRoutePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRoutePropertiesToJson(this);
}

@JsonSerializable()
class WalkingRouteFeature {
  final String type;
  final int id;
  final WalkingRouteGeometry geometry;
  final WalkingRouteProperties properties;

  WalkingRouteFeature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory WalkingRouteFeature.fromJson(Map<String, dynamic> json) =>
      _$WalkingRouteFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRouteFeatureToJson(this);
}

@JsonSerializable()
class WalkingRouteGeometry {
  final String type;
  final dynamic coordinates;

  WalkingRouteGeometry({required this.type, required this.coordinates});

  factory WalkingRouteGeometry.fromJson(Map<String, dynamic> json) =>
      _$WalkingRouteGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRouteGeometryToJson(this);
}

@JsonSerializable()
class WalkingRouteFeatureCollection {
  final String type;
  final List<WalkingRouteFeature> features;

  WalkingRouteFeatureCollection({required this.type, required this.features});

  factory WalkingRouteFeatureCollection.fromJson(Map<String, dynamic> json) =>
      _$WalkingRouteFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRouteFeatureCollectionToJson(this);
}
