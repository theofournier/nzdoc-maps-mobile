import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';

enum Difficulty {
  easiest("Easiest"),
  easy("Easy"),
  intermediate("Intermediate"),
  advanced("Advanced"),
  expert("Expert");

  final String displayName;

  const Difficulty(this.displayName);
}

Difficulty? _parseDifficulty(String value) {
  switch (value) {
    case 'Easiest':
      return Difficulty.easiest;
    case 'Easy':
      return Difficulty.easy;
    case 'Intermediate':
      return Difficulty.intermediate;
    case 'Advanced':
      return Difficulty.advanced;
    case 'Expert':
      return Difficulty.expert;
    default:
      return null;
  }
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
  });

  factory Walking.fromWalkingApi(WalkingFeature walkingFeature) {
    return Walking(
      point: Point(
        x: walkingFeature.geometry.longitude,
        y: walkingFeature.geometry.latitude,
      ),
      id: walkingFeature.properties.objectId,
      name: walkingFeature.properties.name,
      introduction: walkingFeature.properties.introduction,
      difficulty: walkingFeature.properties.difficulty
          ?.split(', ')
          .map((f) => _parseDifficulty(f.trim()))
          .where((f) => f != null)
          .cast<Difficulty>()
          .toList(),
      completionTime: walkingFeature.properties.completionTime,
      hasAlerts: walkingFeature.properties.hasAlerts,
      introductionThumbnail: walkingFeature.properties.introductionThumbnail,
      walkingAndTrampingWebPage:
          walkingFeature.properties.walkingAndTrampingWebPage,
      dateLoadedToGis: walkingFeature.properties.dateLoadedToGis,
    );
  }
}
