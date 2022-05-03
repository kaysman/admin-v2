import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
part 'order_package.model.g.dart';

@JsonSerializable()
class OrderPackage {
  OrderPackage({
    this.name,
    this.description,
    this.quantity,
    this.price,
    this.currency,
    this.height,
    this.width,
    this.length,
    this.dimensionUnit,
    this.weight,
    this.weightUnit,
    this.isDangerousGood,
    this.type,
    this.otherNotes,
    this.orderId,
  });

  final String? name;
  final String? description;
  final int? quantity;
  final int? price;
  final String? currency;
  final int? height;
  final int? width;
  final int? length;
  final DimensionUnitConversion? dimensionUnit;
  final int? weight;
  final WeightUnitConversion? weightUnit;
  final bool? isDangerousGood;
  final TypeOfPackage? type;
  final String? orderId;
  final String? otherNotes;

  factory OrderPackage.fromJson(Map<String, dynamic> json) =>
      _$OrderPackageFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPackageToJson(this);
}
