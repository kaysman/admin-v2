import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pagination_options.g.dart';

enum PaginationSortOrder { ASC, DESC }

@JsonSerializable(explicitToJson: true)
class PaginationOptions {
  final PaginationSortOrder sortOrder;
  final String? sortBy;
  final int? page;
  final int? limit;
  final String? filter;
  final String? roleId;
  final String? status;
  final int? skip;

  PaginationOptions({
    this.sortOrder = PaginationSortOrder.DESC,
    this.sortBy,
    this.page = 1,
    this.limit = 10,
    this.filter,
    this.roleId,
    this.status,
    this.skip,
  });

  factory PaginationOptions.fromJson(Map<String, dynamic> json) =>
      _$PaginationOptionsFromJson(json);

  Map<String, String?> toJson() {
    Map<String, String?> json = {
      'sortOrder': _$PaginationSortOrderEnumMap[this.sortOrder],
      'page': "${this.page}",
    };

    if (sortBy != null && sortBy!.isNotEmpty) json['sortBy'] = sortBy;
    if (limit != null) json['limit'] = "${this.limit}";
    if (filter != null && filter!.isNotEmpty) json['filter'] = filter;
    if (roleId != null && roleId!.isNotEmpty) json['roleId'] = roleId;
    if (status != null) json['status'] = this.status;
    if (skip != null) json['skip'] = "${this.skip}";

    return json;
  }
}
