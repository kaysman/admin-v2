import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/location/location-request.model.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class LocationBloc extends Cubit<LocationState> {
  LocationBloc()
      : super(LocationState(
          listLocationStatus: ListLocationStatus.loading,
          createLocationStatus: CreateLocationStatus.idle,
          locationInformationStatus: LocationInformationStatus.idle,
        )) {
    loadLocations();
  }
  loadLocations([String page = "1"]) async {
    final queryParams = <String, String>{"page": page, "limit": state.perPage};
    emit(state.updateLocationState(
        listLocationStatus: ListLocationStatus.loading));

    try {
      var locations = await LocationService.getLocations(queryParams);
      emit(state.updateLocationState(
        listLocationStatus: ListLocationStatus.idle,
        locations: locations,
        locationItems: locations.items,
      ));
    } catch (_) {
      emit(state.updateLocationState(
          listLocationStatus: ListLocationStatus.error));
      throw _;
    }
  }

  setPerPageAndLoad(String v) {
    emit(state.updateLocationState(perPage: v));
    this.loadLocations();
  }

  updateGlobalSelectedLocation(LocationRequest data) {
    Location _updatedLocation = new Location(
      id: data.id,
      address: data.address,
      name: data.name,
      size: data.size,
      type: data.type,
    );
    LocationService.selectedLocation.value = _updatedLocation;
  }

  saveLocation(
      LocationRequest data, BuildContext context, bool isUpdating) async {
    emit(
      state.updateLocationState(
          createLocationStatus: CreateLocationStatus.loading),
    );
    try {
      var result = await LocationService.createLocation(data, isUpdating);

      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedLocation(data);
        }
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () => {
              emit(
                state.updateLocationState(
                  createLocationStatus: CreateLocationStatus.success,
                ),
              ),
              Navigator.pop(context),
              Navigator.pop(context),
              loadLocations(),
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
      emit(state.updateLocationState(
          createLocationStatus: CreateLocationStatus.idle));
    } catch (_) {
      emit(state.updateLocationState(
          createLocationStatus: CreateLocationStatus.idle));
    }
  }
}

enum ListLocationStatus { idle, loading, error }
enum LocationInformationStatus { idle, loading, error }
enum CreateLocationStatus { idle, loading, error, success }

class LocationState {
  final ListLocationStatus listLocationStatus;
  final LocationList? locations;
  final List<Location>? locationItems;
  final String perPage;
  final CreateLocationStatus createLocationStatus;
  final LocationInformationStatus locationInformationStatus;

  LocationState({
    this.listLocationStatus = ListLocationStatus.loading,
    this.locations,
    this.locationItems,
    this.perPage = '10',
    this.createLocationStatus = CreateLocationStatus.idle,
    this.locationInformationStatus = LocationInformationStatus.loading,
  });

  LocationState updateLocationState(
      {ListLocationStatus? listLocationStatus,
      LocationList? locations,
      List<Location>? locationItems,
      String? perPage,
      CreateLocationStatus? createLocationStatus,
      LocationInformationStatus? locationInformationStatus}) {
    return LocationState(
      perPage: perPage ?? this.perPage,
      listLocationStatus: listLocationStatus ?? this.listLocationStatus,
      locations: locations ?? this.locations,
      locationItems: locationItems ?? this.locationItems,
      createLocationStatus: createLocationStatus ?? this.createLocationStatus,
    );
  }
}
