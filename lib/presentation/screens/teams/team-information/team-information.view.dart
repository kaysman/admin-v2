import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/teams/create-team/create-team.view.dart';
import 'package:lng_adminapp/presentation/screens/teams/widgets/color-pill.widget.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enums/status.enum.dart';

class TeamInformation extends StatefulWidget {
  static const String routeName = 'team-information';
  const TeamInformation({Key? key}) : super(key: key);

  @override
  _TeamInformationState createState() => _TeamInformationState();
}

class _TeamInformationState extends State<TeamInformation> {
  Team? team;
  deleteFunction(String id) {
    showWhiteDialog(
      context,
      DeleteDialog(
        title: 'Delete Team',
        message: 'Are you ready to delete',
        type: DialogType.DELETE,
        module: ModuleType.TEAM,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (TeamService.selectedTeam.value != null) {
      team = TeamService.selectedTeam.value;
    }
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: ValueListenableBuilder(
        valueListenable: TeamService.selectedTeam,
        builder: (BuildContext context, Team? v, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: FlatBackButton(),
              ),
              ViewContentLayout(
                content: [
                  Text(
                    '${v?.name ?? '-'}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    '${v?.description ?? '-'}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'Operational Flow',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ColorPill(text: 'Operational Pill'),
                  SizedBox(
                    height: 16.h,
                  ),
                  _headerWithCount(
                    title: 'Sub-admins',
                    count: 0,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  _headerWithCount(
                    title: 'Drivers',
                    count: 0,
                  ),
                ],
                footer: (AppService.hasPermission(PermissionType.DELETE_TEAM) ||
                        AppService.hasPermission(PermissionType.UPDATE_TEAM))
                    ? Row(
                        children: [
                          Spacer(),
                          if (AppService.hasPermission(
                                  PermissionType.DELETE_TEAM) &&
                              v != null)
                            Button(
                              text: 'Delete',
                              borderColor: kFailedColor,
                              hasBorder: true,
                              textColor: kFailedColor,
                              onPressed: () => deleteFunction(v.id!),
                            ),
                          if (AppService.hasPermission(
                              PermissionType.UPDATE_TEAM))
                            SizedBox(
                              width: 16.w,
                            ),
                          if (AppService.hasPermission(
                              PermissionType.UPDATE_TEAM))
                            Button(
                              text: 'Edit',
                              borderColor: kPrimaryColor,
                              hasBorder: true,
                              textColor: kPrimaryColor,
                              onPressed: () => navigateToCreateTeamPage(v),
                            )
                        ],
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  navigateToCreateTeamPage(data) {
    Navigator.pushNamed(
      context,
      CreateTeam.routeName,
    );
  }
}

class _headerWithCount extends StatelessWidget {
  final String? title;
  final int? count;
  final dynamic data;
  const _headerWithCount({
    Key? key,
    this.title,
    this.count,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.data is User) {
    } else {}
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              '${count ?? 0} $title',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: kGrey1Color,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: kGrey3Color,
                borderRadius: BorderRadius.circular(100.r),
              ),
              padding: EdgeInsets.all(
                2.w,
              ),
              child:
                  //  this.selectedImage != null
                  //     ? ClipOval(
                  //         child: Image.asset(
                  //           this.selectedImage!.files.first.bytes!,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  //     :
                  Icon(
                Icons.person,
                size: 10.w,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              'Name',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
