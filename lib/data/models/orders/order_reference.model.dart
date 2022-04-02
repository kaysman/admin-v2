import 'package:json_annotation/json_annotation.dart';
part 'order_reference.model.g.dart';

@JsonSerializable()
class OrderReference {
  OrderReference({
    this.merchantOrderNumber,
    this.others,
  });

  final String? merchantOrderNumber;
  final String? others;

  factory OrderReference.fromJson(Map<String, dynamic> json) =>
      _$OrderReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$OrderReferenceToJson(this);
}
