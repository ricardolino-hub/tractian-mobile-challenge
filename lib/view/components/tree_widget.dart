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
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  : widget.node.sensorType != null
                      ? Icons.sensors_outlined
                      : CupertinoIcons.cube,
              color: const Color.fromARGB(255, 33, 136, 255),
            ),
            const SizedBox(width: 4.0),
            Text(
              widget.node.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4.0),
            if (widget.node is AssetModel &&
                widget.node.sensorType != null &&
                widget.node.status == "alert")
              Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
              ),
            if (widget.node is AssetModel &&
                widget.node.sensorType != null &&
                widget.node.sensorType == "energy")
              const Icon(
                Icons.flash_on,
                color: Colors.green,
                size: 16,
              ),
          ],
        ),
        if (isExpanded && widget.node.childrenTree.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.node.childrenTree.length,
              itemBuilder: (context, index) {
                return TreeNodeWidget(
                  node: widget.node.childrenTree[index],
                );
              },
            ),
          ),
      ],
    );
  }
}

