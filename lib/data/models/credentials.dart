import 'package:lng_adminapp/data/models/role/role.model.dart';

class Credentials {
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? accessToken;
  String? id;
  String? phoneNumber;
  String? photoUrl;
  Role? role;

  Credentials(
      {this.firstName,
      this.lastName,
      this.emailAddress,
      this.accessToken,
      this.id,
      this.phoneNumber,
      this.photoUrl,
      this.role});

  Credentials.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailAddress = json['emailAddress'];
    accessToken = json['accessToken'];
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    photoUrl = json['photoUrl'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailAddress'] = this.emailAddress;
    data['accessToken'] = this.accessToken;
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['photoUrl'] = this.photoUrl;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}
