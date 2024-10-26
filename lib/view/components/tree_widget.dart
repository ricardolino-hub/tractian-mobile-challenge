import 'package:flutter/material.dart';

class TreeNodeWidget extends StatelessWidget {
  final dynamic node;

  TreeNodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exibe o nome do nó
          Text(node.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          
          // Exibe os filhos recursivamente
          ...node.children.map((child) => TreeNodeWidget(node: child)).toList(),
        ],
      ),
    );
  }
}
