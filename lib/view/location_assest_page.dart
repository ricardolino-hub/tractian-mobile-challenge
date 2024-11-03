import 'package:flutter/material.dart';
import 'package:tractian/controller/location_asset_controller.dart';
import 'package:tractian/view/components/custom_text_field.dart';
import 'package:tractian/view/components/toggle_selection_buttons.dart';
import 'package:tractian/view/components/tree_widget.dart';

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
    locationAssetController.addListener(() {
      setState(() {});
    });
    locationAssetController.buildTree(widget.idCompany);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 25, 45),
        title: const Center(child: Text('Assets')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          CustomTextField(
            onTextChanged: locationAssetController.updateFilterText,
            controller: locationAssetController.controllerCustomTextField,
          ),
          ToggleSelectionButtons(
            isSelected: locationAssetController.isSelected,
            onPressed: locationAssetController.toggleSelection,
          ),
          const Divider(),
          Expanded(
            child: locationAssetController.filteredRoots.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: locationAssetController.filteredRoots.length,
                    itemBuilder: (context, index) {
                      return TreeNodeWidget(
                        node: locationAssetController.filteredRoots[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
