import 'package:go_router/go_router.dart';
import 'package:nzdoc_maps_mobile/routing/routes.dart';
import 'package:nzdoc_maps_mobile/ui/map/view_models/map_view_model.dart';
import 'package:nzdoc_maps_mobile/ui/map/widgets/map_screen.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = MapViewModel(locationRepository: context.read());
        return MapScreen(viewModel: viewModel);
      },
    ),
  ],
);
