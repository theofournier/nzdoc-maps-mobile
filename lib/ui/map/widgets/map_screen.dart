import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/map_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.viewModel});

  final MapViewModel viewModel;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isSheetOpen = false;

  MapViewModel get viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.loadLocations.running) {
            return const Center(child: CircularProgressIndicator());
          }
          final markers = viewModel.markers.values.map((e) => e.marker).toSet();
          final selected = viewModel.selectedData;
          final selectedId = viewModel.selectedMarkerId;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (selected != null && !_isSheetOpen) {
              _isSheetOpen = true;
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  String type = 'Item';
                  if (selectedId != null) {
                    final v = selectedId.value;
                    if (v.startsWith('campsite_'))
                      type = 'Campsite';
                    else if (v.startsWith('walking_'))
                      type = 'Walking';
                  }

                  String name;
                  try {
                    name =
                        (selected as dynamic).name?.toString() ??
                        selected.toString();
                  } catch (_) {
                    name = selected.toString();
                  }

                  // Extract links depending on selected type
                  String? staticLink;
                  String? walkingLink;
                  try {
                    staticLink = (selected as dynamic).staticLink as String?;
                  } catch (_) {
                    staticLink = null;
                  }
                  try {
                    walkingLink =
                        (selected as dynamic).walkingAndTrampingWebPage
                            as String?;
                  } catch (_) {
                    walkingLink = null;
                  }

                  Widget linkTile(String label, String url) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: InkWell(
                        onTap: () async {
                          if (url.isEmpty) return;
                          try {
                            await launchUrlString(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            print('Could not launch $url: $e');
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.link,
                              size: 18,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                label,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (staticLink != null && staticLink.isNotEmpty)
                          linkTile('Official page', staticLink),
                        if (walkingLink != null && walkingLink.isNotEmpty)
                          linkTile('Walking page', walkingLink),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              ).whenComplete(() {
                _isSheetOpen = false;
                viewModel.clearSelection();
              });
            }
          });

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-41.2865, 174.7762), // Wellington, NZ
                  zoom: 6,
                ),
                markers: markers,
                polylines: viewModel.polylines,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                                    final val = viewModel.isFilterActive(
                                      FilterType.campsites,
                                    );
                                    return CheckboxListTile(
                                      title: const Text('Campsite'),
                                      value: val,
                                      onChanged: (v) {
                                        viewModel.setFilterActive(
                                          FilterType.campsites,
                                          v ?? false,
                                        );
                                        setState(() {});
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                    );
                                  },
                                ),
                              ),
                              PopupMenuItem<int>(
                                enabled: false,
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    final val = viewModel.isFilterActive(
                                      FilterType.walkings,
                                    );
                                    return CheckboxListTile(
                                      title: const Text('Walking'),
                                      value: val,
                                      onChanged: (v) {
                                        viewModel.setFilterActive(
                                          FilterType.walkings,
                                          v ?? false,
                                        );
                                        setState(() {});
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
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
          );
        },
      ),
    );
  }
}
