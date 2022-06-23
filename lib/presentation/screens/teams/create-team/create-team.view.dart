import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/team/create-team-request.model.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
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
  GlobalKey<FormState> _createTeamFormKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late TeamBloc teamBloc;
  Team? team;

  List<User>? _selectedDrivers;

  @override
  void initState() {
    teamBloc = context.read<TeamBloc>();
    checkIfUserIsUpdating();

    super.initState();
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void checkIfUserIsUpdating() {
    if (TeamService.selectedTeam.value != null) {
      team = TeamService.selectedTeam.value;
    }
    _teamNameController.text = team?.name ?? '';
    _descriptionController.text = team?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);

    return Scaffold(
      backgroundColor: kGreyBackground,
      body: LngPage(
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
                        validator: emptyField,
                      ),
                      space,
                      LabeledInput(
                        label: 'Description',
                        controller: _descriptionController,
                        hintText: 'Description',
                      ),
                      space,
                      Text(
                        'Drivers',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () async {
                          var res = await showWhiteDialog(
                            context,
                            _SelectDriversDialog(drivers: _selectedDrivers),
                            true,
                          );
                          if (res != null && res is List<User>) {
                            setState(() => _selectedDrivers = res);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_selectedDrivers == null)
                              Icon(Icons.add, color: kPrimaryColor),
                            Text(
                              _selectedDrivers != null
                                  ? "${_selectedDrivers!.length} drivers selected"
                                  : "Add drivers",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: kPrimaryColor,
                                  ),
                            ),
                            if (_selectedDrivers != null)
                              Icon(Icons.add, color: kPrimaryColor),
                          ],
                        ),
                      ),
                    ],
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Button(
                          text: team == null ? 'Save' : 'Update',
                          hasBorder: true,
                          borderColor: kGrey1Color,
                          textColor: kGrey1Color,
                          primary: kWhite,
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
    if (_selectedDrivers == null) return null;

    CreateTeamRequest _createTeamRequest = CreateTeamRequest(
      name: _teamNameController.text,
      description: _descriptionController.text,
      driverIds: _selectedDrivers!.map((e) => e.id!).toList(),
    );

    await teamBloc.saveTeam(_createTeamRequest, context, isUpdating);
  }

  _buildAddButton(BuildContext context, String title1, String? title2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title1',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: () async {
            var res = await showWhiteDialog(
              context,
              _SelectDriversDialog(drivers: _selectedDrivers),
              true,
            );
            if (res != null && res is List<User>) {
              setState(() => _selectedDrivers = res);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: kPrimaryColor),
              if (title2 != null)
                Text(
                  title2,
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
}

class _SelectDriversDialog extends StatefulWidget {
  const _SelectDriversDialog({Key? key, this.drivers}) : super(key: key);

  final List<User>? drivers;

  @override
  State<_SelectDriversDialog> createState() => _SelectDriversDialogState();
}

class _SelectDriversDialogState extends State<_SelectDriversDialog> {
  late DriverBloc driverBloc;
  List<User> selectedDrivers = [];

  @override
  void initState() {
    driverBloc = BlocProvider.of<DriverBloc>(context);
    if (driverBloc.state.drivers == null) {
      driverBloc.loadDrivers();
    }

    if (widget.drivers != null) selectedDrivers = widget.drivers!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4.sw,
      height: 0.5.sh,
      child: BlocBuilder<DriverBloc, DriverState>(
        bloc: driverBloc,
        builder: (context, state) {
          var _listDriverStatus = state.listDriverStatus;
          var _drivers = state.driverItems;
          var _meta = state.drivers?.meta;

          if (_listDriverStatus == ListDriverStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_listDriverStatus == ListDriverStatus.error) {
            return TryAgainButton(
              tryAgain: () async {
                await driverBloc.loadDrivers();
              },
            );
          }

          return Column(
            children: [
              SizedBox(height: 16.0),
              Text("Select drivers",
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _drivers
                            ?.map(
                              (e) => CheckboxListTile(
                                title: Text(e.fullname),
                                value: selectedDrivers.contains(e),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      selectedDrivers.add(e);
                                    } else if (newValue == false) {
                                      selectedDrivers.remove(e);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    textColor: kPrimaryColor,
                    primary: kWhite,
                    text: "Cancel",
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 12.0),
                  Button(
                    text: "Select",
                    onPressed: () => Navigator.of(context).pop(selectedDrivers),
                    textColor: kWhite,
                    primary: kPrimaryColor,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
            ],
          );
        },
      ),
    );
  }
}
