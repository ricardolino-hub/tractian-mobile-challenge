import 'package:flutter/material.dart';
import 'package:tractian/controller/menu_controller.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  MenuController menuController = MenuController();

  @override
  void initState() {
    super.initState();
    menuController.addListener(() {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 25, 45),
        title: const Center(child: Text(
          'Tractian',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
          )),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: menuController.companies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () => menuController.locationAssetPage(context, menuController.companies[index].id), 
                icon: const Icon(Icons.lan_outlined), 
                label: Text(
                  '${menuController.companies[index].name} Unit',
                  style: const TextStyle(
                    fontSize: 15,
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 33, 136, 255),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  minimumSize: const Size(0, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.3),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}