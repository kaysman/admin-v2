import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/teams/team-information/team-information.view.dart';
import 'package:lng_adminapp/presentation/screens/teams/widgets/color-pill.widget.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamItem extends StatelessWidget {
  final Team? data;
  const TeamItem({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, TeamInformation.routeName);
        TeamService.selectedTeam.value = data;
      },
      child: Container(
        width: 331.w,
        height: 250.h,
        padding: EdgeInsets.all(
          16.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: kWhite,
          border: Border.all(
            color: Color(
              0xFFE0E0E0,
            ),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColorPill(
              text: 'Operational Flow',
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              '${data?.name ?? '-'}',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: Text(
                '${data?.description ?? '-'}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    AppIcons.svgAsset(
                      AppIcons.subadmin,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${0} Sub-Admin(s)',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppIcons.svgAsset(
                      AppIcons.driver,
                      width: 20.sp,
                      height: 20.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${data?.drivers?.length ?? 0} Driver(s)',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
