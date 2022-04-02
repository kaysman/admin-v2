import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-request.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class DriverBloc extends Cubit<DriverState> {
  DriverBloc(this.deleteDialogBloc)
      : super(DriverState(
          listDriverStatus: ListDriverStatus.loading,
          createDriverStatus: CreateDriverStatus.idle,
          driverInformationStatus: DriverInformationStatus.idle,
        )) {
    loadDrivers();
  }
  final DeleteDialogBloc deleteDialogBloc;

  loadDrivers([String page = "1"]) async {
    final queryParams = <String, String>{
      "page": page,
      "limit": state.perPage,
      "roleId": "06e56cbb-c883-4da8-8cb3-06661d829ef6"
    };
    emit(state.updateDriverState(listDriverStatus: ListDriverStatus.loading));

    try {
      var drivers = await UserService.getUsers(queryParams);
      emit(state.updateDriverState(
        listDriverStatus: ListDriverStatus.idle,
        drivers: drivers,
        driverItems: drivers.items,
      ));
    } catch (_) {
      print(_.toString());
      emit(state.updateDriverState(listDriverStatus: ListDriverStatus.error));
      throw _;
    }
  }

  setPerPageAndLoad(String v) {
    emit(state.updateDriverState(perPage: v));
    this.loadDrivers();
  }

  updateGlobalSelectedDriver(CreateUserRequest data) {
    User _updatedUser = new User(
      id: data.id,
      firstName: data.firstName,
      lastName: data.lastName,
      emailAddress: data.emailAddress,
      phoneNumber: data.phoneNumber,
      photoUrl: data.photoUrl,
      driver: data.driverDetails,
      merchant: data.merchantDetails,
    );
    UserService.selectedDriver.value = _updatedUser;
  }

  saveDriver(
      CreateUserRequest data, BuildContext context, bool isUpdating) async {
    emit(
      state.updateDriverState(createDriverStatus: CreateDriverStatus.loading),
    );
    try {
      var result = await UserService.createUser(data, isUpdating);

      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedDriver(data);
        }
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () => {
              emit(
                state.updateDriverState(
                  createDriverStatus: CreateDriverStatus.success,
                ),
              ),
              Navigator.pop(context),
              Navigator.pop(context),
              loadDrivers(),
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
        // show error dialog
      }
      emit(
          state.updateDriverState(createDriverStatus: CreateDriverStatus.idle));
    } catch (_) {
      emit(
          state.updateDriverState(createDriverStatus: CreateDriverStatus.idle));
    }
  }
}

enum ListDriverStatus { idle, loading, error }
enum DriverInformationStatus { idle, loading, error }
enum CreateDriverStatus { idle, loading, error, success }

class DriverState {
  final ListDriverStatus listDriverStatus;
  final UserList? drivers;
  final List<User>? driverItems;
  final String perPage;
  final CreateDriverStatus createDriverStatus;
  final DriverInformationStatus driverInformationStatus;

  DriverState({
    this.listDriverStatus = ListDriverStatus.loading,
    this.drivers,
    this.driverItems,
    this.perPage = '10',
    this.createDriverStatus = CreateDriverStatus.idle,
    this.driverInformationStatus = DriverInformationStatus.loading,
  });

  DriverState updateDriverState(
      {ListDriverStatus? listDriverStatus,
      UserList? drivers,
      List<User>? driverItems,
      String? perPage,
      CreateDriverStatus? createDriverStatus,
      DriverInformationStatus? driverInformationStatus}) {
    return DriverState(
      perPage: perPage ?? this.perPage,
      listDriverStatus: listDriverStatus ?? this.listDriverStatus,
      drivers: drivers ?? this.drivers,
      driverItems: driverItems ?? this.driverItems,
      createDriverStatus: createDriverStatus ?? this.createDriverStatus,
    );
  }
}
