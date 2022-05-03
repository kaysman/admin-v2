import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';

import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-within-system.model.dart';

import '../../../data/services/user.service.dart';

enum ListSubuserStatus { idle, loading, error }
enum CreateSubuserStatus { idle, loading, error, success }

class SubuserState {
  final ListSubuserStatus listSubuserStatus;
  final CreateSubuserStatus createUserStatus;
  final UserList? subusers;
  final int perPage;

  SubuserState({
    this.listSubuserStatus = ListSubuserStatus.idle,
    this.createUserStatus = CreateSubuserStatus.idle,
    this.subusers,
    this.perPage = 10,
  });

  static SubuserState init() {
    return SubuserState(
      listSubuserStatus: ListSubuserStatus.loading,
      createUserStatus: CreateSubuserStatus.idle,
    );
  }

  SubuserState copyWith({
    ListSubuserStatus? listSubuserStatus,
    CreateSubuserStatus? createUserStatus,
    UserList? subusers,
    int? perPage,
  }) {
    return SubuserState(
      listSubuserStatus: listSubuserStatus ?? this.listSubuserStatus,
      createUserStatus: createUserStatus ?? this.createUserStatus,
      subusers: subusers ?? this.subusers,
      perPage: perPage ?? this.perPage,
    );
  }
}

class SubuserBloc extends Cubit<SubuserState> {
  SubuserBloc() : super(SubuserState.init()) {
    loadSubusers();
  }

  loadSubusers([PaginationOptions? paginationOptions]) async {
    if (paginationOptions == null)
      paginationOptions = PaginationOptions(
        limit: state.perPage,
      );

    emit(state.copyWith(listSubuserStatus: ListSubuserStatus.loading));
    try {
      var subusers = await UserService.getSubUsers(paginationOptions.toJson());
      emit(state.copyWith(
        listSubuserStatus: ListSubuserStatus.idle,
        subusers: subusers,
      ));
    } catch (_) {
      print(_.toString());
      emit(state.copyWith(listSubuserStatus: ListSubuserStatus.error));
      throw _;
    }
  }

  createSubuser(CreateUserWithinSystem data) async {
    emit(state.copyWith(createUserStatus: CreateSubuserStatus.loading));
    try {
      var res = await UserService.createSubuser(data);
      if (res.code == 201) {
        emit(state.copyWith(createUserStatus: CreateSubuserStatus.success));
        loadSubusers();
      }
    } catch (_) {
      print(_.toString());
      emit(state.copyWith(createUserStatus: CreateSubuserStatus.error));
    }
  }

  setPerPageAndLoad(int v) {
    emit(state.copyWith(perPage: v));
    this.loadSubusers();
  }
}
