
import 'package:json_annotation/json_annotation.dart';
part 'file-upload.model.g.dart';

@JsonSerializable()
class FileUpload {
  FileUpload({
    this.uploadType,
    this.name,
  });

  String? uploadType;
  String? name;

  factory FileUpload.fromJson(Map<String, dynamic> json) =>
      _$FileUploadFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadToJson(this);
}
