// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walking_route_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalkingRouteProperties _$WalkingRoutePropertiesFromJson(
  Map<String, dynamic> json,
) => WalkingRouteProperties(
  objectId: (json['OBJECTID'] as num).toInt(),
  name: json['name'] as String?,
  introduction: json['introduction'] as String?,
  difficulty: json['difficulty'] as String?,
  completionTime: json['completionTime'] as String?,
  hasAlerts: json['hasAlerts'] as String?,
  introductionThumbnail: json['introductionThumbnail'] as String?,
  walkingAndTrampingWebPage: json['walkingAndTrampingWebPage'] as String?,
  dateLoadedToGis: json['dateLoadedToGIS'] as String?,
);

Map<String, dynamic> _$WalkingRoutePropertiesToJson(
  WalkingRouteProperties instance,
) => <String, dynamic>{
  'OBJECTID': instance.objectId,
  'name': instance.name,
  'introduction': instance.introduction,
  'difficulty': instance.difficulty,
  'completionTime': instance.completionTime,
  'hasAlerts': instance.hasAlerts,
  'introductionThumbnail': instance.introductionThumbnail,
  'walkingAndTrampingWebPage': instance.walkingAndTrampingWebPage,
  'dateLoadedToGIS': instance.dateLoadedToGis,
};

WalkingRouteFeature _$WalkingRouteFeatureFromJson(Map<String, dynamic> json) =>
    WalkingRouteFeature(
      type: json['type'] as String,
      id: (json['id'] as num).toInt(),
      geometry: WalkingRouteGeometry.fromJson(
        json['geometry'] as Map<String, dynamic>,
      ),
      properties: WalkingRouteProperties.fromJson(
        json['properties'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WalkingRouteFeatureToJson(
  WalkingRouteFeature instance,
) => <String, dynamic>{
  'type': instance.type,
  'id': instance.id,
  'geometry': instance.geometry,
  'properties': instance.properties,
};

WalkingRouteGeometry _$WalkingRouteGeometryFromJson(
  Map<String, dynamic> json,
) => WalkingRouteGeometry(
  type: json['type'] as String,
  coordinates: json['coordinates'],
);

Map<String, dynamic> _$WalkingRouteGeometryToJson(
  WalkingRouteGeometry instance,
) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
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
