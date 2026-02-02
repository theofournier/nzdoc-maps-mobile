import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';

Future<BitmapDescriptor> _getAssetIcon(String assetPath) async {
  final imageData = await BitmapDescriptor.asset(
    const ImageConfiguration(size: Size(28, 28)),
    assetPath,
  );
  return imageData;
}

Future<BitmapDescriptor> getMarkerIcon(
  dynamic data, {
  bool selected = false,
}) async {
  String iconPath;
  if (data is Campsite) {
    iconPath = 'assets/doc_icons/camping.webp';
  } else if (data is Walking) {
    iconPath = data.difficulties?.firstOrNull?.asset ?? Difficulty.easy.asset;
  } else {
    throw ArgumentError(
      'Unsupported data type for marker icon: ${data.runtimeType}',
    );
  }
  if (selected) {
    iconPath = iconPath.replaceFirst('.webp', '_selected.webp');
  }
  return await _getAssetIcon(iconPath);
}

Future<Marker> getMarker(
  dynamic data, {
  void Function(MarkerId)? onTap,
  bool selected = false,
}) async {
  MarkerId markerId;
  LatLng position;
  if (data is Campsite) {
    markerId = MarkerId('campsite_${data.id}');
    position = LatLng(data.point.y, data.point.x);
  } else if (data is Walking) {
    markerId = MarkerId('walking_${data.id}');
    position = LatLng(data.point.y, data.point.x);
  } else {
    throw ArgumentError(
      'Unsupported data type for marker: ${data.runtimeType}',
    );
  }
  final icon = await getMarkerIcon(data, selected: selected);
  return Marker(
    markerId: markerId,
    position: position,
    icon: icon,
    onTap: () => onTap?.call(markerId),
    anchor: Offset(0.5, 0.5),
  );
}
