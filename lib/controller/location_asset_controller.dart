import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tractian/model/asset_model.dart';
import 'package:tractian/service/location_asset_service.dart';

import '../model/location_model.dart';

class LocationAssetController extends ChangeNotifier{

  final List<dynamic> roots = [];

  buildTree(idCompany) async {
    await getLocations(idCompany);
    await getAssets(idCompany);

    Map<String, dynamic> nodeMap = {};

    for (var item in [...assets, ...locations]) {
      if (item is AssetModel) {
        nodeMap[item.id] = item;
      } else if (item is LocationModel) {
        nodeMap[item.id] = item;
      }
    }

    for (var node in nodeMap.values) {
      if (node.parentId != null && nodeMap.containsKey(node.parentId!)) {
        nodeMap[node.parentId!]!.children.add(node);
      } else {
        roots.add(node);
      }
    }

    notifyListeners();
  }

  final List<LocationModel> _locations = [];
  List<LocationModel> get locations => _locations;

  getLocations(idCompany) async {
    locations.clear();
    locations.addAll(await LocationAssetService.getLocations(idCompany) ?? []);
    log('Locations: ${locations.length}');
    notifyListeners();
  }

  final List<AssetModel> _assets = [];
  List<AssetModel> get assets => _assets;

  final List<AssetModel> _components = [];
  List<AssetModel> get components => _components;

  getAssets(idCompany) async {
    assets.clear();
    components.clear();

    List assetsGenereric = await LocationAssetService.getAssets(idCompany) ?? [];
    
    for (var asset in assetsGenereric) {
      (asset.sensorType != null ? components : assets).add(asset);
    }

    notifyListeners();
  }
}