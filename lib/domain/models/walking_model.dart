import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/location_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_route_model.dart';

enum Difficulty {
  easiest("Easiest", "assets/doc_icons/easiest-short-walk.webp"),
  easy("Easy", "assets/doc_icons/easy-walking-track.webp"),
  intermediate(
    "Intermediate",
    "assets/doc_icons/Intermediate-great-walk-or-easier-tramping-track.webp",
  ),
  advanced("Advanced", "assets/doc_icons/advanced-tramping-track.webp"),
  expert("Expert", "assets/doc_icons/expert-route.webp");

  final String displayName;
  final String asset;

  const Difficulty(this.displayName, this.asset);
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

class Walking extends Location {
  final String? introduction;
  final List<Difficulty>? difficulties;
  final String? completionTime;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? walkingAndTrampingWebPage;
  final String? dateLoadedToGis;

  final WalkingRoute? route;

  Walking({
    required super.point,
    required super.id,
    required super.name,
    this.introduction,
    this.difficulties,
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
      difficulties: walkingFeature.properties.difficulty != null
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
