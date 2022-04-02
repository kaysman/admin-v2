import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';
import 'details.dart';

class RoleDetails extends StatelessWidget {
  final String? name;
  final String? description;
  final String? id;
  final String? creationTime;
  const RoleDetails({
    Key? key,
    this.name,
    this.description,
    this.id,
    this.creationTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Role Details', style: Theme.of(context).textTheme.bodyText2),
      SizedBox(
        height: 16.h,
      ),
      Column(
        children: [
          Details(title: 'Role Name', value: '${replaceStringWithDash(name)}'),
          SizedBox(
            height: 16.h,
          ),
          Details(
              title: 'Role Description',
              value: '${replaceStringWithDash(description)}'),
          SizedBox(
            height: 16.h,
          ),
          Details(title: 'Role ID', value: '${replaceStringWithDash(id)}'),
          SizedBox(
            height: 16.h,
          ),
          Details(
              title: 'Creation Time',
              value:
                  '${replaceStringWithDash(formatToOrderStatusDate(creationTime))}'),
        ],
      )
    ]);
  }
}
