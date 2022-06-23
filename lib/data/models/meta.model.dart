import 'package:json_annotation/json_annotation.dart';
part 'meta.model.g.dart';

@JsonSerializable()
class Meta {
  final int? totalItems;
  final int? itemCount;
  final int? itemsPerPage;
  final int? totalPages;
  final int currentPage;

  Meta({
    this.totalItems,
    this.itemCount,
    this.itemsPerPage,
    this.currentPage = 1,
    this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => <String, String>{
        'totalItems': this.totalItems.toString(),
        'itemCount': this.itemCount.toString(),
        'itemsPerPage': this.itemsPerPage.toString(),
        'totalPages': this.totalPages.toString(),
        'currentPage': this.currentPage.toString(),
      };

  bool get hasNext {
    if (this.totalPages != null) {
      return this.totalPages! > this.currentPage;
    }
    return false;
  }

  bool get hasPrevious => this.currentPage > 1;

  @override
  String toString() {
    return 'Meta(totalItems: $totalItems, itemCount: $itemCount, itemsPerPage: $itemsPerPage, totalPages: $totalPages, currentPage: $currentPage)';
  }
}
