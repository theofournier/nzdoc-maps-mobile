import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nzdoc_maps_mobile/src/locations.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  Future<Map<String, dynamic>> _loadData() async {
    final campsites = await loadCampsitesFromAssets();
    final walkings = await loadWalkingExperiencesFromAssets();
    return {'campsites': campsites, 'walkings': walkings};
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

        final List<Marker> markers = [];

        for (final f in campsites.features) {
          final lat = f.geometry.latitude;
          final lon = f.geometry.longitude;
          markers.add(
            Marker(
              width: 30,
              height: 30,
              point: LatLng(lat, lon),
              child: Icon(Icons.place, color: Colors.green),
            ),
          );
        }

        for (final f in walkings.features) {
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

        return FlutterMap(
          options: MapOptions(initialCenter: LatLng(-41, 174), initialZoom: 5),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.tfournier.nzdocmapsmobile',
            ),
            MarkerLayer(markers: markers),
          ],
        );
      },
    );
  }
}
