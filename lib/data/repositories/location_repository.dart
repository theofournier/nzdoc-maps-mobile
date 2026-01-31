import 'package:nzdoc_maps_mobile/data/model/campsite_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_route_api_model.dart';
import 'package:nzdoc_maps_mobile/data/services/doc_api_client.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_route_model.dart';
import 'package:nzdoc_maps_mobile/utils/result.dart';

class LocationRepository {
  LocationRepository({required DocApiClient docApiClient})
    : _docApiClient = docApiClient;
  final DocApiClient _docApiClient;

  List<Campsite>? _cachedCampsites;
  List<Walking>? _cachedWalkings;

  Future<Result<List<Campsite>>> fetchCampsites() async {
    if (_cachedCampsites != null) {
      return Result.ok(_cachedCampsites!);
    }
    try {
      final campsitesResult = await _docApiClient.getCampsitesFromAssets();
      switch (campsitesResult) {
        case Ok<CampsiteFeatureCollection>():
          _cachedCampsites = campsitesResult.value.features
              .map((campsiteApi) => Campsite.fromCampsiteApi(campsiteApi))
              .toList();
          return Result.ok(_cachedCampsites!);
        case Error<CampsiteFeatureCollection>():
          return Result.error(campsitesResult.error);
      }
    } on Exception catch (e) {
      print("Error loading campsites: $e");
      return Result.error(e);
    }
  }

  Future<Result<List<Walking>>> fetchWalkings() async {
    if (_cachedWalkings != null) {
      return Result.ok(_cachedWalkings!);
    }
    try {
      final walkingsResult = await _docApiClient.getWalkingFromAssets();
      final walkingRoutesResult = await _docApiClient
          .getWalkingRoutesFromAssets();
      switch (walkingsResult) {
        case Ok<WalkingFeatureCollection>():
          final walkings = walkingsResult.value;
          _cachedWalkings = walkings.features.map((walkingApi) {
            WalkingRouteFeature? route;
            if (walkingRoutesResult is Ok<WalkingRouteFeatureCollection>) {
              route = walkingRoutesResult.value.features
                  .where(
                    (routeApi) =>
                        routeApi.properties.name == walkingApi.properties.name,
                  )
                  .firstOrNull;
              if (route == null) {
                print(
                  "No route found for walking id ${walkingApi.properties.objectId}",
                );
              }
            }
            return Walking.fromWalkingApi(
              walkingApi,
              route: route != null
                  ? WalkingRoute.fromWalkingRouteApi(route)
                  : null,
            );
          }).toList();
          return Result.ok(_cachedWalkings!);
        case Error<WalkingFeatureCollection>():
          return Result.error(walkingsResult.error);
      }
    } on Exception catch (e) {
      print("Error loading walkings: $e");
      return Result.error(e);
    }
  }
}
