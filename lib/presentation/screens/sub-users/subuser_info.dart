import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../data/enums/status.enum.dart';
import '../../../data/services/app.service.dart';

class SubadminInfoScreen extends StatelessWidget {
  static const String routeName = "subadmin-info";
  final User user;

  const SubadminInfoScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.all(32),
                child: FlatBackButton(),
              ),
              Container(
                width: 0.35.sw,
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sub-user information',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        // if (AppService.hasPermission(
                        //     PermissionType.UPDATE_USER))
                        //   Spacer(),
                        // if (AppService.hasPermission(
                        //     PermissionType.UPDATE_USER))
                        //   Button(
                        //     elevation: 0,
                        //     hasBorder: true,
                        //     text: 'Deactivate',
                        //     onPressed: () {
                        //       showWhiteDialog(
                        //           context, DeactivateSubAdminDialog());
                        //     },
                        //   ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: kGrey3Color,
                      child: Center(
                        child: Icon(
                          Icons.person_outline_outlined,
                          color: kGrey1Color,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _ContactDetails(user),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails(
    this.user, {
    Key? key,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Contact Details',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      SizedBox(
        height: 16,
      ),
      Column(
        children: [
          Details(title: 'Name', value: user.fullname),
          SizedBox(
            height: 16,
          ),
          Details(title: 'Email', value: user.emailAddress ?? ''),
          SizedBox(
            height: 16,
          ),
          Details(title: 'Phone number', value: user.phoneNumber ?? ''),
          SizedBox(
            height: 16,
          ),
          Details(title: 'Assigned role', value: user.role?.name ?? ''),
        ],
      )
    ]);
  }
}

class DeleteSubAdminDialog extends StatelessWidget {
  const DeleteSubAdminDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 410.sp,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Delete Sub-admin",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: kFailedColor),
          ),
          SizedBox(height: 16.sp),
          Text(
            "Simran Joul will be permanently deleted. You can choose to deactivate the sub-admin account instead.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 32.sp),
          Text(
            "Please type 'DELETEACCOUNT' if you would like to confirm delete",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 16.sp),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32.sp,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.sp,
                        horizontal: 12.sp,
                      ),
                      hintText: "Type here",
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.sp),
              Button(
                elevation: 0,
                text: "Delete",
                hasBorder: true,
                textColor: kFailedColor,
                borderColor: kFailedColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeactivateSubAdminDialog extends StatelessWidget {
  const DeactivateSubAdminDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 410.sp,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Deactivate Sub-admin",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 16.sp),
          Text(
            "Simran Joul will be deactivated and account can no longer be accessed by sub-admin. You can reactivate this sub-admin at anytime",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 32.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Button(
                text: "Cancel",
                elevation: 0,
                hasBorder: true,
                borderColor: kPrimaryColor,
                textColor: kPrimaryColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 16.sp),
              Button(
                elevation: 0,
                hasBorder: true,
                text: 'Deactivate',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
