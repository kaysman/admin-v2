import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/teams/create-team/create-team.view.dart';
import 'package:lng_adminapp/presentation/screens/teams/team.bloc.dart';
import 'package:lng_adminapp/presentation/screens/teams/widgets/task-item.widget.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';

class ListTeams extends StatelessWidget {
  static const String routeName = 'manage-teams';
  const ListTeams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TeamList();
  }
}

class TeamList extends StatefulWidget {
  const TeamList({Key? key}) : super(key: key);
  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  late TeamBloc teamBloc;

  @override
  void initState() {
    teamBloc = context.read<TeamBloc>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Container(
        margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
        child: BlocBuilder<TeamBloc, TeamState>(
            bloc: teamBloc,
            builder: (context, teamState) {
              var _listTeamStatus = teamState.listTeamStatus;
              var _teams = teamState.teamItems;
              var _meta = teamState.teams?.meta;

              if (_listTeamStatus == ListTeamStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (_listTeamStatus == ListTeamStatus.error) {
                return const Center(
                  child: Text('Some error occurred'),
                );
              }
              return BlocConsumer<DeleteDialogBloc, DeleteDialogState>(
                listener: (context, deleteDialogState) {
                  if (deleteDialogState.deleteTeamStatus ==
                      DeleteTeamStatus.success) {
                    teamBloc.loadTeams();
                  }
                },
                listenWhen: (state1, state2) => state1 != state2,
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 0.35.sw,
                            child: Row(
                              children: [
                                Text(
                                  'Teams',
                                  style: GoogleFonts.inter(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: 24.w,
                                ),
                                Expanded(
                                  child: TextField(
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                          color: kWhite,
                                          width: 0.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                            color: kPrimaryColor,
                                            width: 0.0,
                                          )),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                          color: kWhite,
                                          width: 0.0,
                                        ),
                                      ),
                                      hintText: 'Search',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(
                                            color: kGrey1Color,
                                          ),
                                      prefixIcon: Container(
                                        padding: EdgeInsets.all(8.sp),
                                        child:
                                            AppIcons.svgAsset(AppIcons.search),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AppIcons.svgAsset(
                                AppIcons.help,
                              ),
                              if (AppService.hasPermission(
                                  PermissionType.CREATE_TEAM))
                                SizedBox(width: 24.w),
                              if (AppService.hasPermission(
                                  PermissionType.CREATE_TEAM))
                                Button(
                                  primary: Theme.of(context).primaryColor,
                                  text: 'Create new team',
                                  textColor: kWhite,
                                  onPressed: () {
                                    TeamService.selectedTeam.value = null;

                                    Navigator.pushNamed(
                                      context,
                                      CreateTeam.routeName,
                                    );
                                  },
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(
                            24.w,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 45,
                                color: const Color(0xff000000).withOpacity(0.1),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (_teams != null) ...[
                                    for (var team in _teams) ...[
                                      TeamItem(
                                        data: team,
                                      ),
                                    ]
                                  ]

                                  // TeamItem(),
                                  // TeamItem(),
                                  // TeamItem(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
