import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tractian/model/asset_model.dart';
import 'package:tractian/service/location_asset_service.dart';

import '../model/location_model.dart';

class LocationAssetController extends ChangeNotifier{

  final TextEditingController controllerCustomTextField = TextEditingController();

  final List<dynamic> roots = [];
  final List<dynamic> filteredRoots = [];

  buildTree(String idCompany) async {
    await getLocations(idCompany);
    await getAssets(idCompany);

    Map<String, dynamic> nodeMap = {};

    for (var component in components) {
      nodeMap[component.id] = component;
    }

    for (var asset in assets) {
      nodeMap[asset.id] = asset;
    }

    for (var location in locations) {
      nodeMap[location.id] = location;
    }

    for (var node in nodeMap.values) {
      if (node.parentId != null) {
        nodeMap[node.parentId!]!.childrenTree.add(node);
        nodeMap[node.parentId!]!.children.add(node);
      } else {
        roots.add(node);
      }
    }

    filteredRoots.addAll(roots);
    notifyListeners();
  }

  void applyFilters() {
    filteredRoots.clear();
    filteredRoots.addAll(roots);
    if (isSelected[0] || isSelected[1] || controllerCustomTextField.text.isNotEmpty) {
      filteredRoots.clear();
      for (var root in roots) {
        var filteredNode = filterNode(root);
        if (filteredNode != null) {
          filteredRoots.add(filteredNode);
        }
      }
    }

    notifyListeners();
  }

  dynamic filterNode(dynamic node) {
    if (matchesFilters(node)) {
      return node;
    }

    var filteredChildren = <dynamic>[];
    for (var child in node.children) {
      var filteredChild = filterNode(child);
      if (filteredChild != null) {
        filteredChildren.add(filteredChild);
      }
    }

    if (filteredChildren.isNotEmpty) {
      return node..childrenTree.clear()..childrenTree.addAll(filteredChildren);
    }

    return null;
  }

  bool matchesFilters(dynamic node) {
    bool matchesTextFilter = controllerCustomTextField.text.isEmpty ? false : node.name.toLowerCase().contains(controllerCustomTextField.text.toLowerCase());
    bool matchesSensorFilter = isSelected[0] && (node is AssetModel && node.sensorType == 'energy');
    bool matchesAlertFilter = isSelected[1] && (node is AssetModel && node.status == 'alert');

    if ((isSelected[0] || isSelected[1]) && controllerCustomTextField.text.isNotEmpty) {
      return matchesTextFilter && (matchesSensorFilter || matchesAlertFilter);
    } else if ((isSelected[0] || isSelected[1]) && controllerCustomTextField.text.isEmpty) {
      return matchesSensorFilter || matchesAlertFilter;
    }else {
      return matchesTextFilter;
    }
  }

  // Update filters and apply them
  void updateFilterText(String text) {
    applyFilters();
  }

  final List<LocationModel> _locations = [];
  List<LocationModel> get locations => _locations;

  getLocations(idCompany) async {
    locations.clear();
    locations.addAll(await LocationAssetService.getLocations(idCompany) ?? []);
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
  }

  final List<bool> _isSelected = [false, false];
  List<bool> get isSelected => _isSelected;

  toggleSelection(int index) {
    isSelected[index] = !isSelected[index];
    if (index == 0) {
      isSelected[1] = false;
    } else {
      isSelected[0] = false;
    }

    applyFilters();
  }
}