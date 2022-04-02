import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
part 'order_package.model.g.dart';

@JsonSerializable()
class OrderPackage {
  OrderPackage({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.currency,
    required this.height,
    required this.width,
    required this.length,
    required this.dimensionUnit,
    required this.weight,
    required this.weightUnit,
    required this.isDangerousGood,
    required this.type,
    required this.otherNotes,
    this.orderId,
  });

  final String name;
  final String description;
  final int quantity;
  final int price;
  final String currency;
  final int height;
  final int width;
  final int length;
  final DimensionUnitConversion dimensionUnit;
  final int weight;
  final WeightUnitConversion weightUnit;
  final bool isDangerousGood;
  final TypeOfPackage type;
  final String? orderId;
  final String otherNotes;

  factory OrderPackage.fromJson(Map<String, dynamic> json) =>
      _$OrderPackageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPackageToJson(this);
}
