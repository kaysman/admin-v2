// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file-upload.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUpload _$FileUploadFromJson(Map<String, dynamic> json) => FileUpload(
      uploadType: json['uploadType'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FileUploadToJson(FileUpload instance) =>
    <String, dynamic>{
      'uploadType': instance.uploadType,
      'name': instance.name,
    };
