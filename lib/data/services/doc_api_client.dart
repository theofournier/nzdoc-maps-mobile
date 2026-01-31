import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nzdoc_maps_mobile/config/assets.dart';
import 'package:nzdoc_maps_mobile/data/model/campsite_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_api_model.dart';
import 'package:nzdoc_maps_mobile/data/model/walking_route_api_model.dart';
import 'package:nzdoc_maps_mobile/utils/result.dart';

class DocApiClient {
  Future<Result<CampsiteFeatureCollection>> getCampsitesFromAssets() async {
    try {
      final json = await _loadStringAsset(Assets.campsites);
      final campsiteJson = CampsiteFeatureCollection.fromJson(json);
      return Result.ok(campsiteJson);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<WalkingFeatureCollection>> getWalkingFromAssets() async {
    try {
      final json = await _loadStringAsset(Assets.walkings);
      final walkingJson = WalkingFeatureCollection.fromJson(json);
      return Result.ok(walkingJson);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<WalkingRouteFeatureCollection>>
  getWalkingRoutesFromAssets() async {
    try {
      final json = await _loadStringAsset(Assets.walkingRoutes);
      final walkingRouteJson = WalkingRouteFeatureCollection.fromJson(json);
      return Result.ok(walkingRouteJson);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Map<String, dynamic>> _loadStringAsset(String asset) async {
    final localData = await rootBundle.loadString(asset);
    return json.decode(localData) as Map<String, dynamic>;
  }
}
