import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/data/repositories/location_repository.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/location_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/markers.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/route_polyline.dart';

import 'package:nzdoc_maps_mobile/utils/command.dart';
import 'package:nzdoc_maps_mobile/utils/result.dart';

enum FilterType { campsites, walkings }

class MarkerData {
  final Marker marker;
  final Location data;

  MarkerData({required this.marker, required this.data});
}

class MapViewModel extends ChangeNotifier {
  MapViewModel({required LocationRepository locationRepository})
    : _locationRepository = locationRepository {
    loadMarkers = Command0<void>(_loadMarkers)..execute();
  }

  late final Command0<void> loadMarkers;

  final LocationRepository _locationRepository;

  final Map<MarkerId, MarkerData> _markers = {};
  Map<MarkerId, MarkerData> get markers => _markers;

  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  MarkerId? _selectedMarkerId;
  MarkerId? get selectedMarkerId => _selectedMarkerId;
  Location? get selectedData =>
      _selectedMarkerId != null ? _markers[_selectedMarkerId]?.data : null;

  Future<void> _updateSelectedMarker(MarkerId id, bool selected) async {
    final selectedMarkerIcon = await getMarkerIcon(
      _markers[id]!.data,
      selected: selected,
    );

    _markers.update(id, (md) {
      return MarkerData(
        marker: md.marker.copyWith(
          iconParam: selectedMarkerIcon,
          zIndexIntParam: selected ? 1 : 0,
        ),
        data: md.data,
      );
    });
  }

  Future<void> selectMarker(MarkerId id) async {
    clearSelection();

    _selectedMarkerId = id;
    _updatePolylinesForSelection();
    await _updateSelectedMarker(id, true);
    notifyListeners();
  }

  Future<void> clearSelection() async {
    final id = _selectedMarkerId;
    _selectedMarkerId = null;
    _polylines.clear();
    if (id != null) {
      await _updateSelectedMarker(id, false);
    }
    notifyListeners();
  }

  void _updatePolylinesForSelection() {
    _polylines.clear();
    if (_selectedMarkerId == null) return;
    final md = _markers[_selectedMarkerId];
    if (md == null) return;
    final data = md.data;
    if (data is! Walking) return;
    final route = data.route;
    if (route == null) return;
    _polylines.addAll(createRoutePolylines(route.line, data.id));
  }

  final Set<FilterType> _activeFilters = {FilterType.campsites};

  bool isFilterActive(FilterType type) => _activeFilters.contains(type);

  void setFilterActive(FilterType type, bool enabled) {
    if (enabled) {
      _activeFilters.add(type);
    } else {
      _activeFilters.remove(type);
    }
    loadMarkers.execute();
  }

  Future<Result<void>> _loadMarkers() async {
    try {
      _markers.clear();
      if (_activeFilters.contains(FilterType.campsites)) {
        final campsitesResult = await _locationRepository.fetchCampsites();
        switch (campsitesResult) {
          case Ok<List<Campsite>>():
            for (final campsite in campsitesResult.value) {
              final marker = await getMarker(
                campsite,
                onTap: (markerId) => selectMarker(markerId),
              );
              _markers[marker.markerId] = MarkerData(
                marker: marker,
                data: campsite,
              );
            }
          case Error():
            print('Error loading campsites: ${campsitesResult.error}');
        }
      }
      if (_activeFilters.contains(FilterType.walkings)) {
        final walkingsResult = await _locationRepository.fetchWalkings();
        switch (walkingsResult) {
          case Ok<List<Walking>>():
            for (final walking in walkingsResult.value) {
              final marker = await getMarker(
                walking,
                onTap: (markerId) => selectMarker(markerId),
              );
              _markers[marker.markerId] = MarkerData(
                marker: marker,
                data: walking,
              );
            }
          case Error():
            print('Error loading walkings: ${walkingsResult.error}');
        }
      }

      print('markers loaded: ${_markers.length}');
    } finally {
      _updatePolylinesForSelection();
      notifyListeners();
    }
    return Result.ok(null);
  }
}
