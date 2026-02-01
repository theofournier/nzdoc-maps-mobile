import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';

final Color routeColor = Color(0xFFEA3322);
final int routeWidth = 3;

Set<Polyline> createRoutePolylines(LineGeometry line, int id) {
  final Set<Polyline> polylines = {};
  if (line is LineString) {
    final points = line.coordinates.map((p) => LatLng(p.y, p.x)).toList();
    polylines.add(
      Polyline(
        polylineId: PolylineId('walking_${id}_0'),
        points: points,
        color: routeColor,
        width: routeWidth,
      ),
    );
  } else if (line is MultiLineString) {
    for (var i = 0; i < line.coordinates.length; i++) {
      final points = line.coordinates[i].map((p) => LatLng(p.y, p.x)).toList();
      polylines.add(
        Polyline(
          polylineId: PolylineId('walking_${id}_$i'),
          points: points,
          color: routeColor,
          width: routeWidth,
        ),
      );
    }
  }
  return polylines;
}
