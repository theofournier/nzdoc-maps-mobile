import 'package:nzdoc_maps_mobile/data/model/campsite_api_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';

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

Facility? _parseFacility(String facility) {
  switch (facility) {
    case 'Toilets':
      return Facility.toilets;
    case 'Toilets - flush':
      return Facility.toiletsFlush;
    case 'Toilets - non-flush':
      return Facility.toiletsNonFlush;
    case 'Non-powered/tent sites':
      return Facility.nonPoweredTentSites;
    case 'Powered sites':
      return Facility.poweredSites;
    case 'Shelter for cooking':
      return Facility.shelterForCooking;
    case 'Water from tap - not treated, boil before use':
      return Facility.waterFromTap;
    case 'Water from tap - treated, suitable for drinking':
      return Facility.waterFromTapTreated;
    case 'Water from stream':
      return Facility.waterFromStream;
    case 'Water supply':
      return Facility.waterSupply;
    case 'Shower - cold':
      return Facility.showerCold;
    case 'Shower - hot':
      return Facility.showerHot;
    case 'Boat launching':
      return Facility.boatLaunching;
    case 'Jetty':
      return Facility.jetty;
    case 'BBQ':
      return Facility.bbq;
    case 'Fire pit/place for campfires (except in fire bans)':
      return Facility.firePit;
    case 'Cookers/electric stove':
      return Facility.cookersElectricStove;
    case 'Phone':
      return Facility.phone;
    case 'Wheelchair accessible':
      return Facility.wheelchairAccessible;
    case 'Wheelchair accessible with assistance':
      return Facility.wheelchairAccessibleWithAssistance;
    default:
      print("Unknown facility: $facility");
      return null;
  }
}

Activity? _parseActivity(String activity) {
  switch (activity) {
    case 'Bird and wildlife watching':
      return Activity.birdAndWildlifeWatching;
    case 'Boating':
      return Activity.boating;
    case 'Camping':
      return Activity.camping;
    case 'Caving':
      return Activity.caving;
    case 'Diving and snorkelling':
      return Activity.divingAndSnorkelling;
    case 'Fishing':
      return Activity.fishing;
    case 'Four wheel driving':
      return Activity.fourWheelDriving;
    case 'Hunting':
      return Activity.hunting;
    case 'Kayaking and canoeing':
      return Activity.kayakingAndCanoeing;
    case 'Mountain biking':
      return Activity.mountainBiking;
    case 'Picnicking':
      return Activity.picnicking;
    case 'Rafting':
      return Activity.rafting;
    case 'Skiing and ski touring':
      return Activity.skiingAndSkiTouring;
    case 'Swimming':
      return Activity.swimming;
    case 'Walking and tramping':
      return Activity.walkingAndTramping;
    default:
      print("Unknown activity: $activity");
      return null;
  }
}

Landscape? _parseLandscape(String landscape) {
  switch (landscape) {
    case 'Alpine':
      return Landscape.alpine;
    case 'Coastal':
      return Landscape.coastal;
    case 'Forest':
      return Landscape.forest;
    case 'Rivers and lakes':
      return Landscape.riversAndLakes;
    default:
      print("Unknown landscape: $landscape");
      return null;
  }
}

Access? _parseAccess(String access) {
  switch (access) {
    case '4WD':
      return Access.fourWd;
    case 'Boat':
      return Access.boat;
    case 'Campervan':
      return Access.campervan;
    case 'Car':
      return Access.car;
    case 'Caravan':
      return Access.caravan;
    case 'Foot':
      return Access.foot;
    case 'Mountain bike':
      return Access.mountainBike;
    default:
      print("Unknown access: $access");
      return null;
  }
}

class Campsite {
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
      facilities: props.facilities
          ?.split(', ')
          .map((f) => _parseFacility(f.trim()))
          .where((f) => f != null)
          .cast<Facility>()
          .toList(),
      activities: props.activities
          ?.split(', ')
          .map((a) => _parseActivity(a.trim()))
          .where((a) => a != null)
          .cast<Activity>()
          .toList(),
      dogsAllowed: props.dogsAllowed,
      landscapes: props.landscape
          ?.split(', ')
          .map((a) => _parseLandscape(a.trim()))
          .where((a) => a != null)
          .cast<Landscape>()
          .toList(),
      access: props.access
          ?.split(', ')
          .map((a) => _parseAccess(a.trim()))
          .where((a) => a != null)
          .cast<Access>()
          .toList(),
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
