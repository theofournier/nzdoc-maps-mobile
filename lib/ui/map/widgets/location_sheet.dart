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
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () async {
          if (url.isEmpty) return;
          final uri = Uri.tryParse(url);
          if (uri == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid link')),
            );
            return;
          }
          try {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open link')),
            );
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
            const SizedBox(width: 8),
            const Icon(Icons.open_in_new, size: 16, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

Widget _chipsFromNames(List<String>? names) {
  if (names == null || names.isEmpty) return const SizedBox.shrink();
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: names.map((n) => Chip(label: Text(n))).toList(),
  );
}

class CampsiteDetail extends StatelessWidget {
  const CampsiteDetail({super.key, required this.campsite});

  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campsite.name,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (campsite.staticLink != null) LinkTile(label: 'Official page', url: campsite.staticLink!),
          if (campsite.introduction != null) ...[
            const SizedBox(height: 8),
            Text(campsite.introduction!, style: theme.textTheme.bodyMedium),
          ],
          if (campsite.campsiteCategory != null) ...[
            const SizedBox(height: 12),
            Row(children: [const Icon(Icons.category, size: 18), const SizedBox(width: 8), Text(campsite.campsiteCategory!.displayName)]),
          ],
          if (campsite.access != null && campsite.access!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Access', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _chipsFromNames(campsite.access!.map((a) => a.displayName).toList()),
          ],
          if (campsite.facilities != null && campsite.facilities!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Facilities', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _chipsFromNames(campsite.facilities!.map((f) => f.displayName).toList()),
          ],
          if (campsite.activities != null && campsite.activities!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Activities', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _chipsFromNames(campsite.activities!.map((a) => a.displayName).toList()),
          ],
          if (campsite.landscapes != null && campsite.landscapes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Landscapes', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _chipsFromNames(campsite.landscapes!.map((l) => l.displayName).toList()),
          ],
        ],
      ),
    );
  }
}

class WalkingDetail extends StatelessWidget {
  const WalkingDetail({super.key, required this.walking});

  final Walking walking;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            walking.name,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (walking.walkingAndTrampingWebPage != null)
            LinkTile(label: 'Walking page', url: walking.walkingAndTrampingWebPage!),
          if (walking.introduction != null) ...[
            const SizedBox(height: 8),
            Text(walking.introduction!, style: theme.textTheme.bodyMedium),
          ],
          if (walking.difficulties != null && walking.difficulties!.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Difficulty', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            _chipsFromNames(walking.difficulties!.map((d) => d.displayName).toList()),
          ],
          if (walking.completionTime != null) ...[
            const SizedBox(height: 12),
            Row(children: [const Icon(Icons.schedule, size: 18), const SizedBox(width: 8), Text(walking.completionTime!)]),
          ],
        ],
      ),
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
        snapSizes: const [0.3, 1],
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
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(data.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('${data.point.y.toStringAsFixed(5)}, ${data.point.x.toStringAsFixed(5)}', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final lat = data.point.y;
                            final lng = data.point.x;
                            final encodedName = Uri.encodeComponent(data.name);
                            final uriString = 'geo:$lat,$lng?q=$encodedName';
                            try {
                              await launchUrl(Uri.parse(uriString), mode: LaunchMode.externalApplication);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open maps')));
                            }
                          },
                          icon: const Icon(Icons.map),
                        ),
                        CloseButton(onPressed: onClose),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  body,
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
