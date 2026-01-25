import 'package:nzdoc_maps_mobile/data/repositories/location_repository.dart';
import 'package:nzdoc_maps_mobile/data/services/doc_api_client.dart';
import 'package:nzdoc_maps_mobile/routing/router.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DocApiClient()),
        Provider(
          create: (context) => LocationRepository(docApiClient: context.read()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NZDoc Maps Mobile',
      routerConfig: router(),
    );
  }
}
