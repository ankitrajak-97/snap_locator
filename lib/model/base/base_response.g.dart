// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
  geoTaggedItems:
      (json['geoItems'] as List<dynamic>)
          .map((e) => GeoTaggedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'geoItems': instance.geoTaggedItems};
