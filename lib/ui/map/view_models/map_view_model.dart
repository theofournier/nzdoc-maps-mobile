import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/data/repositories/location_repository.dart';
import 'dart:ui' as ui;

enum FilterType { campsites, walkings }

class MarkerData {
  final Marker marker;
  final dynamic data;

  MarkerData({required this.marker, required this.data});
}

class MapViewModel extends ChangeNotifier {
  MapViewModel({required LocationRepository locationRepository})
    : _locationRepository = locationRepository {
    _load();
  }
  final LocationRepository _locationRepository;

  final Map<MarkerId, MarkerData> _markers = {};
  Map<MarkerId, MarkerData> get markers => _markers;

  late BitmapDescriptor _campingIcon;
  late BitmapDescriptor _walkingIcon;

  final Set<FilterType> _activeFilters = {
    FilterType.campsites,
    FilterType.walkings,
  };

  Future<void> _load() async {
    try {
      // Load marker icons from SVG
      _campingIcon = await _getSvgIcon('assets/doc_icons/camping.svg');
      _walkingIcon = await _getSvgIcon(
        'assets/doc_icons/easy-walking-track.svg',
      );

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
            icon: _campingIcon,
          );
          _markers[markerId] = MarkerData(marker: marker, data: campsite);
        }
      }
      if (_activeFilters.contains(FilterType.walkings)) {
        for (final walking in walkings) {
          final markerId = MarkerId('walking_${walking.id}');
          final marker = Marker(
            markerId: markerId,
            position: LatLng(walking.point.y, walking.point.x),
            infoWindow: InfoWindow(title: walking.name),
            icon: _walkingIcon,
          );
          _markers[markerId] = MarkerData(marker: marker, data: walking);
        }
      }

      print('markers loaded: ${_markers.length}');
    } finally {
      notifyListeners();
    }
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
