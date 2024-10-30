import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian/model/location_model.dart';

import '../../model/asset_model.dart';

class TreeNodeWidget extends StatefulWidget {
  final dynamic node;

  const TreeNodeWidget({super.key, required this.node});

  @override
  TreeNodeWidgetState createState() => TreeNodeWidgetState();
}

class TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isExpanded ? Icons.expand_more : Icons.chevron_right,
                ),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),

              const SizedBox(width: 4.0),

              Icon(
                widget.node is LocationModel 
                  ? Icons.location_on_outlined 
                  : widget.node.sensorType != null ? Icons.sensors_outlined : CupertinoIcons.cube,
                color: const Color.fromARGB(255, 33, 136, 255),
              ),

              const SizedBox(width: 4.0),
              
              Text(
                widget.node.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(width: 4.0),

              widget.node is AssetModel && widget.node.sensorType != null && widget.node.status == "alert" 
                ? Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                )
                : Container(),
                   
              
              widget.node is AssetModel && widget.node.sensorType != null && widget.node.sensorType == "energy"
                ? const Icon(
                      Icons.flash_on,
                      color: Colors.green,
                      size: 16,
                    )
                : Container()


              
            ],
          ),

          // Mostrar os filhos apenas se `isExpanded` for verdadeiro
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.node.children
                    .map<Widget>((child) => TreeNodeWidget(node: child))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
