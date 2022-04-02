import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/role/permission-toggle-feedback.model.dart';
import 'package:lng_adminapp/data/models/role/permission.model.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolePermission extends StatefulWidget {
  final String title;
  final List<Widget>? permissions;
  // final int? activePermissions;
  const RolePermission({
    Key? key,
    required this.title,
    this.permissions,
    // this.activePermissions,
  }) : super(key: key);

  @override
  _RolePermissionState createState() => _RolePermissionState();
}

class _RolePermissionState extends State<RolePermission> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: kGrey3Color)),
          clipBehavior: Clip.hardEdge,
          child: ExpansionTile(
            maintainState: true,
            textColor: Colors.black,
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            initiallyExpanded: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                // SizedBox(
                //   width: 8.w,
                // ),
                // CircleAvatar(
                //   backgroundColor: kPrimaryColor,
                //   radius: 12.r,
                //   child: Text('${widget.activePermissions}'),
                // )
              ],
            ),
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Permissions',
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Status',
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                    ],
                  ),
                  ...widget.permissions!

                  // PermissionToggle(
                  //   title: 'Modify',
                  //   // key: _modifyKey,
                  // ),
                  // PermissionToggle(
                  //   title: 'Read',
                  //   // key: _readKey,
                  // )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}

class PermissionToggle extends StatefulWidget {
  final Permission permission;
  final ValueChanged<PermissionToggleFeedback>? onValueChanged;
  bool isToggled;
  PermissionToggle({
    Key? key,
    required this.permission,
    this.isToggled = false,
    this.onValueChanged,
  }) : super(key: key);

  @override
  _PermissionToggleState createState() => _PermissionToggleState();
}

class _PermissionToggleState extends State<PermissionToggle> {
  bool get isToggled => widget.isToggled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Text(
            widget.permission.name!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Switch(
          value: widget.isToggled,
          onChanged: (value) {
            PermissionToggleFeedback feedback = PermissionToggleFeedback();
            setState(() {
              widget.isToggled = value;
              feedback.id = widget.permission.id!;
              feedback.status = value;
              widget.onValueChanged!(feedback);
            });
          },
        )
      ],
    );
  }
}
