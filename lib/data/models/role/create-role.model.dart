class CreateRole {
  String? id;
  String? name;
  String? description;
  List<String>? permissionIds;

  CreateRole({this.id, this.name, this.description, this.permissionIds});

  CreateRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    permissionIds = json['permissionIds'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['permissionIds'] = this.permissionIds;
    return data;
  }
}
