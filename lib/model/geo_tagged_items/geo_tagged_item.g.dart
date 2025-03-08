// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_tagged_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoTaggedItem _$GeoTaggedItemFromJson(Map<String, dynamic> json) =>
    GeoTaggedItem(
      name: json['name'] as String,
      description: json['desc'] as String,
      imagePath: json['img'] as String?,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoTaggedItemToJson(GeoTaggedItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.description,
      'img': instance.imagePath,
      'lat': instance.latitude,
      'lng': instance.longitude,
    };
