import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/map_view_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.viewModel});

  final MapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) => GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(-41.2865, 174.7762), // Wellington, NZ
            zoom: 6,
          ),
          markers: viewModel.markers.values.map((e) => e.marker).toSet(),
        ),
      ),
    );
  }
}
