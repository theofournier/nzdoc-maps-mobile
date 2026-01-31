import 'package:nzdoc_maps_mobile/data/model/walking_route_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';

LineGeometry _parseLineGeometry(String type, dynamic coordinates) {
  try {
    if (type == 'MultiLineString') {
      final multiLineCoords = (coordinates as List<dynamic>)
          .map(
            (line) => (line as List<dynamic>)
                .map((coord) => Point(x: coord[0], y: coord[1]))
                .toList(),
          )
          .toList();
      return MultiLineString(coordinates: multiLineCoords);
    } else if (type == 'LineString') {
      final lineCoords = (coordinates as List<dynamic>)
          .map((coord) => Point(x: coord[0], y: coord[1]))
          .toList();
      return LineString(coordinates: lineCoords);
    }
    return LineString(coordinates: []);
  } catch (e) {
    print("Error parsing line geometry: $e");
    return LineString(coordinates: []);
  }
}

class WalkingRoute {
  final LineGeometry line;

  final int id;

  WalkingRoute({required this.line, required this.id});

  factory WalkingRoute.fromWalkingRouteApi(WalkingRouteFeature walkingFeature) {
    return WalkingRoute(
      line: _parseLineGeometry(
        walkingFeature.geometry.type,
        walkingFeature.geometry.coordinates,
      ),
      id: walkingFeature.properties.objectId,
    );
  }
}
