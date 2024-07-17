import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tractian/model/company_model.dart';
import 'package:tractian/service/company_service.dart';

class MenuController extends ChangeNotifier{
  MenuController (){
    getComponies();
  }
  
  final List<CompanyModel> _companies = [];
  List<CompanyModel> get companies => _companies;

  getComponies() async {
    companies.clear();
    companies.addAll(await CompanyService.getCompanies() ?? []);
    log('companies: ${companies.length}');
    notifyListeners();
  }
}