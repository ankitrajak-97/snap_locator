import 'package:json_annotation/json_annotation.dart';

import '../geo_tagged_items/geo_tagged_item.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "geoItems")
  final List<GeoTaggedItem> geoTaggedItems;

  BaseResponse({required this.geoTaggedItems});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
