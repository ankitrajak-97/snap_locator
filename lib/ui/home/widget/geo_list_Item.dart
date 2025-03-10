import 'dart:io';

import 'package:flutter/material.dart';

import '../../../model/geo_tagged_items/geo_tagged_item.dart';

class GeoListItem extends StatelessWidget {
  const GeoListItem({
    super.key,
    required this.onLeadingClick,
    required this.item,
    required this.onLocationIconTap,
    required this.onDeleteIconTap,
    required this.onEditIconTap,
  });

  final GeoTaggedItem item;
  final VoidCallback onLeadingClick;
  final VoidCallback onLocationIconTap;
  final VoidCallback onEditIconTap;
  final VoidCallback onDeleteIconTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: onLeadingClick,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(item.imagePath ?? ""),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image, size: 50, color: Colors.grey);
              },
            ),
          ),
        ),

        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.location_on, color: Colors.red), onPressed: onLocationIconTap),
            IconButton(icon: Icon(Icons.edit, color: Colors.red), onPressed: onEditIconTap),
            IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: onDeleteIconTap),
          ],
        ),
      ),
    );
  }
}
