// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalkingProperties _$WalkingPropertiesFromJson(Map<String, dynamic> json) =>
    WalkingProperties(
      objectId: (json['OBJECTID'] as num).toInt(),
      name: json['name'] as String,
      introduction: json['introduction'] as String?,
      difficulty: json['difficulty'] as String?,
      completionTime: json['completionTime'] as String?,
      hasAlerts: json['hasAlerts'] as String?,
      introductionThumbnail: json['introductionThumbnail'] as String?,
      walkingAndTrampingWebPage: json['walkingAndTrampingWebPage'] as String?,
      dateLoadedToGis: json['dateLoadedToGIS'] as String?,
    );

Map<String, dynamic> _$WalkingPropertiesToJson(WalkingProperties instance) =>
    <String, dynamic>{
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

WalkingGeometry _$WalkingGeometryFromJson(Map<String, dynamic> json) =>
    WalkingGeometry(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$WalkingGeometryToJson(WalkingGeometry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

WalkingFeature _$WalkingFeatureFromJson(Map<String, dynamic> json) =>
    WalkingFeature(
      type: json['type'] as String,
      id: (json['id'] as num?)?.toInt(),
      geometry: WalkingGeometry.fromJson(
        json['geometry'] as Map<String, dynamic>,
      ),
      properties: WalkingProperties.fromJson(
        json['properties'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WalkingFeatureToJson(WalkingFeature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };

WalkingFeatureCollection _$WalkingFeatureCollectionFromJson(
  Map<String, dynamic> json,
) => WalkingFeatureCollection(
  type: json['type'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => WalkingFeature.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WalkingFeatureCollectionToJson(
  WalkingFeatureCollection instance,
) => <String, dynamic>{'type': instance.type, 'features': instance.features};
