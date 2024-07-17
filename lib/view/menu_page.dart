
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
      body: Center(
        child: ListView.builder(
          itemCount: menuController.companies.length,
          itemBuilder: (context, index) {
            return Text(menuController.companies[index].name);
          },
        ),
      ),
    );
  }
}