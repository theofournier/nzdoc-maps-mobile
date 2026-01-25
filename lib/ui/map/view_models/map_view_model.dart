import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/data/repositories/location_repository.dart';

enum FilterType { campsites, walkings }

class MapViewModel extends ChangeNotifier {
  MapViewModel({required LocationRepository locationRepository})
    : _locationRepository = locationRepository {
    _load();
  }
  final LocationRepository _locationRepository;

  final Map<MarkerId, Marker> _markers = {};
  Map<MarkerId, Marker> get markers => _markers;

  final Set<FilterType> _activeFilters = {FilterType.campsites, FilterType.walkings};

  Future<void> _load() async {
    try {
      final campsites = await _locationRepository.fetchCampsites();
      final walkings = await _locationRepository.fetchWalkings();

      _markers.clear();
      if (_activeFilters.contains(FilterType.campsites)) {
        for (final campsite in campsites) {
          final markerId = MarkerId('campsite_${campsite.id}');
          final marker = Marker(
            markerId: markerId,
            position: LatLng(campsite.point.y, campsite.point.x),
            infoWindow: InfoWindow(title: campsite.name),
          );
          _markers[markerId] = marker;
        }
      }
      if (_activeFilters.contains(FilterType.walkings)) {
        for (final walking in walkings) {
          final markerId = MarkerId('walking_${walking.id}');
          final marker = Marker(
            markerId: markerId,
            position: LatLng(walking.point.y, walking.point.x),
            infoWindow: InfoWindow(title: walking.name),
          );
          _markers[markerId] = marker;
        }
      }

      print('markers loaded: ${_markers.length}');
    } finally {
      notifyListeners();
    }
  }
}
