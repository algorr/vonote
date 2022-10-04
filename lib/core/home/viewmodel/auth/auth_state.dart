part of 'auth_cubit.dart';

enum AuthStatus { initial, submitting, success, error }

class AuthState extends Equatable {
  const AuthState(
      {required this.email, required this.password, required this.status});

  final String email;
  final String password;
  final AuthStatus status;

  factory AuthState.init() {
    return const AuthState(
      email: '',
      password: '',
      status: AuthStatus.initial,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    AuthStatus? status,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
