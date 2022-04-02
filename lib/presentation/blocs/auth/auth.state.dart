import 'package:lng_adminapp/data/models/credentials.dart';
import 'package:lng_adminapp/data/models/user.model.dart';

enum AuthStatus { authenticated, unauthenticated }
enum IdentityStatus { idle, loading, error }

class AuthState {
  final Credentials? credentials;
  final AuthStatus? status;
  final IdentityStatus? identityStatus;
  final User? identity;

  AuthState(
      {this.status, this.identityStatus, this.identity, this.credentials});

  AuthState.authenticated(Credentials credentials)
      : credentials = credentials,
        status = AuthStatus.authenticated,
        identityStatus = IdentityStatus.loading,
        identity = null;

  AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        identityStatus = IdentityStatus.idle,
        credentials = null,
        identity = null;

  AuthState copyWith({
    AuthStatus? status,
    IdentityStatus? identityStatus,
    User? identity,
  }) {
    return AuthState(
      status: status ?? this.status,
      credentials: credentials ?? this.credentials,
      identityStatus: identityStatus ?? this.identityStatus,
      identity: identity ?? this.identity,
    );
  }

  @override
  String toString() {
    return 'AuthState(credentials: $credentials, status: $status, identityStatus: $identityStatus, identity: $identity)';
  }
}
