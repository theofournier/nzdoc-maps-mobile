// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campsite_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampsiteProperties _$CampsitePropertiesFromJson(Map<String, dynamic> json) =>
    CampsiteProperties(
      objectId: (json['OBJECTID'] as num).toInt(),
      name: json['name'] as String,
      place: json['place'] as String?,
      region: json['region'] as String?,
      introduction: json['introduction'] as String?,
      campsiteCategory: json['campsiteCategory'] as String?,
      numberOfPoweredSites: (json['numberOfPoweredSites'] as num?)?.toInt(),
      numberOfUnpoweredSites: (json['numberOfUnpoweredSites'] as num?)?.toInt(),
      bookable: json['bookable'] as String?,
      free: json['free'] as bool?,
      facilities: json['facilities'] as String?,
      activities: json['activities'] as String?,
      dogsAllowed: json['dogsAllowed'] as String?,
      landscape: json['landscape'] as String?,
      access: json['access'] as String?,
      hasAlerts: json['hasAlerts'] as String?,
      introductionThumbnail: json['introductionThumbnail'] as String?,
      staticLink: json['staticLink'] as String?,
      locationString: json['locationString'] as String?,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      assetId: (json['assetId'] as num).toInt(),
      dateLoadedToGis: json['dateLoadedToGIS'] as String?,
      globalId: json['GlobalID'] as String?,
    );

Map<String, dynamic> _$CampsitePropertiesToJson(CampsiteProperties instance) =>
    <String, dynamic>{
      'OBJECTID': instance.objectId,
      'name': instance.name,
      'place': instance.place,
      'region': instance.region,
      'introduction': instance.introduction,
      'campsiteCategory': instance.campsiteCategory,
      'numberOfPoweredSites': instance.numberOfPoweredSites,
      'numberOfUnpoweredSites': instance.numberOfUnpoweredSites,
      'bookable': instance.bookable,
      'free': instance.free,
      'facilities': instance.facilities,
      'activities': instance.activities,
      'dogsAllowed': instance.dogsAllowed,
      'landscape': instance.landscape,
      'access': instance.access,
      'hasAlerts': instance.hasAlerts,
      'introductionThumbnail': instance.introductionThumbnail,
      'staticLink': instance.staticLink,
      'locationString': instance.locationString,
      'x': instance.x,
      'y': instance.y,
      'assetId': instance.assetId,
      'dateLoadedToGIS': instance.dateLoadedToGis,
      'GlobalID': instance.globalId,
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

CampsiteFeature _$CampsiteFeatureFromJson(Map<String, dynamic> json) =>
    CampsiteFeature(
      type: json['type'] as String,
      id: (json['id'] as num).toInt(),
      geometry: CampsiteGeometry.fromJson(
        json['geometry'] as Map<String, dynamic>,
      ),
      properties: CampsiteProperties.fromJson(
        json['properties'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CampsiteFeatureToJson(CampsiteFeature instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'geometry': instance.geometry,
      'properties': instance.properties,
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
