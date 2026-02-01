import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';

Future<BitmapDescriptor> _getPngIcon(String assetPath) async {
  final imageData = await BitmapDescriptor.asset(
    const ImageConfiguration(size: Size(28, 28)),
    assetPath,
  );
  return imageData;
}

Future<Marker> getCampsiteMarker(
  Campsite campsite,
  void Function(MarkerId) onTap,
) async {
  final markerId = MarkerId('campsite_${campsite.id}');
  final icon = await _getPngIcon('assets/doc_icons/camping.png');
  return Marker(
    markerId: markerId,
    position: LatLng(campsite.point.y, campsite.point.x),
    icon: icon,
    onTap: () => onTap(markerId),
    anchor: Offset(0.5, 0.5),
  );
}

Future<Marker> getWalkingMarker(
  Walking walking,
  void Function(MarkerId) onTap,
) async {
  final markerId = MarkerId('walking_${walking.id}');
  final icon = await _getPngIcon('assets/doc_icons/easy-walking-track.png');
  return Marker(
    markerId: markerId,
    position: LatLng(walking.point.y, walking.point.x),
    icon: icon,
    onTap: () => onTap(markerId),
    anchor: Offset(0.5, 0.5),
  );
}
