import 'package:bloc/bloc.dart';

class HttpRequestState {
  final List<String> requests;
  HttpRequestState(this.requests);
}

class HttpRequestBloc extends Cubit<HttpRequestState> {
  HttpRequestBloc() : super(HttpRequestState([]));

  add(String uri) {
    emit(HttpRequestState([uri, ...state.requests]));
  }

  remove(String uri) {
    emit(HttpRequestState(state.requests.where((r) => r != uri).toList()));
  }

  clear() {
    emit(HttpRequestState([]));
  }
}
