// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campsite _$CampsiteFromJson(Map<String, dynamic> json) => Campsite(
  objectId: (json['objectId'] as num?)?.toInt(),
  name: json['name'] as String?,
  place: json['place'] as String?,
  region: json['region'] as String?,
  introduction: json['introduction'] as String?,
  campsiteCategory: json['campsiteCategory'] as String?,
  numberOfPoweredSites: (json['numberOfPoweredSites'] as num?)?.toInt(),
  numberOfUnpoweredSites: (json['numberOfUnpoweredSites'] as num?)?.toInt(),
  bookable: json['bookable'] as bool?,
  facilities: json['facilities'] as String?,
  activities: json['activities'] as String?,
  dogsAllowed: json['dogsAllowed'] as bool?,
  landscape: json['landscape'] as String?,
  access: json['access'] as String?,
  hasAlerts: json['hasAlerts'] as String?,
  introductionThumbnail: json['introductionThumbnail'] as String?,
  staticLink: json['staticLink'] as String?,
  locationString: json['locationString'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  x: (json['x'] as num?)?.toDouble(),
  y: (json['y'] as num?)?.toDouble(),
  assetId: json['assetId'] as String?,
  dateLoadedToGis: json['dateLoadedToGis'] as String?,
  globalId: json['globalId'] as String?,
);

Map<String, dynamic> _$CampsiteToJson(Campsite instance) => <String, dynamic>{
  'objectId': instance.objectId,
  'name': instance.name,
  'place': instance.place,
  'region': instance.region,
  'introduction': instance.introduction,
  'campsiteCategory': instance.campsiteCategory,
  'numberOfPoweredSites': instance.numberOfPoweredSites,
  'numberOfUnpoweredSites': instance.numberOfUnpoweredSites,
  'bookable': instance.bookable,
  'facilities': instance.facilities,
  'activities': instance.activities,
  'dogsAllowed': instance.dogsAllowed,
  'landscape': instance.landscape,
  'access': instance.access,
  'hasAlerts': instance.hasAlerts,
  'introductionThumbnail': instance.introductionThumbnail,
  'staticLink': instance.staticLink,
  'locationString': instance.locationString,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'x': instance.x,
  'y': instance.y,
  'assetId': instance.assetId,
  'dateLoadedToGis': instance.dateLoadedToGis,
  'globalId': instance.globalId,
};

WalkingExperience _$WalkingExperienceFromJson(Map<String, dynamic> json) =>
    WalkingExperience(
      objectId: (json['objectId'] as num?)?.toInt(),
      name: json['name'] as String?,
      introduction: json['introduction'] as String?,
      difficulty: json['difficulty'] as String?,
      completionTime: json['completionTime'] as String?,
      hasAlerts: json['hasAlerts'] as String?,
      introductionThumbnail: json['introductionThumbnail'] as String?,
      walkingAndTrampingWebPage: json['walkingAndTrampingWebPage'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      dateLoadedToGis: json['dateLoadedToGis'] as String?,
    );

Map<String, dynamic> _$WalkingExperienceToJson(WalkingExperience instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'introduction': instance.introduction,
      'difficulty': instance.difficulty,
      'completionTime': instance.completionTime,
      'hasAlerts': instance.hasAlerts,
      'introductionThumbnail': instance.introductionThumbnail,
      'walkingAndTrampingWebPage': instance.walkingAndTrampingWebPage,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'dateLoadedToGis': instance.dateLoadedToGis,
    };

CampsiteFeature _$CampsiteFeatureFromJson(Map<String, dynamic> json) =>
    CampsiteFeature(
      type: json['type'] as String,
      id: (json['id'] as num).toInt(),
      geometry: CampsiteGeometry.fromJson(
        json['geometry'] as Map<String, dynamic>,
      ),
      properties: json['properties'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CampsiteFeatureToJson(CampsiteFeature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

WalkingExperienceFeature _$WalkingExperienceFeatureFromJson(
  Map<String, dynamic> json,
) => WalkingExperienceFeature(
  type: json['type'] as String,
  id: (json['id'] as num).toInt(),
  geometry: WalkingGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  properties: json['properties'] as Map<String, dynamic>,
);

Map<String, dynamic> _$WalkingExperienceFeatureToJson(
  WalkingExperienceFeature instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'geometry': instance.geometry,
  'properties': instance.properties,
};

CampsiteGeometry _$CampsiteGeometryFromJson(Map<String, dynamic> json) =>
    CampsiteGeometry(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$CampsiteGeometryToJson(CampsiteGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

WalkingGeometry _$WalkingGeometryFromJson(Map<String, dynamic> json) =>
    WalkingGeometry(
      type: json['type'] as String,
      coordinates: json['coordinates'],
    );

Map<String, dynamic> _$WalkingGeometryToJson(WalkingGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

CampsiteFeatureCollection _$CampsiteFeatureCollectionFromJson(
  Map<String, dynamic> json,
) => CampsiteFeatureCollection(
  type: json['type'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => CampsiteFeature.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CampsiteFeatureCollectionToJson(
  CampsiteFeatureCollection instance,
) => <String, dynamic>{'type': instance.type, 'features': instance.features};

WalkingExperienceFeatureCollection _$WalkingExperienceFeatureCollectionFromJson(
  Map<String, dynamic> json,
) => WalkingExperienceFeatureCollection(
  type: json['type'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => WalkingExperienceFeature.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WalkingExperienceFeatureCollectionToJson(
  WalkingExperienceFeatureCollection instance,
) => <String, dynamic>{'type': instance.type, 'features': instance.features};

WalkingRoute _$WalkingRouteFromJson(Map<String, dynamic> json) => WalkingRoute(
  objectId: (json['objectId'] as num?)?.toInt(),
  name: json['name'] as String?,
  introduction: json['introduction'] as String?,
  difficulty: json['difficulty'] as String?,
  completionTime: json['completionTime'] as String?,
  hasAlerts: json['hasAlerts'] as String?,
  introductionThumbnail: json['introductionThumbnail'] as String?,
  walkingAndTrampingWebPage: json['walkingAndTrampingWebPage'] as String?,
  dateLoadedToGis: json['dateLoadedToGis'] as String?,
);

Map<String, dynamic> _$WalkingRouteToJson(WalkingRoute instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'name': instance.name,
      'introduction': instance.introduction,
      'difficulty': instance.difficulty,
      'completionTime': instance.completionTime,
      'hasAlerts': instance.hasAlerts,
      'introductionThumbnail': instance.introductionThumbnail,
      'walkingAndTrampingWebPage': instance.walkingAndTrampingWebPage,
      'dateLoadedToGis': instance.dateLoadedToGis,
    };

WalkingRouteFeature _$WalkingRouteFeatureFromJson(
  Map<String, dynamic> json,
) => WalkingRouteFeature(
  type: json['type'] as String,
  id: (json['id'] as num).toInt(),
  geometry: WalkingGeometry.fromJson(json['geometry'] as Map<String, dynamic>),
  properties: WalkingRoute.fromJson(json['properties'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WalkingRouteFeatureToJson(
  WalkingRouteFeature instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'geometry': instance.geometry,
  'properties': instance.properties,
};

WalkingRouteFeatureCollection _$WalkingRouteFeatureCollectionFromJson(
  Map<String, dynamic> json,
) => WalkingRouteFeatureCollection(
  type: json['type'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => WalkingRouteFeature.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WalkingRouteFeatureCollectionToJson(
  WalkingRouteFeatureCollection instance,
) => <String, dynamic>{'type': instance.type, 'features': instance.features};
