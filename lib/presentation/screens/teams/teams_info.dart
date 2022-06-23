import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/screens/teams/edit_team.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../data/enums/status.enum.dart';
import '../../../data/services/app.service.dart';
import 'hover_button.dart';

class TeamInfoPage extends StatefulWidget {
  static const String routeName = 'team-info-page';

  @override
  _TeamInfoPageState createState() => _TeamInfoPageState();
}

class _TeamInfoPageState extends State<TeamInfoPage> {
  Widget _buildHeader(BuildContext context) {
    return Container(
        color: kGreyBackground,
        padding: const EdgeInsets.only(
          left: Spacings.kSpaceLittleBig,
          top: 29,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              backgroundColor: kGreyBackground,
            ),
            icon:
                AppIcons.svgAsset(AppIcons.back_android, height: 24, width: 24),
            label: Text(
              "Back",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]));
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Container(
        color: kWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // <---
          children: [
            Text(
              "West Singapore Team",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24),
            Text(
              "Description",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16),
            Flexible(
              child: Text(
                "Team tasked with same-day delivery within West Singapore and nearby areas.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Operational Flow",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 161,
                    height: 31,
                    child: Center(
                      child: Text(
                        "Sameday Delivery Flow",
                        style: GoogleFonts.inter(
                          color: kWhite,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: kAccentBlue,
                    )),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Row(children: [
                _buildSubAdminList(context),
                _buildDriverList(context),
              ]),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (AppService.hasPermission(PermissionType.DELETE_TEAM))
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Delete',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: kWhite,
                        side: BorderSide(color: Colors.red.shade600)),
                  ),
                if (AppService.hasPermission(PermissionType.UPDATE_TEAM))
                  SizedBox(
                    width: 16,
                  ),
                if (AppService.hasPermission(PermissionType.UPDATE_TEAM))
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, EditTeamInfoPage.routeName);
                    },
                    child: Text(
                      'Edit',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kBlack),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: kWhite, side: BorderSide(color: kBlack)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubAdminList(BuildContext context) {
    var list = [
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
    ];
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Sub-admin (${list.length} Sub-admins)',
          style: Theme.of(context).textTheme.bodyText1),
      SizedBox(
        height: 8,
      ),
      Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Tooltip(
                  child: HoverButton(list: list, index: index),
                  message:
                      "Assigned to: \n ${list[index][2]} \n ${list[index][3]}",
                  verticalOffset: 16,
                  textStyle: TextStyle(color: kBlack),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                  ));
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 4,
                ),
            itemCount: list.length),
      ),
    ]));
  }

  Widget _buildDriverList(BuildContext context) {
    var list = [
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Robert Kimich',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
      [
        'assets/john.png',
        'Min Kim',
        'West Singapore Team',
        'Quick Delivery Team'
      ],
    ];
    return Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Drivers (${list.length} Drivers)',
          style: Theme.of(context).textTheme.bodyText1),
      SizedBox(
        height: 8,
      ),
      Expanded(
        child: ListView.separated(
            shrinkWrap: false,
            itemBuilder: (BuildContext context, int index) {
              return Tooltip(
                  child: HoverButton(list: list, index: index),
                  message:
                      "Assigned to: \n ${list[index][2]} \n ${list[index][3]}",
                  verticalOffset: 16,
                  textStyle: TextStyle(color: kBlack),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                  ));
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 4,
                ),
            itemCount: list.length),
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Container(
              color: kGreyBackground,
              padding: const EdgeInsets.only(
                left: Spacings.kSpaceLittleBig,
                top: 29,
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 0.38.sw,
                  child: _buildBody(context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                    border: Border.all(color: kWhite),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kWhite,
                  ),
                ),
              ])),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
