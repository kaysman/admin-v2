import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/services/enum-handling.service.dart';

enum EnumHandlingStatus { idle, loading, error }

class EnumHandlingState {
  final EnumHandlingStatus status;
  final List<String>? enumTypes;
  Map<String, List<String>> enums;

  EnumHandlingState({
    this.status = EnumHandlingStatus.idle,
    this.enumTypes,
    this.enums = const {},
  });

  EnumHandlingState copyWith({
    EnumHandlingStatus? status,
    List<String>? enumTypes,
    Map<String, List<String>>? enums,
  }) {
    return EnumHandlingState(
      status: status ?? this.status,
      enumTypes: enumTypes ?? this.enumTypes,
      enums: enums ?? this.enums,
    );
  }
}

class EnumHandlingBloc extends Cubit<EnumHandlingState> {
  EnumHandlingBloc() : super(EnumHandlingState()) {
    loadSomeEnums();
  }

  loadSomeEnums() async {
    await loadEnumsByType(EnumType.STATUS.name);
    await loadEnumsByType(EnumType.SERVICE_TYPE.name);
    await loadEnumsByType(EnumType.SERVICE_LEVEL.name);
    await loadEnumsByType(EnumType.DELIVERY_TIME_SLOT_TYPE.name);
  }

  Future<void> loadEnumTypes() async {
    emit(state.copyWith(status: EnumHandlingStatus.loading));
    try {
      var res = await EnumHandlingService.getEnumTypes();
      emit(state.copyWith(
        status: EnumHandlingStatus.idle,
        enumTypes: res,
      ));
    } catch (_) {
      emit(state.copyWith(status: EnumHandlingStatus.error));
      throw _;
    }
  }

  Future<void> loadEnumsByType(String key) async {
    emit(state.copyWith(status: EnumHandlingStatus.loading));
    try {
      List<String> res = await EnumHandlingService.getEnumsByType(key);
      var allEnums = Map<String, List<String>>.from(state.enums);
      if (res != null) allEnums[key] = res;
      emit(state.copyWith(
        status: EnumHandlingStatus.idle,
        enums: allEnums,
      ));
    } catch (_) {
      emit(state.copyWith(status: EnumHandlingStatus.error));
      throw _;
    }
  }

  Future<void> loadMultipleEnums(List<String> keys) async {
    emit(state.copyWith(status: EnumHandlingStatus.loading));
    try {
      var res = await EnumHandlingService.getEnumsByMultipleTypes(keys);
      var allEnums = state.enums;

      if (res != null) {
        res.forEach((key, value) {
          allEnums[res['enum-key']] = res['data'];
        });
      }

      emit(state.copyWith(
        status: EnumHandlingStatus.idle,
        enums: allEnums,
      ));
    } catch (_) {
      emit(state.copyWith(status: EnumHandlingStatus.error));
      throw _;
    }
  }
}
