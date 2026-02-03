import 'package:nzdoc_maps_mobile/data/model/campsite_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/location_model.dart';

enum CampsiteCategory {
  backcountry('Backcountry'),
  standard('Standard'),
  greatWalk('Great Walk'),
  basic('Basic');

  final String displayName;

  const CampsiteCategory(this.displayName);
}

enum Facility {
  toilets('Toilets'),
  toiletsFlush('Toilets - flush'),
  toiletsNonFlush('Toilets - non-flush'),
  nonPoweredTentSites('Non-powered/tent sites'),
  poweredSites('Powered sites'),
  shelterForCooking('Shelter for cooking'),
  waterFromTap('Water from tap - not treated, boil before use'),
  waterFromTapTreated('Water from tap - treated, suitable for drinking'),
  waterFromStream('Water from stream'),
  waterSupply('Water supply'),
  showerCold('Shower - cold'),
  showerHot('Shower - hot'),
  boatLaunching('Boat launching'),
  jetty('Jetty'),
  bbq('BBQ'),
  firePit('Fire pit/place for campfires (except in fire bans)'),
  cookersElectricStove('Cookers/electric stove'),
  phone('Phone'),
  wheelchairAccessible('Wheelchair accessible'),
  wheelchairAccessibleWithAssistance('Wheelchair accessible with assistance');

  final String displayName;

  const Facility(this.displayName);
}

enum Activity {
  birdAndWildlifeWatching('Bird and wildlife watching'),
  boating('Boating'),
  camping('Camping'),
  caving('Caving'),
  divingAndSnorkelling('Diving and snorkelling'),
  fishing('Fishing'),
  fourWheelDriving('Four wheel driving'),
  hunting('Hunting'),
  kayakingAndCanoeing('Kayaking and canoeing'),
  mountainBiking('Mountain biking'),
  picnicking('Picnicking'),
  rafting('Rafting'),
  skiingAndSkiTouring('Skiing and ski touring'),
  swimming('Swimming'),
  walkingAndTramping('Walking and tramping');

  final String displayName;

  const Activity(this.displayName);
}

enum Landscape {
  alpine('Alpine'),
  coastal('Coastal'),
  forest('Forest'),
  riversAndLakes('Rivers and lakes');

  final String displayName;

  const Landscape(this.displayName);
}

enum Access {
  fourWd('4WD'),
  boat('Boat'),
  campervan('Campervan'),
  car('Car'),
  caravan('Caravan'),
  foot('Foot'),
  mountainBike('Mountain bike');

  final String displayName;

  const Access(this.displayName);
}

List<Facility> _parseFacilities(String facilitiesString) {
  final facilities = <Facility>[];
  var remaining = facilitiesString.trim();

  while (remaining.isNotEmpty) {
    bool found = false;

    // Try to match from longest to shortest to handle facilities with commas first
    final sortedFacilities = Facility.values.map((e) => e.displayName).toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final facilityName in sortedFacilities) {
      if (remaining.startsWith(facilityName)) {
        facilities.add(
          Facility.values.firstWhere((e) => e.displayName == facilityName),
        );
        remaining = remaining.substring(facilityName.length).trim();

        // Remove leading comma and whitespace if present
        if (remaining.startsWith(',')) {
          remaining = remaining.substring(1).trim();
        }

        found = true;
        break;
      }
    }

    if (!found) {
      // Skip unrecognized facilities - find next comma
      final commaIndex = remaining.indexOf(',');
      if (commaIndex != -1) {
        remaining = remaining.substring(commaIndex + 1).trim();
      } else {
        break;
      }
    }
  }

  return facilities;
}

List<Activity> _parseActivities(String activitiesString) {
  final activities = <Activity>[];
  var remaining = activitiesString.trim();

  while (remaining.isNotEmpty) {
    bool found = false;

    // Try to match from longest to shortest
    final sortedActivities = Activity.values.map((e) => e.displayName).toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final activityName in sortedActivities) {
      if (remaining.startsWith(activityName)) {
        activities.add(
          Activity.values.firstWhere((e) => e.displayName == activityName),
        );
        remaining = remaining.substring(activityName.length).trim();

        // Remove leading comma and whitespace if present
        if (remaining.startsWith(',')) {
          remaining = remaining.substring(1).trim();
        }

        found = true;
        break;
      }
    }

    if (!found) {
      // Skip unrecognized activities - find next comma
      final commaIndex = remaining.indexOf(',');
      if (commaIndex != -1) {
        remaining = remaining.substring(commaIndex + 1).trim();
      } else {
        break;
      }
    }
  }

  return activities;
}

