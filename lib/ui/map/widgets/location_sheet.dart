import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:nzdoc_maps_mobile/domain/models/campsite_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/location_model.dart';
import 'package:nzdoc_maps_mobile/domain/models/walking_model.dart';

class LinkTile extends StatelessWidget {
  const LinkTile({super.key, required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () async {
          if (url.isEmpty) return;
          try {
            await launchUrlString(url, mode: LaunchMode.externalApplication);
          } catch (e) {
            print('Could not launch $url: $e');
          }
        },
        child: Row(
          children: [
            const Icon(Icons.link, size: 18, color: Colors.blue),
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
}

class CampsiteDetail extends StatelessWidget {
  const CampsiteDetail({super.key, required this.campsite});

  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(campsite.name),
        if (campsite.staticLink != null)
          LinkTile(label: "Official Page", url: campsite.staticLink!),
        if (campsite.introduction != null) Text(campsite.introduction!),
        if (campsite.access != null)
          Text(campsite.access!.map((a) => a.displayName).join(", ")),
        if (campsite.campsiteCategory != null)
          Text(campsite.campsiteCategory!.displayName),
        if (campsite.facilities != null)
          Text(campsite.facilities!.map((f) => f.displayName).join(", ")),
        if (campsite.activities != null)
          Text(campsite.activities!.map((a) => a.displayName).join(", ")),
        if (campsite.landscapes != null)
          Text(campsite.landscapes!.map((l) => l.displayName).join(", ")),
      ],
    );
  }
}

class WalkingDetail extends StatelessWidget {
  const WalkingDetail({super.key, required this.walking});

  final Walking walking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(walking.name),
        if (walking.walkingAndTrampingWebPage != null)
          LinkTile(
            label: "Walking Page",
            url: walking.walkingAndTrampingWebPage!,
          ),
        if (walking.introduction != null) Text(walking.introduction!),
        if (walking.difficulties != null)
          Text(walking.difficulties!.map((d) => d.displayName).join(", ")),
        if (walking.completionTime != null) Text(walking.completionTime!),
      ],
    );
  }
}

class LocationSheet extends StatelessWidget {
  const LocationSheet({super.key, required this.data, required this.onClose});

  final Location data;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    final body = data is Campsite
        ? CampsiteDetail(campsite: data as Campsite)
        : WalkingDetail(walking: data as Walking);

    return SafeArea(
      bottom: false,
      child: DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 1,
        snapSizes: [0.3, 1],
        snap: true,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            await launchUrl(
                              Uri(
                                scheme: "geo",
                                path:
                                    "${data.point.y},${data.point.x}?q=lat,lng(${data.name})",
                              ),
                            );
                          } catch (e) {
                            print("Could not launch map $e");
                          }
                        },
                        icon: const Icon(Icons.map),
                      ),
                      CloseButton(onPressed: onClose),
                    ],
                  ),
                  body,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
