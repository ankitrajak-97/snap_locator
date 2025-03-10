import 'package:json_annotation/json_annotation.dart';

part 'geo_tagged_item.g.dart';

@JsonSerializable()
class GeoTaggedItem {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "desc")
  final String description;

  @JsonKey(name: "img")
  final String? imagePath;

  @JsonKey(name: "lat")
  final double latitude;

  @JsonKey(name: "lng")
  final double longitude;

  GeoTaggedItem({
    required this.name,
    required this.description,
    this.imagePath,
    required this.latitude,
    required this.longitude,
  });

  GeoTaggedItem copyWith({
    String? name,
    String? description,
    String? imagePath,
    double? latitude,
    double? longitude,
  }) {
    return GeoTaggedItem(
      name: name ?? this.name,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Convert from JSON
  factory GeoTaggedItem.fromJson(Map<String, dynamic> json) =>
      _$GeoTaggedItemFromJson(json);

  // Convert to JSON
  Map<String, dynamic> toJson() => _$GeoTaggedItemToJson(this);
}
