// lib/view/components/toggle_selection_buttons.dart

import 'package:flutter/material.dart';

class ToggleSelectionButtons extends StatelessWidget {
  final List<bool> isSelected;
  final Function(int) onPressed;

  const ToggleSelectionButtons({
    Key? key,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(10),
        selectedColor: Colors.white,
        fillColor: Colors.blue,
        color: Colors.black,
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 150.0, // Largura de cada botão
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.bolt_outlined, color: Colors.grey), // Ícone de raio
              SizedBox(width: 8),
              Text("Sensor de Energia    "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.warning_amber_outlined, color: Colors.grey), // Ícone de alerta
              SizedBox(width: 8),
              Text("Crítico"),
            ],
          ),
        ],
      ),
    );
  }
}
