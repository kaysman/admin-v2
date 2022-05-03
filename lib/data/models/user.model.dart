import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/driver-details.model.dart';
import 'package:lng_adminapp/data/models/merchant-details.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';

import 'role/role.model.dart';
import 'tenant.model.dart';

part 'user.model.g.dart';

@JsonSerializable()
class UserList {
  late final List<User>? items;
  final Meta? meta;

  UserList({this.items, this.meta});

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);

  Map<String, dynamic> toJson() => _$UserListToJson(this);

  @override
  String toString() => 'UserList(items: $items, meta: $meta)';
}

@JsonSerializable()
class User {
  User({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.password,
    this.countryCode,
    this.phoneNumber,
    this.photoUrl,
    this.roleId,
    this.status,
    this.merchant,
    this.driver,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.tenant,
    this.genericTypeOfUser,
    this.specificTypeOfUser,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? emailAddress;
  final String? password;
  final String? countryCode;
  final String? phoneNumber;
  final String? photoUrl;
  final String? roleId;
  final String? status;
  final SpecificTypeOfUser? specificTypeOfUser;
  final GenericTypeOfUser? genericTypeOfUser;

  final MerchantDetails? merchant;
  final DriverDetails? driver;
  final Role? role;
  final Tenant? tenant;

  final String? createdAt;
  final String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'firstName': this.firstName,
        'lastName': this.lastName,
        'emailAddress': this.emailAddress,
        'password': this.password,
        'countryCode': this.countryCode,
        'phoneNumber': this.phoneNumber,
        'photoUrl': this.photoUrl,
        'roleId': this.roleId,
        'status': this.status,
        'createdAt': this.createdAt,
        'updatedAt': this.updatedAt,
        'merchantDetails': this.merchant,
        'driverDetails': this.driver,
        'role': this.role,
        'tenant': this.tenant,
      };

  String get fullname {
    var a = "";
    if (firstName != null) a += firstName! + " ";
    if (lastName != null) a += lastName!;
    return a;
  }

  String? get title => role?.name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
