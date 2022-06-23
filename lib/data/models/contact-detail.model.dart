import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';

part 'contact-detail.model.g.dart';

@JsonSerializable()
class ContactDetail {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;
  final String? emailAddress;
  final String? company;
  final Address? address;
  final TypeOfOtherContactDetail? typeOfOtherContactDetail;

  ContactDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumberCountryCode,
    this.phoneNumber,
    this.emailAddress,
    this.company,
    this.address,
    this.typeOfOtherContactDetail,
  });

  factory ContactDetail.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailToJson(this);

  String get fullname {
    var a = "";
    if (firstName != null) a += firstName! + " ";
    if (lastName != null) a += lastName!;
    return a;
  }
}
