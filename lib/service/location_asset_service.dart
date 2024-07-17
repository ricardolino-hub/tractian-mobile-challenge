import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tractian/env/app_env.dart';
import 'package:tractian/model/location_model.dart';

class LocationAssetService {
  static Future<List<LocationModel>>? getLocations(String idCompany) async {
    try{
      final response = await http.get(Uri.parse('${AppEnv.company}/$idCompany/${AppEnv.location}'));
      return jsonDecode(response.body).map<LocationModel>((json) => LocationModel.fromJson(json)).toList();
    }catch(e) {
      log(e.toString());
      return [];
    }
  }
}