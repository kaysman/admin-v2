// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_package.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPackage _$OrderPackageFromJson(Map<String, dynamic> json) => OrderPackage(
      name: json['name'] as String?,
      description: json['description'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'] as int?,
      currency: json['currency'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      length: json['length'] as int?,
      dimensionUnit: $enumDecodeNullable(
          _$DimensionUnitConversionEnumMap, json['dimensionUnit']),
      weight: json['weight'] as int?,
      weightUnit: $enumDecodeNullable(
          _$WeightUnitConversionEnumMap, json['weightUnit']),
      isDangerousGood: json['isDangerousGood'] as bool?,
      type: $enumDecodeNullable(_$TypeOfPackageEnumMap, json['type']),
      otherNotes: json['otherNotes'] as String?,
      orderId: json['orderId'] as String?,
    );

Map<String, dynamic> _$OrderPackageToJson(OrderPackage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'currency': instance.currency,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
      'dimensionUnit': _$DimensionUnitConversionEnumMap[instance.dimensionUnit],
      'weight': instance.weight,
      'weightUnit': _$WeightUnitConversionEnumMap[instance.weightUnit],
      'isDangerousGood': instance.isDangerousGood,
      'type': _$TypeOfPackageEnumMap[instance.type],
      'orderId': instance.orderId,
      'otherNotes': instance.otherNotes,
    };

const _$DimensionUnitConversionEnumMap = {
  DimensionUnitConversion.CENTIMETER: 'CENTIMETER',
  DimensionUnitConversion.METER: 'METER',
  DimensionUnitConversion.INCHES: 'INCHES',
  DimensionUnitConversion.FOOT: 'FOOT',
};

const _$WeightUnitConversionEnumMap = {
  WeightUnitConversion.GRAM: 'GRAM',
  WeightUnitConversion.KILOGRAM: 'KILOGRAM',
  WeightUnitConversion.TONNE: 'TONNE',
  WeightUnitConversion.POUND: 'POUND',
};

const _$TypeOfPackageEnumMap = {
  TypeOfPackage.PARCEL: 'PARCEL',
  TypeOfPackage.CARTON: 'CARTON',
  TypeOfPackage.PALLET: 'PALLET',
  TypeOfPackage.OTHER: 'OTHER',
};
