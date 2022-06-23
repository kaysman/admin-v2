import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifecycleState {
  final AppLifecycleState? lifecycle;
  final bool? didReact;
  LifecycleState({this.lifecycle, this.didReact});

  LifecycleState copyWith({AppLifecycleState? lifecycle, bool? didReact}) {
    return LifecycleState(
      lifecycle: lifecycle ?? this.lifecycle,
      didReact: didReact ?? this.didReact,
    );
  }
}

class AppLifecycleBloc extends Cubit<LifecycleState> {
  AppLifecycleBloc()
      : super(LifecycleState(
            lifecycle: AppLifecycleState.resumed, didReact: true));

  setState(AppLifecycleState _state) {
    emit(state.copyWith(lifecycle: _state, didReact: false));
  }

  react() => emit(state.copyWith(didReact: true));
}
