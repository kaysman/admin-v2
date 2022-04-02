import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/team/create-team-request.model.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class TeamBloc extends Cubit<TeamState> {
  TeamBloc(this.deleteDialogBloc)
      : super(TeamState(
          listTeamStatus: ListTeamStatus.loading,
          createTeamStatus: CreateTeamStatus.idle,
          teamInformationStatus: TeamInformationStatus.idle,
        )) {
    loadTeams();
  }
  final DeleteDialogBloc deleteDialogBloc;

  loadTeams([String page = '1']) async {
    final queryParams = <String, String>{"page": page, "limit": state.perPage};
    emit(state.updateTeamState(listTeamStatus: ListTeamStatus.loading));

    try {
      var teams = await TeamService.getTeams(queryParams);
      emit(state.updateTeamState(
        listTeamStatus: ListTeamStatus.idle,
        teams: teams,
        teamItems: teams.items,
      ));
    } catch (_) {
      emit(state.updateTeamState(listTeamStatus: ListTeamStatus.error));
      throw _;
    }
  }

  setPerPageAndLoad(String v) {}

  updateGlobalSelectedTeam(CreateTeamRequest data) {
    Team _updateTeam = new Team(
      name: data.name,
      description: data.description,
    );
    TeamService.selectedTeam.value = _updateTeam;
    // update the team object
  }

  saveTeam(
      CreateTeamRequest data, BuildContext context, bool isUpdating) async {
    emit(
      state.updateTeamState(createTeamStatus: CreateTeamStatus.loading),
    );

    try {
      var result = await TeamService.createTeam(data, isUpdating);
      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedTeam(data);
        }
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () {
              emit(
                state.updateTeamState(
                  createTeamStatus: CreateTeamStatus.success,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              loadTeams();
            },
          ),
        );
      } else {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.ERROR,
            message: result.message,
            onClose: () {},
          ),
        );
      }
      emit(state.updateTeamState(createTeamStatus: CreateTeamStatus.idle));
    } catch (error) {
      emit(state.updateTeamState(createTeamStatus: CreateTeamStatus.idle));
    }
  }
}

enum ListTeamStatus { idle, loading, error }
enum TeamInformationStatus { idle, loading, error }
enum CreateTeamStatus { idle, loading, error, success }

class TeamState {
  final ListTeamStatus? listTeamStatus;
  final CreateTeamStatus createTeamStatus;
  final TeamInformationStatus teamInformationStatus;
  final String perPage;
  final TeamList? teams;
  final List<Team>? teamItems;

  TeamState({
    this.listTeamStatus = ListTeamStatus.loading,
    this.createTeamStatus = CreateTeamStatus.idle,
    this.teamInformationStatus = TeamInformationStatus.loading,
    this.perPage = '10',
    this.teamItems,
    this.teams,
  });

  TeamState updateTeamState({
    CreateTeamStatus? createTeamStatus,
    TeamInformationStatus? teamInformationStatus,
    ListTeamStatus? listTeamStatus,
    String? perPage,
    TeamList? teams,
    List<Team>? teamItems,
  }) {
    return TeamState(
      createTeamStatus: createTeamStatus ?? this.createTeamStatus,
      listTeamStatus: listTeamStatus ?? this.listTeamStatus,
      teamInformationStatus:
          teamInformationStatus ?? this.teamInformationStatus,
      perPage: perPage ?? this.perPage,
      teamItems: teamItems ?? this.teamItems,
      teams: teams ?? this.teams,
    );
  }
}
