import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tractian/service/location_asset_service.dart';

import '../model/location_model.dart';

class LocationAssetController extends ChangeNotifier{

  final List<LocationModel> _locations = [];
  List<LocationModel> get locations => _locations;

  getLocations(idCompany) async {
    locations.clear();
    locations.addAll(await LocationAssetService.getLocations(idCompany) ?? []);
    log('Locations: ${locations.length}');
    notifyListeners();
  }
}