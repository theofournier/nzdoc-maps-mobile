import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/map_view_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.viewModel});

  final MapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) => GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-41.2865, 174.7762), // Wellington, NZ
                zoom: 6,
              ),
              markers: viewModel.markers.values.map((e) => e.marker).toSet(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.filter_list),
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            enabled: false,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                final val = viewModel.isFilterActive(FilterType.campsites);
                                return CheckboxListTile(
                                  title: const Text('Campsite'),
                                  value: val,
                                  onChanged: (v) {
                                    viewModel.setFilterActive(FilterType.campsites, v ?? false);
                                    setState(() {});
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                );
                              },
                            ),
                          ),
                          PopupMenuItem<int>(
                            enabled: false,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                final val = viewModel.isFilterActive(FilterType.walkings);
                                return CheckboxListTile(
                                  title: const Text('Walking'),
                                  value: val,
                                  onChanged: (v) {
                                    viewModel.setFilterActive(FilterType.walkings, v ?? false);
                                    setState(() {});
                                  },
                                  controlAffinity: ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
