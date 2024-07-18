import 'package:flutter/material.dart';
import 'package:tractian/controller/location_asset_controller.dart';

class LocationAssestPage extends StatefulWidget {
  const LocationAssestPage({super.key, required this.idCompany});
  final String idCompany;

  @override
  State<LocationAssestPage> createState() => _LocationAssestPageState();
}

class _LocationAssestPageState extends State<LocationAssestPage> {
  LocationAssetController locationAssetController = LocationAssetController();


  @override
  void initState() {
    super.initState();
    locationAssetController.addListener(() {setState(() {});});
    locationAssetController.getLocations(widget.idCompany);
    locationAssetController.getAssets(widget.idCompany);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Assets')),
      ),
      body: const Center(
        child: Text('Location - Asset'),
      ),
    );
  }
}