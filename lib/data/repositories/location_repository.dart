import 'package:nzdoc_maps_mobile/data/services/doc_api_client.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';

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
      _cachedWalkings = walkings.features
          .map((walkingApi) => Walking.fromWalkingApi(walkingApi))
          .toList();
      return _cachedWalkings!;
    } catch (e) {
      print("Error loading walkings: $e");
      return [];
    }
  }
}
