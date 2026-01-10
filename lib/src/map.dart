import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nzdoc_maps_mobile/src/locations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final Future<Map<String, dynamic>> _dataFuture;

  late AlignOnUpdate _alignPositionOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();

    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _alignPositionStreamController.close();
    super.dispose();
  }

  Future<Map<String, dynamic>> _loadData() async {
    final campsites = await loadCampsitesFromAssets();
    final walkings = await loadWalkingExperiencesFromAssets();
    final walkingRoutes = await loadWalkingRoutesFromAssets();
    return {
      'campsites': campsites,
      'walkings': walkings,
      'walkingRoutes': walkingRoutes,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final campsites =
            snapshot.data!['campsites'] as CampsiteFeatureCollection;
        final walkings =
            snapshot.data!['walkings'] as WalkingExperienceFeatureCollection;
        final walkingRoutes =
            snapshot.data!['walkingRoutes'] as WalkingRouteFeatureCollection;

        final List<Marker> markers = [];
        final List<Polyline> polylines = [];

        for (final f in campsites.features) {
          final lat = f.geometry.latitude;
          final lon = f.geometry.longitude;
          markers.add(
            Marker(
              width: 30,
              height: 30,
              point: LatLng(lat, lon),
              child: GestureDetector(
                onTap: () =>
                    _showMarkerDetails(context, 'Campsite', f.properties),
                child: Icon(Icons.place, color: Colors.green),
              ),
            ),
          );
        }

        for (final f in []) {
          final coords = f.geometry.coordinates;
          if (coords is List && coords.length >= 2) {
            final lon = (coords[0] as num).toDouble();
            final lat = (coords[1] as num).toDouble();
            markers.add(
              Marker(
                width: 30,
                height: 30,
                point: LatLng(lat, lon),
                child: Icon(Icons.directions_walk, color: Colors.blue),
              ),
            );
          }
        }

        for (final f in walkingRoutes.features) {
          final coords = f.geometry.coordinates;
          final points = <LatLng>[];

          if (coords is List && coords.isNotEmpty) {
            if (coords[0] is List && coords[0][0] is! List) {
              for (final coord in coords) {
                if (coord is List && coord.length >= 2) {
                  final lon = (coord[0] as num).toDouble();
                  final lat = (coord[1] as num).toDouble();
                  points.add(LatLng(lat, lon));
                }
              }
            } else if (coords[0] is List && coords[0][0] is List) {
              for (final lineString in coords) {
                if (lineString is List) {
                  for (final coord in lineString) {
                    if (coord is List && coord.length >= 2) {
                      final lon = (coord[0] as num).toDouble();
                      final lat = (coord[1] as num).toDouble();
                      points.add(LatLng(lat, lon));
                    }
                  }
                }
              }
            }
          }

          if (points.isNotEmpty) {
            polylines.add(
              Polyline(points: points, color: Colors.purple, strokeWidth: 3),
            );
          }
        }

        return FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(-41, 174),
            initialZoom: 5,
            onPositionChanged: (MapCamera camera, bool hasGesture) {
              if (hasGesture && _alignPositionOnUpdate != AlignOnUpdate.never) {
                setState(() => _alignPositionOnUpdate = AlignOnUpdate.never);
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.tfournier.nzdocmapsmobile',
            ),
            CurrentLocationLayer(
              alignPositionStream: _alignPositionStreamController.stream,
              alignPositionOnUpdate: _alignPositionOnUpdate,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(
                      () => _alignPositionOnUpdate = AlignOnUpdate.always,
                    );
                    _alignPositionStreamController.add(15);
                  },
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
              ),
            ),
            //PolylineLayer(polylines: polylines),
            MarkerLayer(markers: markers),
          ],
        );
      },
    );
  }

  void _showMarkerDetails(
    BuildContext context,
    String markerType,
    Map<String, dynamic> properties,
  ) {
    showBarModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      markerType,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                if (properties['name'] != null) ...[
                  Text('Name', style: Theme.of(context).textTheme.labelLarge),
                  Text(properties['name'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['introduction'] != null) ...[
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(properties['introduction'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['place'] != null) ...[
                  Text('Place', style: Theme.of(context).textTheme.labelLarge),
                  Text(properties['place'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['region'] != null) ...[
                  Text('Region', style: Theme.of(context).textTheme.labelLarge),
                  Text(properties['region'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['difficulty'] != null) ...[
                  Text(
                    'Difficulty',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(properties['difficulty'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['completionTime'] != null) ...[
                  Text(
                    'Completion Time',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(properties['completionTime'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['facilities'] != null) ...[
                  Text(
                    'Facilities',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(properties['facilities'] as String),
                  const SizedBox(height: 12),
                ],
                if (properties['activities'] != null) ...[
                  Text(
                    'Activities',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(properties['activities'] as String),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