List<Landscape> _parseLandscapes(String landscapesString) {
  final landscapes = <Landscape>[];
  var remaining = landscapesString.trim();

  while (remaining.isNotEmpty) {
    bool found = false;

    // Try to match from longest to shortest
    final sortedLandscapes = Landscape.values.map((e) => e.displayName).toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final landscapeName in sortedLandscapes) {
      if (remaining.startsWith(landscapeName)) {
        landscapes.add(
          Landscape.values.firstWhere((e) => e.displayName == landscapeName),
        );
        remaining = remaining.substring(landscapeName.length).trim();

        // Remove leading comma and whitespace if present
        if (remaining.startsWith(',')) {
          remaining = remaining.substring(1).trim();
        }

        found = true;
        break;
      }
    }

    if (!found) {
      // Skip unrecognized landscapes - find next comma
      final commaIndex = remaining.indexOf(',');
      if (commaIndex != -1) {
        remaining = remaining.substring(commaIndex + 1).trim();
      } else {
        break;
      }
    }
  }

  return landscapes;
}

List<Access> _parseAccessList(String accessString) {
  final accessList = <Access>[];
  var remaining = accessString.trim();

  while (remaining.isNotEmpty) {
    bool found = false;

    // Try to match from longest to shortest
    final sortedAccess = Access.values.map((e) => e.displayName).toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final accessName in sortedAccess) {
      if (remaining.startsWith(accessName)) {
        accessList.add(
          Access.values.firstWhere((e) => e.displayName == accessName),
        );
        remaining = remaining.substring(accessName.length).trim();

        // Remove leading comma and whitespace if present
        if (remaining.startsWith(',')) {
          remaining = remaining.substring(1).trim();
        }

        found = true;
        break;
      }
    }

    if (!found) {
      // Skip unrecognized access types - find next comma
      final commaIndex = remaining.indexOf(',');
      if (commaIndex != -1) {
        remaining = remaining.substring(commaIndex + 1).trim();
      } else {
        break;
      }
    }
  }

  return accessList;
}

class Campsite extends Location {
  final Point point;

  final int id;
  final String name;
  final String? place;
  final String? region;
  final String? introduction;
  final CampsiteCategory? campsiteCategory;
  final int? numberOfPoweredSites;
  final int? numberOfUnpoweredSites;
  final bool? bookable;
  final bool? free;
  final List<Facility>? facilities;
  final List<Activity>? activities;
  final String? dogsAllowed;
  final List<Landscape>? landscapes;
  final List<Access>? access;
  final String? hasAlerts;
  final String? introductionThumbnail;
  final String? staticLink;
  final String? locationString;
  final double? x;
  final double? y;
  final int assetId;
  final String? dateLoadedToGis;
  final String? globalId;

  Campsite({
    required this.point,
    required this.id,
    required this.name,
    this.place,
    this.region,
    this.introduction,
    this.campsiteCategory,
    this.numberOfPoweredSites,
    this.numberOfUnpoweredSites,
    this.bookable,
    this.free,
    this.facilities,
    this.activities,
    this.dogsAllowed,
    this.landscapes,
    this.access,
    this.hasAlerts,
    this.introductionThumbnail,
    this.staticLink,
    this.locationString,
    this.x,
    this.y,
    required this.assetId,
    this.dateLoadedToGis,
    this.globalId,
  });

  factory Campsite.fromCampsiteApi(CampsiteFeature campsiteFeature) {
    final props = campsiteFeature.properties;

    return Campsite(
      point: Point(
        x: campsiteFeature.geometry.longitude,
        y: campsiteFeature.geometry.latitude,
      ),
      id: props.objectId,
      name: props.name,
      place: props.place,
      region: props.region,
      introduction: props.introduction,
      campsiteCategory: props.campsiteCategory != null
          ? CampsiteCategory.values.firstWhere(
              (e) => e.displayName == props.campsiteCategory,
              orElse: () => CampsiteCategory.standard,
            )
          : null,
      numberOfPoweredSites: props.numberOfPoweredSites,
      numberOfUnpoweredSites: props.numberOfUnpoweredSites,
      bookable: props.bookable?.toLowerCase() == 'yes',
      free: props.free,
      facilities: props.facilities != null
          ? _parseFacilities(props.facilities!)
          : null,
      activities: props.activities != null
          ? _parseActivities(props.activities!)
          : null,
      dogsAllowed: props.dogsAllowed,
      landscapes: props.landscape != null
          ? _parseLandscapes(props.landscape!)
          : null,
      access: props.access != null ? _parseAccessList(props.access!) : null,
      hasAlerts: props.hasAlerts,
      introductionThumbnail: props.introductionThumbnail,
      staticLink: props.staticLink,
      locationString: props.locationString,
      x: props.x,
      y: props.y,
      assetId: props.assetId,
      dateLoadedToGis: props.dateLoadedToGis,
      globalId: props.globalId,
    );
  }
}
