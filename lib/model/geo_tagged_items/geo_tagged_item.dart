import 'package:json_annotation/json_annotation.dart';

part 'geo_tagged_item.g.dart';

@JsonSerializable()
class GeoTaggedItem {
  final String name;
  final String description;
  final String? imagePath;
  final double latitude;
  final double longitude;

  GeoTaggedItem({
    required this.name,
    required this.description,
    this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  // Convert from JSON
  factory GeoTaggedItem.fromJson(Map<String, dynamic> json) =>
      _$GeoTaggedItemFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$GeoTaggedItemToJson(this);
}
