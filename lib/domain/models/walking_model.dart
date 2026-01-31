import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_route_model.dart';

enum Difficulty {
  easiest("Easiest"),
  easy("Easy"),
  intermediate("Intermediate"),
  advanced("Advanced"),
  expert("Expert");

  final String displayName;

  const Difficulty(this.displayName);
}

List<Difficulty> _parseDifficulties(String difficultiesString) {
  final difficulties = <Difficulty>[];
  var remaining = difficultiesString.trim();

  while (remaining.isNotEmpty) {
    bool found = false;

    // Match longest names first
    final sorted = Difficulty.values.map((e) => e.displayName).toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final name in sorted) {
      if (remaining.startsWith(name)) {
        difficulties.add(
          Difficulty.values.firstWhere((e) => e.displayName == name),
        );
        remaining = remaining.substring(name.length).trim();

        if (remaining.startsWith(',')) {
          remaining = remaining.substring(1).trim();
        }

        found = true;
        break;
      }
    }

    if (!found) {
      final commaIndex = remaining.indexOf(',');
      if (commaIndex != -1) {
        remaining = remaining.substring(commaIndex + 1).trim();
      } else {
        break;
      }
    }
  }

  return difficulties;
}

class Walking {
  final Point point;

  final int id;
  final String name;
  final String? introduction;
  final List<Difficulty>? difficulty;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  final String? dateLoadedToGis;

  final WalkingRoute? route;

  Walking({
    required this.point,
    required this.id,
    required this.name,
    this.introduction,
    this.difficulty,
    this.completionTime,
    this.hasAlerts,
    this.introductionThumbnail,
    this.walkingAndTrampingWebPage,
    this.dateLoadedToGis,
    this.route,
  });

  factory Walking.fromWalkingApi(
    WalkingFeature walkingFeature, {
    WalkingRoute? route,
  }) {
    return Walking(
      point: Point(
        x: walkingFeature.geometry.longitude,
        y: walkingFeature.geometry.latitude,
      ),
      id: walkingFeature.properties.objectId,
      name: walkingFeature.properties.name,
      introduction: walkingFeature.properties.introduction,
      difficulty: walkingFeature.properties.difficulty != null
          ? _parseDifficulties(walkingFeature.properties.difficulty!)
          : null,
      completionTime: walkingFeature.properties.completionTime,
      hasAlerts: walkingFeature.properties.hasAlerts,
      introductionThumbnail: walkingFeature.properties.introductionThumbnail,
      walkingAndTrampingWebPage:
          walkingFeature.properties.walkingAndTrampingWebPage,
      dateLoadedToGis: walkingFeature.properties.dateLoadedToGis,
      route: route,
    );
  }
}
