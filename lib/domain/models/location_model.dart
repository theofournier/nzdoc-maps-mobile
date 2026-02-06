import 'package:nzdoc_maps_mobile/domain/models/geometry_model.dart';

abstract class Location {
  final int id;
  final String name;
  final Point point;

  Location({required this.id, required this.name, required this.point});
}
