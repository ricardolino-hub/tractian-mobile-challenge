import 'dart:convert';
import 'dart:developer';

import 'package:tractian/env/app_env.dart';
import 'package:tractian/model/company_model.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  static Future<List<CompanyModel>>? getCompanies() async {
    try{
      final response = await http.get(Uri.parse(AppEnv.company));
      return jsonDecode(response.body).map<CompanyModel>((json) => CompanyModel.fromJson(json)).toList();
    }catch(e){
      log(e.toString());
      return [];
    }
  }
}