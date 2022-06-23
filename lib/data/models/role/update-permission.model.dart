class UpdatePermissions {
  String? roleId;
  List<String>? permissionIds;

  UpdatePermissions({this.roleId, this.permissionIds});

  UpdatePermissions.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    permissionIds = json['permissionIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['permissionIds'] = this.permissionIds;
    return data;
  }
}
