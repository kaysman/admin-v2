import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-request.model.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class MerchantBloc extends Cubit<MerchantState> {
  MerchantBloc(this.deleteDialogBloc)
      : super(MerchantState(
          listMerchantStatus: ListMerchantStatus.loading,
          createMerchantStatus: CreateMerchantStatus.idle,
          merchantInformationStatus: MerchantInformationStatus.idle,
        )) {
    loadMerchants();
  }

  final DeleteDialogBloc deleteDialogBloc;

  loadMerchants([PaginationOptions? paginationOptions]) async {
    if (paginationOptions == null) paginationOptions = PaginationOptions();

    emit(state.updateMerchantState(listMerchantStatus: ListMerchantStatus.loading));

    try {
      var merchants = await UserService.getMerchants(paginationOptions.toJson());
      emit(state.updateMerchantState(
        listMerchantStatus: ListMerchantStatus.idle,
        merchants: merchants,
        merchantItems: merchants.items,
      ));
    } catch (_) {
      emit(state.updateMerchantState(listMerchantStatus: ListMerchantStatus.error));
      throw _;
    }
  }

  setPerPageAndLoad(int v) {
    emit(state.updateMerchantState(perPage: v));
    this.loadMerchants();
  }

  updateGlobalSelectedMerchant(CreateUserRequest data) {
    User _updatedUser = new User(
      id: data.id,
      firstName: data.firstName,
      lastName: data.lastName,
      emailAddress: data.emailAddress,
      phoneNumber: data.phoneNumber,
      photoUrl: data.photoUrl,
      // driver: data.driverDetails,
      merchant: data.merchantDetails,
    );
    UserService.selectedMerchant.value = _updatedUser;
  }

  saveMerchant(
    CreateUserRequest data,
    BuildContext context,
    bool isUpdating,
  ) async {
    emit(
      state.updateMerchantState(createMerchantStatus: CreateMerchantStatus.loading),
    );
    try {
      var result = await UserService.createMerchant(data, isUpdating);

      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedMerchant(data);
        }
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () => {
              emit(
                state.updateMerchantState(
                  createMerchantStatus: CreateMerchantStatus.success,
                ),
              ),
              Navigator.pop(context),
              Navigator.pop(context),
              loadMerchants(),
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
      emit(state.updateMerchantState(createMerchantStatus: CreateMerchantStatus.idle));
    } catch (_) {
      emit(state.updateMerchantState(createMerchantStatus: CreateMerchantStatus.idle));
    }
  }
}

enum ListMerchantStatus { idle, loading, error }
enum MerchantInformationStatus { idle, loading, error }
enum CreateMerchantStatus { idle, loading, error, success }

class MerchantState {
  final ListMerchantStatus listMerchantStatus;
  final UserList? merchants;
  final List<User>? merchantItems;
  final int perPage;
  final CreateMerchantStatus createMerchantStatus;
  final MerchantInformationStatus merchantInformationStatus;

  MerchantState({
    this.listMerchantStatus = ListMerchantStatus.loading,
    this.merchants,
    this.merchantItems,
    this.perPage = 10,
    this.createMerchantStatus = CreateMerchantStatus.idle,
    this.merchantInformationStatus = MerchantInformationStatus.loading,
  });

  MerchantState updateMerchantState({
    ListMerchantStatus? listMerchantStatus,
    UserList? merchants,
    List<User>? merchantItems,
    int? perPage,
    CreateMerchantStatus? createMerchantStatus,
    MerchantInformationStatus? merchantInformationStatus,
  }) {
    return MerchantState(
      createMerchantStatus: createMerchantStatus ?? this.createMerchantStatus,
      perPage: perPage ?? this.perPage,
      listMerchantStatus: listMerchantStatus ?? this.listMerchantStatus,
      merchants: merchants ?? this.merchants,
      merchantItems: merchantItems ?? this.merchantItems,
    );
  }
}
