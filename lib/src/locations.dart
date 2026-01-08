import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_annotation/json_annotation.dart';
import 'package:nzdoc_maps_mobile/src/assets.dart';

part 'locations.g.dart';

@JsonSerializable()
class Campsite {
  final int? objectId;
  final String? name;
  final String? place;
  final String? region;
  final String? introduction;
  final String? campsiteCategory;
  final int? numberOfPoweredSites;
  final int? numberOfUnpoweredSites;
  final bool? bookable;
  final String? facilities;
  final String? activities;
  final bool? dogsAllowed;
  final String? landscape;
  final String? access;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? staticLink;
  final String? locationString;
  final double? latitude;
  final double? longitude;
  final double? x;
  final double? y;
  final String? assetId;
  final String? dateLoadedToGis;
  final String? globalId;

  Campsite({
    this.objectId,
    this.name,
    this.place,
    this.region,
    this.introduction,
    this.campsiteCategory,
    this.numberOfPoweredSites,
    this.numberOfUnpoweredSites,
    this.bookable,
    this.facilities,
    this.activities,
    this.dogsAllowed,
    this.landscape,
    this.access,
    this.hasAlerts,
    this.introductionThumbnail,
    this.staticLink,
    this.locationString,
    this.latitude,
    this.longitude,
    this.x,
    this.y,
    this.assetId,
    this.dateLoadedToGis,
    this.globalId,
  });

  factory Campsite.fromJson(Map<String, dynamic> json) =>
      _$CampsiteFromJson(json);

  Map<String, dynamic> toJson() => _$CampsiteToJson(this);
}

@JsonSerializable()
class WalkingExperience {
  final int? objectId;
  final String? name;
  final String? introduction;
  final String? difficulty;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  final double? latitude;
  final double? longitude;
  final String? dateLoadedToGis;

  WalkingExperience({
    this.objectId,
    this.name,
    this.introduction,
    this.difficulty,
    this.completionTime,
    this.hasAlerts,
    this.introductionThumbnail,
    this.walkingAndTrampingWebPage,
    this.latitude,
    this.longitude,
    this.dateLoadedToGis,
  });

  factory WalkingExperience.fromJson(Map<String, dynamic> json) =>
      _$WalkingExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingExperienceToJson(this);
}

@JsonSerializable()
class CampsiteFeature {
  final String type;
  final int id;
  final CampsiteGeometry geometry;
  final Map<String, dynamic> properties;

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
class WalkingExperienceFeature {
  final String type;
  final int id;
  final WalkingGeometry geometry;
  final Map<String, dynamic> properties;

  WalkingExperienceFeature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  factory WalkingExperienceFeature.fromJson(Map<String, dynamic> json) =>
      _$WalkingExperienceFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingExperienceFeatureToJson(this);
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
class WalkingGeometry {
  final String type;
  final dynamic coordinates;

  WalkingGeometry({required this.type, required this.coordinates});

  factory WalkingGeometry.fromJson(Map<String, dynamic> json) =>
      _$WalkingGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingGeometryToJson(this);
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

@JsonSerializable()
class WalkingExperienceFeatureCollection {
  final String type;
  final List<WalkingExperienceFeature> features;

  WalkingExperienceFeatureCollection({
    required this.type,
    required this.features,
  });

  factory WalkingExperienceFeatureCollection.fromJson(
    Map<String, dynamic> json,
  ) => _$WalkingExperienceFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WalkingExperienceFeatureCollectionToJson(this);
}

@JsonSerializable()
class WalkingRoute {
  final int? objectId;
  final String? name;
  final String? introduction;
  final String? difficulty;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  final String? dateLoadedToGis;

  WalkingRoute({
    this.objectId,
    this.name,
    this.introduction,
    this.difficulty,
    this.completionTime,
    this.hasAlerts,
    this.introductionThumbnail,
    this.walkingAndTrampingWebPage,
    this.dateLoadedToGis,
  });

  factory WalkingRoute.fromJson(Map<String, dynamic> json) =>
      _$WalkingRouteFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRouteToJson(this);
}

@JsonSerializable()
class WalkingRouteFeature {
  final String type;
  final int id;
  final WalkingGeometry geometry;
  final WalkingRoute properties;

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
class WalkingRouteFeatureCollection {
  final String type;
  final List<WalkingRouteFeature> features;

  WalkingRouteFeatureCollection({required this.type, required this.features});

  factory WalkingRouteFeatureCollection.fromJson(Map<String, dynamic> json) =>
      _$WalkingRouteFeatureCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$WalkingRouteFeatureCollectionToJson(this);
}

// --- Asset loaders ---

Future<CampsiteFeatureCollection> loadCampsitesFromAssets() async {
  final jsonStr = await rootBundle.loadString(Assets.campsites);
  final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
  return CampsiteFeatureCollection.fromJson(jsonMap);
}

Future<WalkingExperienceFeatureCollection>
loadWalkingExperiencesFromAssets() async {
  final jsonStr = await rootBundle.loadString(Assets.walkings);
  final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
  return WalkingExperienceFeatureCollection.fromJson(jsonMap);
}

Future<WalkingRouteFeatureCollection> loadWalkingRoutesFromAssets() async {
  final jsonStr = await rootBundle.loadString(Assets.walkingRoutes);
  final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
  return WalkingRouteFeatureCollection.fromJson(jsonMap);
}
