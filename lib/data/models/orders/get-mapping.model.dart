import 'package:json_annotation/json_annotation.dart';
part 'get-mapping.model.g.dart';

@JsonSerializable()
class GetMapping {
  GetMapping({
    this.excelBase64String,
  });

  String? excelBase64String;
  factory GetMapping.fromJson(Map<String, dynamic> json) =>
      _$GetMappingFromJson(json);

  Map<String, dynamic> toJson() => _$GetMappingToJson(this);
}
