import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/team/create-team-request.model.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/teams/team.bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTeam extends StatefulWidget {
  static const String routeName = 'create-team';
  const CreateTeam({Key? key}) : super(key: key);

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final _teamNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  GlobalKey<FormState> _createTeamFormKey = GlobalKey<FormState>();
  String? _workflow;
  late TeamBloc teamBloc;
  Team? team;
  @override
  void initState() {
    teamBloc = context.read<TeamBloc>();
    checkIfUserIsUpdating();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _teamNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void checkIfUserIsUpdating() {
    print(TeamService.selectedTeam.value);
    if (TeamService.selectedTeam.value != null) {
      team = TeamService.selectedTeam.value;
    }
    _teamNameController.text = team?.name ?? '';
    _descriptionController.text = team?.description ?? '';

    // TODO: Work on others later.
  }

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);
    List<String> _operationalFlow = ['Sample'];

    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatBackButton(),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  child: Text(
                    team == null ? 'Add a new team' : 'Update team',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kText1Color,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Form(
                  key: _createTeamFormKey,
                  child: ViewContentLayout(
                    margin: 0,
                    height: 600.h,
                    freezeContent:
                        state.createTeamStatus == CreateTeamStatus.loading,
                    content: [
                      LabeledInput(
                        label: 'Team name',
                        controller: _teamNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Team name',
                        validator: (value) {
                          return emptyField(value);
                        },
                      ),
                      space,
                      LabeledInput(
                        label: 'Description',
                        controller: _descriptionController,
                        hintText: 'Description',
                      ),
                      space,
                      // RowOfTwoChildren(
                      //   child1: LabeledRadioDropdown(
                      //     label: "Select operational flow",
                      //     value: _workflow,
                      //     onSelected: (String v) => setState(() {
                      //       _workflow = v;
                      //     }),
                      //     items: _operationalFlow,
                      //   ),
                      //   child2: SizedBox(),
                      // ),
                      space,
                      _buildSubAdminList(context, 'Sub-admins'),
                      space,
                      _buildSubAdminList(context, 'Drivers')
                    ],
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Button(
                          text: team == null ? 'Save' : 'Update',
                          hasBorder: true,
                          textColor: kGrey1Color,
                          isLoading: state.createTeamStatus ==
                              CreateTeamStatus.loading,
                          onPressed: () async {
                            if (_createTeamFormKey.currentState!.validate()) {
                              bool isUpdating = team != null;
                              await submitForm(teamBloc, context, isUpdating);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  submitForm(TeamBloc teamBloc, BuildContext context, bool isUpdating) async {
    CreateTeamRequest _createTeamRequest = CreateTeamRequest(
      id: isUpdating ? team?.id : null,
      name: _teamNameController.text,
      description: _descriptionController.text,
    );

    await teamBloc.saveTeam(_createTeamRequest, context, isUpdating);
  }
}

Widget _buildSubAdminList(BuildContext context, String? title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 8.h),
      CheckBoxDropdown(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: kPrimaryColor),
            Text(
              "Add $title",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ],
        ),
      ),
    ],
  );
}
