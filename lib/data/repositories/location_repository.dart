import 'package:nzdoc_maps_mobile/data/services/doc_api_client.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_route_model.dart';

class LocationRepository {
  LocationRepository({required DocApiClient docApiClient})
    : _docApiClient = docApiClient;
  final DocApiClient _docApiClient;

  List<Campsite>? _cachedCampsites;
  List<Walking>? _cachedWalkings;

  Future<List<Campsite>> fetchCampsites() async {
    if (_cachedCampsites != null) {
      return _cachedCampsites!;
    }
    try {
      final campsites = await _docApiClient.getCampsitesFromAssets();
      _cachedCampsites = campsites.features
          .map((campsiteApi) => Campsite.fromCampsiteApi(campsiteApi))
          .toList();
      return _cachedCampsites!;
    } catch (e) {
      print("Error loading campsites: $e");
      return [];
    }
  }

  Future<List<Walking>> fetchWalkings() async {
    if (_cachedWalkings != null) {
      return _cachedWalkings!;
    }
    try {
      final walkings = await _docApiClient.getWalkingFromAssets();
      final walkingRoutes = await _docApiClient.getWalkingRoutesFromAssets();
      _cachedWalkings = walkings.features.map((walkingApi) {
        final route = walkingRoutes.features
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
        return Walking.fromWalkingApi(
          walkingApi,
          route: route != null ? WalkingRoute.fromWalkingRouteApi(route) : null,
        );
      }).toList();
      return _cachedWalkings!;
    } catch (e) {
      print("Error loading walkings: $e");
      return [];
    }
  }
}
