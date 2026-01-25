import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nzdoc_maps_mobile/config/assets.dart';
import 'package:nzdoc_maps_mobile/data/model/campsite_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_route_api_model.dart';

class DocApiClient {
  Future<CampsiteFeatureCollection> getCampsitesFromAssets() async {
    final json = await _loadStringAsset(Assets.campsites);
    return CampsiteFeatureCollection.fromJson(json);
  }

  Future<WalkingFeatureCollection> getWalkingFromAssets() async {
    final json = await _loadStringAsset(Assets.walkings);
    return WalkingFeatureCollection.fromJson(json);
  }

  Future<WalkingRouteFeatureCollection> getWalkingRoutesFromAssets() async {
    final json = await _loadStringAsset(Assets.walkingRoutes);
    return WalkingRouteFeatureCollection.fromJson(json);
  }

  Future<Map<String, dynamic>> _loadStringAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return json.decode(localData) as Map<String, dynamic>;
  }
}
