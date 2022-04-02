import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
part 'receiver.model.g.dart';

@JsonSerializable()
class ReceiverDetail {
  ReceiverDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.company,
    this.address,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? emailAddress;
  final String? phoneNumber;
  final String? company;
  final Address? address;

  factory ReceiverDetail.fromJson(Map<String, dynamic> json) =>
      _$ReceiverDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverDetailToJson(this);
}
