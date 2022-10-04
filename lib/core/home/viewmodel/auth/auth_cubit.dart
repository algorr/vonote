import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vonote/core/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthState.init());

  void changeEmail(String value) {
    emit(state.copyWith(email: value, status: AuthStatus.initial));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value, status: AuthStatus.initial));
  }

  Future<void> loginWithEmailAndPassword() async {
    if (state.status == AuthStatus.submitting) return;
    emit(state.copyWith(status: AuthStatus.submitting));

    try {
      await _repository.logIn(email: state.email, password: state.password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (_) {}
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (state.status == AuthStatus.submitting) return;
    emit(state.copyWith(status: AuthStatus.submitting));

    try {
      await _repository.signUp(email: state.email, password: state.password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (_) {}
  }

  Future<void> logOut() async {
    await _repository.logOut();
   
  }
}
