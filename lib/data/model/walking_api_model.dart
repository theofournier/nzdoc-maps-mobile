import 'package:json_annotation/json_annotation.dart';

part 'walking_api_model.g.dart';

@JsonSerializable()
class WalkingProperties {
  @JsonKey(name: 'OBJECTID')
  final int objectId;
  final String name;
  final String? introduction;
  final String? difficulty;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  @JsonKey(name: 'dateLoadedToGIS')
  final String? dateLoadedToGis;

  WalkingProperties({
    required this.objectId,
    required this.name,
    this.introduction,
    this.difficulty,
    this.completionTime,
    this.hasAlerts,
    this.introductionThumbnail,
    this.walkingAndTrampingWebPage,
    this.dateLoadedToGis,
  });

  factory WalkingProperties.fromJson(Map<String, dynamic> json) =>
      _$WalkingPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingPropertiesToJson(this);
}

@JsonSerializable()
class WalkingGeometry {
  final String type;
  final List<double> coordinates;

  WalkingGeometry({required this.type, required this.coordinates});

  factory WalkingGeometry.fromJson(Map<String, dynamic> json) =>
      _$WalkingGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingGeometryToJson(this);

  double get longitude => coordinates[0];
  double get latitude => coordinates[1];
}

@JsonSerializable()
class WalkingFeature {
  final String type;
  final int? id;
  final WalkingGeometry geometry;
  final WalkingProperties properties;

  WalkingFeature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory WalkingFeature.fromJson(Map<String, dynamic> json) =>
      _$WalkingFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingFeatureToJson(this);
}

@JsonSerializable()
class WalkingFeatureCollection {
  final String type;
  final List<WalkingFeature> features;

  WalkingFeatureCollection({required this.type, required this.features});

  factory WalkingFeatureCollection.fromJson(Map<String, dynamic> json) =>
      _$WalkingFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingFeatureCollectionToJson(this);
}
