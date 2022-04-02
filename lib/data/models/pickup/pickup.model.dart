import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/models/merchant.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';

part 'pickup.model.g.dart';

@JsonSerializable()
class PickupList {
  late final List<Pickup>? items;
  final Meta? meta;

  PickupList({this.items, this.meta});

  factory PickupList.fromJson(Map<String, dynamic> json) =>
      _$PickupListFromJson(json);

  Map<String, dynamic> toJson() => _$PickupListToJson(this);

  @override
  String toString() => 'PickupList(items: $items, meta: $meta)';
}

@JsonSerializable()
class Pickup {
  final String? id;
  final String? type;
  final String? status;
  final int? numberOfItems;
  final double? weight;
  final Merchant? merchant;
  final DateTime? pickupTimeWindowStart;
  final DateTime? pickupTimeWindowEnd;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pickup({
    this.id,
    this.type,
    this.merchant,
    this.status,
    this.numberOfItems,
    this.weight,
    this.pickupTimeWindowStart,
    this.pickupTimeWindowEnd,
    this.createdAt,
    this.updatedAt,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) => _$PickupFromJson(json);

  Map<String, dynamic> toJson() => _$PickupToJson(this);

  @override
  String toString() {
    return 'Pickup(id: $id, type: $type, status: $status)';
  }
}
