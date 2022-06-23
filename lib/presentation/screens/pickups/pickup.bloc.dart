import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/pickup/approve-pickup-request.model.dart';
import 'package:lng_adminapp/data/models/pickup/create-pickup-request.model.dart';
import 'package:lng_adminapp/data/models/pickup/pickup.model.dart';
import 'package:lng_adminapp/data/services/pickup.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class PickupBloc extends Cubit<PickupState> {
  PickupBloc() : super(PickupState(pickupStatus: PickupStatus.loading)) {
    loadPickupRequests();
  }

  loadPickupRequests([String page = "1"]) async {
    final queryParams = <String, String>{
      "page": page,
      "limit": state.perPage,
    };
    emit(state.updatePickupRequestState(pickupStatus: PickupStatus.loading));
    try {
      var pickups = await PickupService.getPickups(queryParams);
      emit(state.updatePickupRequestState(
        pickupStatus: PickupStatus.idle,
        pickups: pickups,
        pickupItems: pickups.items,
      ));
    } catch (_) {
      emit(state.updatePickupRequestState(pickupStatus: PickupStatus.error));
      throw _;
    }
  }

  savePickupRequest(CreatePickupRequest data, BuildContext context) async {
    emit(state.updatePickupRequestState(
        createPickupRequestStatus: CreatePickupRequestStatus.loading));

    try {
      var result = await PickupService.createPickupRequest(data);
      if (result.success == true) {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () {
              emit(
                state.updatePickupRequestState(
                  createPickupRequestStatus: CreatePickupRequestStatus.success,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              loadPickupRequests();
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
      emit(state.updatePickupRequestState(
          createPickupRequestStatus: CreatePickupRequestStatus.idle));
    } catch (error) {
      emit(state.updatePickupRequestState(
          createPickupRequestStatus: CreatePickupRequestStatus.idle));
    }
  }

  approvePickupRequest(ApproveRequestModel data, BuildContext context) async {
    emit(state.updatePickupRequestState(
        approvePickupRequestStatus: ApprovePickupRequestStatus.loading));

    try {
      var result = await PickupService.approvePickupRequest(data);
      if (result.success == true) {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () {
              emit(
                state.updatePickupRequestState(
                  approvePickupRequestStatus:
                      ApprovePickupRequestStatus.success,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
              loadPickupRequests();
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
      emit(state.updatePickupRequestState(
          approvePickupRequestStatus: ApprovePickupRequestStatus.idle));
    } catch (error) {
      emit(state.updatePickupRequestState(
          approvePickupRequestStatus: ApprovePickupRequestStatus.idle));
    }
  }

  declinePickupRequest() {}

  getPickupBasedOnStatus(PickupList data, String? status) {
    emit(state.updatePickupRequestState(pickupStatus: PickupStatus.loading));
    var pickups;
    try {
      if (status == 'ALL') {
        pickups = data.items;
      } else {
        pickups = data.items!.where((s) => s.status == status).toList();
      }
      emit(state.updatePickupRequestState(
        pickupStatus: PickupStatus.idle,
        pickups: data,
        pickupItems: pickups,
      ));
    } catch (_) {
      emit(state.updatePickupRequestState(pickupStatus: PickupStatus.error));
      throw _;
    }
  }

  setPerPageAndLoad(String v) {
    emit(state.updatePickupRequestState(perPage: v));
    this.loadPickupRequests();
  }
}

enum PickupStatus { idle, loading, error }

enum CreatePickupRequestStatus { idle, loading, error, success }

enum ApprovePickupRequestStatus { idle, loading, error, success }

class PickupState {
  final PickupStatus pickupStatus;
  final CreatePickupRequestStatus createPickupRequestStatus;
  final ApprovePickupRequestStatus approvePickupRequestStatus;

  final PickupList? pickups;
  final List<Pickup>? pickupItems;
  final String perPage;

  PickupState({
    this.pickupStatus = PickupStatus.idle,
    this.pickups,
    this.pickupItems,
    this.perPage = "10",
    this.createPickupRequestStatus = CreatePickupRequestStatus.idle,
    this.approvePickupRequestStatus = ApprovePickupRequestStatus.idle,
  });

  PickupState updatePickupRequestState({
    CreatePickupRequestStatus? createPickupRequestStatus,
    ApprovePickupRequestStatus? approvePickupRequestStatus,
    PickupStatus? pickupStatus,
    PickupList? pickups,
    List<Pickup>? pickupItems,
    String? perPage,
  }) {
    return PickupState(
      createPickupRequestStatus:
          createPickupRequestStatus ?? this.createPickupRequestStatus,
      approvePickupRequestStatus:
          approvePickupRequestStatus ?? this.approvePickupRequestStatus,
      pickupStatus: pickupStatus ?? this.pickupStatus,
      pickups: pickups ?? this.pickups,
      pickupItems: pickupItems ?? this.pickupItems,
      perPage: perPage ?? this.perPage,
    );
  }
}
