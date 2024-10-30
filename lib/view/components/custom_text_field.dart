import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller = TextEditingController();

  CustomTextField({
    Key? key,
    this.labelText = 'Buscar Ativo ou Local',
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          fillColor: const Color(0xFFF0F0F0),
          filled: true,
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: (value) {
          print("Texto digitado: $value");
        },
      ),
    );
  }
}
