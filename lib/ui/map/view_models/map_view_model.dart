import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/data/repositories/location_repository.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';
import 'dart:ui' as ui;

import 'package:nzdoc_maps_mobile/utils/command.dart';
import 'package:nzdoc_maps_mobile/utils/result.dart';

enum FilterType { campsites, walkings }

class MarkerData {
  final Marker marker;
  final dynamic data;

  MarkerData({required this.marker, required this.data});
}

class MapViewModel extends ChangeNotifier {
  MapViewModel({required LocationRepository locationRepository})
    : _locationRepository = locationRepository {
    loadLocations = Command0<void>(_load)..execute();
  }

  late final Command0<void> loadLocations;

  final LocationRepository _locationRepository;

  final Map<MarkerId, MarkerData> _markers = {};
  Map<MarkerId, MarkerData> get markers => _markers;

  MarkerId? _selectedMarkerId;
  MarkerId? get selectedMarkerId => _selectedMarkerId;
  dynamic get selectedData =>
      _selectedMarkerId != null ? _markers[_selectedMarkerId]?.data : null;

  void selectMarker(MarkerId id) {
    _selectedMarkerId = id;
    _updatePolylinesForSelection();
    notifyListeners();
  }

  void clearSelection() {
    _selectedMarkerId = null;
    _polylines.clear();
    notifyListeners();
  }

  late BitmapDescriptor _campingIcon;
  late BitmapDescriptor _walkingIcon;

  final Set<FilterType> _activeFilters = {FilterType.campsites};

  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  void _updatePolylinesForSelection() {
    _polylines.clear();
    if (_selectedMarkerId == null) return;
    final md = _markers[_selectedMarkerId];
    if (md == null) return;
    final data = md.data;
    if (data is! Walking) return;
    final route = data.route;
    if (route == null) return;
    final line = route.line;
    if (line is LineString) {
      final points = line.coordinates.map((p) => LatLng(p.y, p.x)).toList();
      _polylines.add(
        Polyline(
          polylineId: PolylineId('walking_${data.id}_0'),
          points: points,
          color: ui.Color(0xFF1E88E5),
          width: 4,
        ),
      );
    } else if (line is MultiLineString) {
      for (var i = 0; i < line.coordinates.length; i++) {
        final points = line.coordinates[i]
            .map((p) => LatLng(p.y, p.x))
            .toList();
        _polylines.add(
          Polyline(
            polylineId: PolylineId('walking_${data.id}_$i'),
            points: points,
            color: ui.Color(0xFF1E88E5),
            width: 4,
          ),
        );
      }
    }
  }

  bool isFilterActive(FilterType type) => _activeFilters.contains(type);

  /// Enable or disable a filter and reload markers.
  void setFilterActive(FilterType type, bool enabled) {
    if (enabled) {
      _activeFilters.add(type);
    } else {
      _activeFilters.remove(type);
    }
    // Reload markers according to updated filters.
    _load();
  }

  Future<Result<void>> _load() async {
    try {
      // Load marker icons from SVG
      _campingIcon = await _getSvgIcon('assets/doc_icons/camping.svg');
      _walkingIcon = await _getSvgIcon(
        'assets/doc_icons/easy-walking-track.svg',
      );

      final campsitesResult = await _locationRepository.fetchCampsites();
      final walkingsResult = await _locationRepository.fetchWalkings();

      _markers.clear();
      switch (campsitesResult) {
        case Ok<List<Campsite>>():
          if (_activeFilters.contains(FilterType.campsites)) {
            for (final campsite in campsitesResult.value) {
              final markerId = MarkerId('campsite_${campsite.id}');
              final marker = Marker(
                markerId: markerId,
                position: LatLng(campsite.point.y, campsite.point.x),
                infoWindow: InfoWindow(title: campsite.name),
                icon: _campingIcon,
                onTap: () => selectMarker(markerId),
              );
              _markers[markerId] = MarkerData(marker: marker, data: campsite);
            }
          }
        case Error():
          print('Error loading campsites: ${campsitesResult.error}');
      }
      switch (walkingsResult) {
        case Ok<List<Walking>>():
          if (_activeFilters.contains(FilterType.walkings)) {
            for (final walking in walkingsResult.value) {
              final markerId = MarkerId('walking_${walking.id}');
              final marker = Marker(
                markerId: markerId,
                position: LatLng(walking.point.y, walking.point.x),
                infoWindow: InfoWindow(title: walking.name),
                icon: _walkingIcon,
                onTap: () => selectMarker(markerId),
              );
              _markers[markerId] = MarkerData(marker: marker, data: walking);
            }
          }
        case Error():
          print('Error loading walkings: ${walkingsResult.error}');
      }

      print('markers loaded: ${_markers.length}');
    } finally {
      _updatePolylinesForSelection();
      notifyListeners();
    }
    return Result.ok(null);
  }

  Future<BitmapDescriptor> _getSvgIcon(String assetPath) async {
    const double iconSize = 64;

    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgAssetLoader(assetPath),
      null,
    );

    final ui.Image image = await pictureInfo.picture.toImage(
      iconSize.toInt(),
      iconSize.toInt(),
    );

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return BitmapDescriptor.bytes(
      byteData!.buffer.asUint8List(),
      width: iconSize,
      height: iconSize,
    );
  }
}
